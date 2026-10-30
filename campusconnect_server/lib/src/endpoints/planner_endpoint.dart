import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class PlannerEndpoint extends Endpoint {
  static const List<String> validDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  /// Get the full week plan for a student, synthesizing registered events
  /// and personal tasks into an organized schedule.
  Future<WeeklyPlannerSummary> getWeekPlan(
    Session session,
    int studentId,
  ) async {
    // 1. Fetch custom planner items for the student
    final customItems = await PlannerItem.db.find(
      session,
      where: (t) => t.studentId.equals(studentId),
      orderBy: (t) => t.createdAt,
    );

    // 2. Fetch confirmed event registrations for the student
    final registrations = await EventRegistration.db.find(
      session,
      where: (t) =>
          t.studentId.equals(studentId) & t.status.equals('confirmed'),
    );

    final eventIds = registrations.map((r) => r.eventId).toSet();
    final registeredEvents = eventIds.isEmpty
        ? <CampusEvent>[]
        : await CampusEvent.db.find(
            session,
            where: (t) => t.id.inSet(eventIds),
          );

    final combinedItems = <PlannerItem>[...customItems];

    // Map registered events to days of the week if not already manually added
    final existingReferenceIds = customItems
        .where((i) => i.referenceId != null)
        .map((i) => i.referenceId!)
        .toSet();

    for (final event in registeredEvents) {
      if (event.id != null && !existingReferenceIds.contains(event.id!)) {
        final dayName = _dayOfWeekFromDate(event.startTime);
        final startHour = event.startTime.hour.toString().padLeft(2, '0');
        final startMin = event.startTime.minute.toString().padLeft(2, '0');
        final endHour = event.endTime.hour.toString().padLeft(2, '0');
        final endMin = event.endTime.minute.toString().padLeft(2, '0');

        combinedItems.add(
          PlannerItem(
            studentId: studentId,
            title: event.title,
            category: 'event',
            dayOfWeek: dayName,
            timeSlot: '$startHour:$startMin - $endHour:$endMin',
            location: event.venue,
            description: event.description,
            referenceId: event.id,
            isCompleted: event.endTime.isBefore(DateTime.now()),
            createdAt: event.createdAt,
          ),
        );
      }
    }

    // Sort items by day order and time
    combinedItems.sort((a, b) {
      final dayDiff = _dayIndex(a.dayOfWeek).compareTo(_dayIndex(b.dayOfWeek));
      if (dayDiff != 0) return dayDiff;
      return a.timeSlot.compareTo(b.timeSlot);
    });

    final totalTasks = combinedItems.length;
    final completedTasks = combinedItems.where((i) => i.isCompleted).length;

    // Generate smart recommendations based on student preferences & schedule gaps
    final recommendations = await _generateRecommendations(session, studentId, combinedItems);

    return WeeklyPlannerSummary(
      items: combinedItems,
      totalTasks: totalTasks,
      completedTasks: completedTasks,
      recommendedItems: recommendations,
    );
  }

  /// Add a new personal planner task or study session
  Future<PlannerItem> addPlannerItem(
    Session session,
    PlannerItem item,
  ) async {
    final title = item.title.trim();
    if (title.isEmpty) {
      throw Exception('Task title cannot be empty.');
    }
    if (title.length > 100) {
      throw Exception('Task title cannot exceed 100 characters.');
    }

    if (!validDays.contains(item.dayOfWeek)) {
      throw Exception('Invalid day of week: ${item.dayOfWeek}');
    }

    final sanitized = item.copyWith(
      title: title,
      description: item.description?.trim(),
      location: item.location?.trim(),
      createdAt: DateTime.now(),
    );

    return await PlannerItem.db.insertRow(session, sanitized);
  }

  /// Update an existing planner item
  Future<PlannerItem> updatePlannerItem(
    Session session,
    PlannerItem item,
  ) async {
    if (item.id == null) {
      throw Exception('Item ID is required for updating.');
    }

    final existing = await PlannerItem.db.findById(session, item.id!);
    if (existing == null) {
      throw Exception('Planner item not found.');
    }

    if (existing.studentId != item.studentId) {
      throw Exception('You are not authorized to edit this planner item.');
    }

    final title = item.title.trim();
    if (title.isEmpty) {
      throw Exception('Task title cannot be empty.');
    }

    final updated = existing.copyWith(
      title: title,
      category: item.category,
      dayOfWeek: item.dayOfWeek,
      timeSlot: item.timeSlot,
      location: item.location?.trim(),
      description: item.description?.trim(),
      isCompleted: item.isCompleted,
    );

    return await PlannerItem.db.updateRow(session, updated);
  }

  /// Toggle task completion status
  Future<bool> toggleItemCompleted(
    Session session,
    int itemId,
    int studentId,
  ) async {
    final existing = await PlannerItem.db.findById(session, itemId);
    if (existing == null) {
      throw Exception('Planner item not found.');
    }

    if (existing.studentId != studentId) {
      throw Exception('You are not authorized to update this item.');
    }

    final updated = existing.copyWith(
      isCompleted: !existing.isCompleted,
    );
    await PlannerItem.db.updateRow(session, updated);
    return true;
  }

  /// Delete a custom planner task
  Future<bool> deletePlannerItem(
    Session session,
    int itemId,
    int studentId,
  ) async {
    final existing = await PlannerItem.db.findById(session, itemId);
    if (existing == null) {
      throw Exception('Planner item not found.');
    }

    if (existing.studentId != studentId) {
      throw Exception('You are not authorized to delete this item.');
    }

    await PlannerItem.db.deleteRow(session, existing);
    return true;
  }

  /// Helper to convert DateTime to day of week string
  static String _dayOfWeekFromDate(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return 'Monday';
    }
  }

  static int _dayIndex(String day) {
    final idx = validDays.indexOf(day);
    return idx >= 0 ? idx : 0;
  }

  /// Smart recommendations for open slots in the student's schedule
  Future<List<PlannerItem>> _generateRecommendations(
    Session session,
    int studentId,
    List<PlannerItem> currentItems,
  ) async {
    final recommendations = <PlannerItem>[];

    // Find student preferences
    final prefs = await StudyPreferences.db.findFirstRow(
      session,
      where: (t) => t.studentId.equals(studentId),
    );

    // Days already busy
    final busyDays = currentItems.map((i) => i.dayOfWeek).toSet();

    // Suggest focused study sessions for preferred subjects on quieter days
    final subjects = prefs?.subjects ?? ['Data Structures', 'Algorithms'];
    final candidateDays = ['Monday', 'Wednesday', 'Friday', 'Saturday']
        .where((d) => !busyDays.contains(d))
        .toList();

    if (candidateDays.isNotEmpty && subjects.isNotEmpty) {
      recommendations.add(
        PlannerItem(
          studentId: studentId,
          title: '${subjects.first} Deep Study Sprint',
          category: 'study_session',
          dayOfWeek: candidateDays.first,
          timeSlot: '05:00 PM - 06:30 PM',
          location: 'Library Quiet Zone / Virtual Room',
          description: 'Recommended focused review for your selected subject.',
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
      );
    }

    // Suggest upcoming campus workshop
    final publishedEvents = await CampusEvent.db.find(
      session,
      where: (t) => t.isPublished.equals(true),
      orderBy: (t) => t.startTime,
      limit: 3,
    );

    for (final event in publishedEvents) {
      final dayName = _dayOfWeekFromDate(event.startTime);
      final alreadyPlanned = currentItems.any((i) => i.title == event.title);
      if (!alreadyPlanned) {
        recommendations.add(
          PlannerItem(
            studentId: studentId,
            title: event.title,
            category: 'event',
            dayOfWeek: dayName,
            timeSlot: '04:00 PM - 05:30 PM',
            location: event.venue,
            description: 'Recommended campus activity matching your interests.',
            referenceId: event.id,
            isCompleted: false,
            createdAt: DateTime.now(),
          ),
        );
        break;
      }
    }

    return recommendations;
  }
}
