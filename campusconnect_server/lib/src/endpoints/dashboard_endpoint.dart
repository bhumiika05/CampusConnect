import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'study_buddy_endpoint.dart';

class DashboardEndpoint extends Endpoint {
  /// Aggregates personalized dashboard data for a student.
  Future<DashboardData> getDashboardData(
    Session session,
    int studentId,
  ) async {
    final profile = await StudentProfile.db.findById(session, studentId);

    // Profile completion percent calculation
    int completion = 0;
    if (profile != null) {
      int fieldsCompleted = 0;
      const totalFields = 8;
      if (profile.name.isNotEmpty) {
        fieldsCompleted++;
      }
      if (profile.branch.isNotEmpty) {
        fieldsCompleted++;
      }
      if (profile.academicYear.isNotEmpty) {
        fieldsCompleted++;
      }
      if (profile.bio.isNotEmpty) {
        fieldsCompleted++;
      }
      if (profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty) {
        fieldsCompleted++;
      }
      if (profile.skills.isNotEmpty) {
        fieldsCompleted++;
      }
      if (profile.interests.isNotEmpty) {
        fieldsCompleted++;
      }

      final prefs = await StudyPreferences.db.findFirstRow(
        session,
        where: (t) => t.studentId.equals(studentId),
      );
      if (prefs != null && prefs.subjects.isNotEmpty) {
        fieldsCompleted++;
      }

      completion = ((fieldsCompleted / totalFields) * 100).round();
    }

    // Get recommendations
    final studyBuddyEndpoint = StudyBuddyEndpoint();
    final allRecommendations = await studyBuddyEndpoint.getRecommendations(
      session,
      studentId,
    );
    final topRecommendations = allRecommendations.take(4).toList();

    // Get upcoming published events
    final events = await CampusEvent.db.find(
      session,
      where: (t) => t.isPublished.equals(true),
      orderBy: (t) => t.startTime,
      limit: 5,
    );

    // Get open projects
    final projects = await ProjectListing.db.find(
      session,
      where: (t) => t.status.equals('open'),
      orderBy: (t) => t.createdAt,
      limit: 4,
    );
    projects.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Get recent activities
    final activities = await ActivityNotification.db.find(
      session,
      where: (t) => t.recipientId.equals(studentId),
      orderBy: (t) => t.createdAt,
      limit: 6,
    );
    activities.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Unread notification count
    final unreadCount = await ActivityNotification.db.count(
      session,
      where: (t) => t.recipientId.equals(studentId) & t.isRead.equals(false),
    );

    return DashboardData(
      profile: profile,
      recommendedBuddies: topRecommendations,
      upcomingEvents: events,
      openProjects: projects,
      recentActivities: activities,
      profileCompletionPercent: completion,
      unreadNotificationCount: unreadCount,
    );
  }
}
