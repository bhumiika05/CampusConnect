import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ProfileEndpoint extends Endpoint {
  /// Fetch a student profile by their unique email.
  Future<StudentProfile?> getMyProfile(Session session, String email) async {
    return await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
  }

  /// Fetch a student profile by ID.
  Future<StudentProfile?> getProfileById(Session session, int id) async {
    return await StudentProfile.db.findById(session, id);
  }

  /// Create a new profile or update existing one.
  Future<StudentProfile> createOrUpdateProfile(
    Session session,
    StudentProfile profile,
  ) async {
    final existing = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.email.equals(profile.email),
    );

    final now = DateTime.now();

    if (existing != null) {
      final updated = existing.copyWith(
        name: profile.name,
        branch: profile.branch,
        academicYear: profile.academicYear,
        bio: profile.bio,
        avatarUrl: profile.avatarUrl,
        skills: profile.skills,
        interests: profile.interests,
        isOrganizer: profile.isOrganizer,
        updatedAt: now,
      );
      return await StudentProfile.db.updateRow(session, updated);
    } else {
      final toInsert = profile.copyWith(
        createdAt: now,
        updatedAt: now,
      );
      return await StudentProfile.db.insertRow(session, toInsert);
    }
  }

  /// Retrieve all registered students.
  Future<List<StudentProfile>> getAllStudents(Session session) async {
    return await StudentProfile.db.find(
      session,
      orderBy: (t) => t.name,
    );
  }
}
