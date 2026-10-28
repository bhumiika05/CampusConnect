import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class EventEndpoint extends Endpoint {
  /// Fetch all published upcoming campus events, with optional category filtering and search.
  Future<List<CampusEvent>> getEvents(
    Session session, {
    String? category,
    String? search,
  }) async {
    final allEvents = await CampusEvent.db.find(
      session,
      where: (t) => t.isPublished.equals(true),
      orderBy: (t) => t.startTime,
    );

    return allEvents.where((e) {
      if (category != null && category.isNotEmpty && category != 'All') {
        if (e.category.toLowerCase() != category.toLowerCase()) return false;
      }
      if (search != null && search.trim().isNotEmpty) {
        final query = search.toLowerCase().trim();
        final matchTitle = e.title.toLowerCase().contains(query);
        final matchDesc = e.description.toLowerCase().contains(query);
        final matchVenue = e.venue.toLowerCase().contains(query);
        final matchOrg = e.organizer.toLowerCase().contains(query);
        if (!matchTitle && !matchDesc && !matchVenue && !matchOrg) return false;
      }
      return true;
    }).toList();
  }

  /// Get details for a specific event.
  Future<CampusEvent?> getEventById(Session session, int id) async {
    return await CampusEvent.db.findById(session, id);
  }

  /// Organizer: Create a new campus event.
  Future<CampusEvent> createEvent(
    Session session,
    CampusEvent event,
    int creatorId,
  ) async {
    final profile = await StudentProfile.db.findById(session, creatorId);
    if (profile == null) {
      throw Exception('Creator profile not found.');
    }

    final now = DateTime.now();
    final toInsert = event.copyWith(
      organizer: event.organizer.isNotEmpty ? event.organizer : profile.name,
      organizerId: creatorId,
      registeredCount: 0,
      createdAt: now,
    );

    return await CampusEvent.db.insertRow(session, toInsert);
  }

  /// Organizer: Update an existing event.
  Future<CampusEvent> updateEvent(
    Session session,
    CampusEvent event,
    int organizerId,
  ) async {
    final existing = await CampusEvent.db.findById(session, event.id!);
    if (existing == null) {
      throw Exception('Event not found.');
    }

    if (existing.organizerId != null && existing.organizerId != organizerId) {
      throw Exception('Only the organizing student can update this event.');
    }

    final updated = existing.copyWith(
      title: event.title,
      description: event.description,
      category: event.category,
      venue: event.venue,
      startTime: event.startTime,
      endTime: event.endTime,
      capacity: event.capacity,
      bannerColor: event.bannerColor,
      isPublished: event.isPublished,
    );

    return await CampusEvent.db.updateRow(session, updated);
  }

  /// Organizer: Toggle publication status of an event.
  Future<bool> togglePublishEvent(
    Session session,
    int eventId,
    int organizerId,
    bool publish,
  ) async {
    final existing = await CampusEvent.db.findById(session, eventId);
    if (existing == null) {
      throw Exception('Event not found.');
    }

    if (existing.organizerId != null && existing.organizerId != organizerId) {
      throw Exception('Unauthorized to modify this event.');
    }

    final updated = existing.copyWith(isPublished: publish);
    await CampusEvent.db.updateRow(session, updated);
    return publish;
  }

  /// Organizer: Fetch events organized by this student.
  Future<List<CampusEvent>> getOrganizedEvents(
    Session session,
    int organizerId,
  ) async {
    final events = await CampusEvent.db.find(
      session,
      where: (t) => t.organizerId.equals(organizerId),
      orderBy: (t) => t.startTime,
    );
    events.sort((a, b) => b.startTime.compareTo(a.startTime));
    return events;
  }

  /// Toggle bookmark for an event.
  Future<bool> toggleBookmark(
    Session session,
    int studentId,
    int eventId,
  ) async {
    final existing = await EventBookmark.db.findFirstRow(
      session,
      where: (t) => t.studentId.equals(studentId) & t.eventId.equals(eventId),
    );

    if (existing != null) {
      await EventBookmark.db.deleteRow(session, existing);
      return false; // unbookmarked
    } else {
      await EventBookmark.db.insertRow(
        session,
        EventBookmark(
          studentId: studentId,
          eventId: eventId,
          createdAt: DateTime.now(),
        ),
      );
      return true; // bookmarked
    }
  }

  /// Get list of bookmarked event IDs for a student.
  Future<List<int>> getBookmarkedEventIds(
    Session session,
    int studentId,
  ) async {
    final bookmarks = await EventBookmark.db.find(
      session,
      where: (t) => t.studentId.equals(studentId),
    );
    return bookmarks.map((b) => b.eventId).toList();
  }
}
