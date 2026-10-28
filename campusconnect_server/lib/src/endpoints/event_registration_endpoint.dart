import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class EventRegistrationEndpoint extends Endpoint {
  /// Register a student for a campus event.
  Future<EventRegistration> registerForEvent(
    Session session,
    int studentId,
    int eventId,
  ) async {
    final event = await CampusEvent.db.findById(session, eventId);
    if (event == null) {
      throw Exception('Event not found.');
    }

    if (!event.isPublished) {
      throw Exception('Cannot register for an unpublished event.');
    }

    // Check capacity
    if (event.capacity > 0 && event.registeredCount >= event.capacity) {
      throw Exception('Event capacity has been reached. Registration is full.');
    }

    // Check existing registration
    final existing = await EventRegistration.db.findFirstRow(
      session,
      where: (t) =>
          t.studentId.equals(studentId) &
          t.eventId.equals(eventId) &
          t.status.equals('confirmed'),
    );

    if (existing != null) {
      throw Exception('You are already registered for this event.');
    }

    final student = await StudentProfile.db.findById(session, studentId);
    if (student == null) {
      throw Exception('Student profile not found.');
    }

    final now = DateTime.now();
    final registration = EventRegistration(
      studentId: studentId,
      studentName: student.name,
      studentEmail: student.email,
      eventId: eventId,
      eventTitle: event.title,
      status: 'confirmed',
      createdAt: now,
    );

    final inserted = await EventRegistration.db.insertRow(
      session,
      registration,
    );

    // Increment registered count
    final updatedEvent = event.copyWith(
      registeredCount: event.registeredCount + 1,
    );
    await CampusEvent.db.updateRow(session, updatedEvent);

    // In-App Notification
    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: studentId,
        activityType: 'event_registered',
        title: 'Event Registration Confirmed! 🎟️',
        message:
            'You have successfully secured a spot for "${event.title}". See you there!',
        isRead: false,
        createdAt: now,
      ),
    );

    return inserted;
  }

  /// Cancel an existing event registration.
  Future<bool> cancelRegistration(
    Session session,
    int studentId,
    int eventId,
  ) async {
    final existing = await EventRegistration.db.findFirstRow(
      session,
      where: (t) =>
          t.studentId.equals(studentId) &
          t.eventId.equals(eventId) &
          t.status.equals('confirmed'),
    );

    if (existing == null) {
      throw Exception('No active registration found for this event.');
    }

    final updated = existing.copyWith(status: 'cancelled');
    await EventRegistration.db.updateRow(session, updated);

    // Decrement registered count
    final event = await CampusEvent.db.findById(session, eventId);
    if (event != null && event.registeredCount > 0) {
      await CampusEvent.db.updateRow(
        session,
        event.copyWith(registeredCount: event.registeredCount - 1),
      );
    }

    return true;
  }

  /// List registrations for a student.
  Future<List<EventRegistration>> getMyRegistrations(
    Session session,
    int studentId,
  ) async {
    final list = await EventRegistration.db.find(
      session,
      where: (t) =>
          t.studentId.equals(studentId) & t.status.equals('confirmed'),
      orderBy: (t) => t.createdAt,
    );
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  /// Organizer: View attendee registrations for an event.
  Future<List<EventRegistration>> getEventRegistrations(
    Session session,
    int eventId,
    int organizerId,
  ) async {
    final event = await CampusEvent.db.findById(session, eventId);
    if (event == null) {
      throw Exception('Event not found.');
    }

    if (event.organizerId != null && event.organizerId != organizerId) {
      throw Exception('Unauthorized to view registrations for this event.');
    }

    return await EventRegistration.db.find(
      session,
      where: (t) => t.eventId.equals(eventId) & t.status.equals('confirmed'),
      orderBy: (t) => t.createdAt,
    );
  }
}
