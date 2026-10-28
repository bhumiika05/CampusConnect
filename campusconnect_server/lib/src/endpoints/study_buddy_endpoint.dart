import 'dart:math';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StudyBuddyEndpoint extends Endpoint {
  /// Fetch study preferences for a student.
  Future<StudyPreferences?> getPreferences(
    Session session,
    int studentId,
  ) async {
    return await StudyPreferences.db.findFirstRow(
      session,
      where: (t) => t.studentId.equals(studentId),
    );
  }

  /// Update or save study preferences.
  Future<StudyPreferences> updatePreferences(
    Session session,
    StudyPreferences preferences,
  ) async {
    final existing = await StudyPreferences.db.findFirstRow(
      session,
      where: (t) => t.studentId.equals(preferences.studentId),
    );

    final now = DateTime.now();

    if (existing != null) {
      final updated = existing.copyWith(
        subjects: preferences.subjects,
        technicalInterests: preferences.technicalInterests,
        preferredTimings: preferences.preferredTimings,
        studyMode: preferences.studyMode,
        learningGoals: preferences.learningGoals,
        skillLevel: preferences.skillLevel,
        updatedAt: now,
      );
      return await StudyPreferences.db.updateRow(session, updated);
    } else {
      final toInsert = preferences.copyWith(updatedAt: now);
      return await StudyPreferences.db.insertRow(session, toInsert);
    }
  }

  /// Deterministic, explainable rule-based study buddy recommendation algorithm.
  /// Weights:
  /// - Shared subjects: 40 points
  /// - Compatible study timings: 25 points
  /// - Compatible study mode: 20 points
  /// - Shared learning goals: 15 points
  /// Total: 100 points
  Future<List<StudyRecommendation>> getRecommendations(
    Session session,
    int currentStudentId,
  ) async {
    final myPrefs = await StudyPreferences.db.findFirstRow(
      session,
      where: (t) => t.studentId.equals(currentStudentId),
    );

    // Fetch all other student profiles
    final allStudents = await StudentProfile.db.find(
      session,
      where: (t) => t.id.notEquals(currentStudentId),
    );

    final allPrefs = await StudyPreferences.db.find(session);
    final prefsMap = {for (final p in allPrefs) p.studentId: p};

    final recommendations = <StudyRecommendation>[];

    for (final candidate in allStudents) {
      final candidateId = candidate.id;
      if (candidateId == null) continue;

      final candidatePrefs = prefsMap[candidateId];

      int subjectsScore = 0;
      int timingsScore = 0;
      int modeScore = 0;
      int goalsScore = 0;

      final sharedSubjects = <String>[];
      final sharedGoals = <String>[];
      bool timingMatch = false;
      bool modeMatch = false;

      if (myPrefs != null && candidatePrefs != null) {
        // 1. Shared subjects (40 points)
        final mySubs = myPrefs.subjects
            .map((s) => s.toLowerCase().trim())
            .toSet();
        final candSubs = candidatePrefs.subjects
            .map((s) => s.toLowerCase().trim())
            .toSet();
        final commonSub = mySubs.intersection(candSubs);

        for (final sub in candidatePrefs.subjects) {
          if (mySubs.contains(sub.toLowerCase().trim())) {
            sharedSubjects.add(sub);
          }
        }

        if (mySubs.isNotEmpty && candSubs.isNotEmpty && commonSub.isNotEmpty) {
          final denom = max(1, min(mySubs.length, candSubs.length));
          final ratio = min(1.0, commonSub.length / denom);
          subjectsScore = (ratio * 40).round();
        }

        // 2. Compatible timings (25 points)
        final myTimes = myPrefs.preferredTimings
            .map((t) => t.toLowerCase().trim())
            .toSet();
        final candTimes = candidatePrefs.preferredTimings
            .map((t) => t.toLowerCase().trim())
            .toSet();

        if (myTimes.contains('flexible') ||
            candTimes.contains('flexible') ||
            myTimes.contains('anytime') ||
            candTimes.contains('anytime') ||
            myTimes.intersection(candTimes).isNotEmpty) {
          timingMatch = true;
          timingsScore = 25;
        }

        // 3. Compatible study mode (20 points)
        final myMode = myPrefs.studyMode.toLowerCase().trim();
        final candMode = candidatePrefs.studyMode.toLowerCase().trim();

        if (myMode == candMode || myMode == 'hybrid' || candMode == 'hybrid') {
          modeMatch = true;
          modeScore = 20;
        }

        // 4. Shared learning goals (15 points)
        final myGoals = myPrefs.learningGoals
            .map((g) => g.toLowerCase().trim())
            .toSet();
        final candGoals = candidatePrefs.learningGoals
            .map((g) => g.toLowerCase().trim())
            .toSet();
        final commonGoals = myGoals.intersection(candGoals);

        for (final goal in candidatePrefs.learningGoals) {
          if (myGoals.contains(goal.toLowerCase().trim())) {
            sharedGoals.add(goal);
          }
        }

        if (myGoals.isNotEmpty &&
            candGoals.isNotEmpty &&
            commonGoals.isNotEmpty) {
          final denom = max(1, min(myGoals.length, candGoals.length));
          final ratio = min(1.0, commonGoals.length / denom);
          goalsScore = (ratio * 15).round();
        }
      } else if (myPrefs == null && candidatePrefs != null) {
        // Fallback default based on branch match if current user has not set prefs yet
        final myProfile = await StudentProfile.db.findById(
          session,
          currentStudentId,
        );
        if (myProfile != null && myProfile.branch == candidate.branch) {
          subjectsScore = 20;
        }
      }

      final totalScore = min(
        100,
        subjectsScore + timingsScore + modeScore + goalsScore,
      );

      final breakdown =
          'Subjects: $subjectsScore/40, Timings: $timingsScore/25, Mode: $modeScore/20, Goals: $goalsScore/15';

      recommendations.add(
        StudyRecommendation(
          student: candidate,
          preferences: candidatePrefs,
          compatibilityScore: totalScore,
          sharedSubjects: sharedSubjects,
          sharedGoals: sharedGoals,
          timingMatch: timingMatch,
          modeMatch: modeMatch,
          scoreBreakdown: breakdown,
        ),
      );
    }

    // Sort by score descending
    recommendations.sort(
      (a, b) => b.compatibilityScore.compareTo(a.compatibilityScore),
    );

    return recommendations;
  }
}
