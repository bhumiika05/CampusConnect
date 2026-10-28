import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class CollaborationEndpoint extends Endpoint {
  /// Send a collaboration request to join a project.
  Future<CollaborationRequest> sendRequest(
    Session session,
    int projectId,
    int studentId,
    String message,
  ) async {
    final project = await ProjectListing.db.findById(session, projectId);
    if (project == null) {
      throw Exception('Project not found.');
    }

    if (project.creatorId == studentId) {
      throw Exception('You cannot request to join your own project.');
    }

    if (project.openPositions <= 0) {
      throw Exception('This project currently has no open positions.');
    }

    // Check for existing pending or accepted request
    final existing = await CollaborationRequest.db.findFirstRow(
      session,
      where: (t) =>
          t.projectId.equals(projectId) &
          t.studentId.equals(studentId) &
          (t.status.equals('pending') | t.status.equals('accepted')),
    );

    if (existing != null) {
      throw Exception(
        'You already have an active request to join this project.',
      );
    }

    final student = await StudentProfile.db.findById(session, studentId);
    if (student == null) {
      throw Exception('Student profile not found.');
    }

    final now = DateTime.now();
    final request = CollaborationRequest(
      projectId: projectId,
      projectTitle: project.title,
      projectCreatorId: project.creatorId,
      studentId: studentId,
      studentName: student.name,
      studentBranch: student.branch,
      studentSkills: student.skills,
      message: message.trim().isEmpty
          ? 'Hi, I would love to contribute to this project!'
          : message.trim(),
      status: 'pending',
      createdAt: now,
    );

    final inserted = await CollaborationRequest.db.insertRow(session, request);

    // Notify project creator
    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: project.creatorId,
        activityType: 'collab_request',
        title: 'New TeamUp Request 🚀',
        message:
            '${student.name} requested to collaborate on "${project.title}".',
        isRead: false,
        createdAt: now,
      ),
    );

    return inserted;
  }

  /// List incoming collaboration requests for projects created by this student.
  Future<List<CollaborationRequest>> getIncomingRequests(
    Session session,
    int creatorId,
  ) async {
    final list = await CollaborationRequest.db.find(
      session,
      where: (t) => t.projectCreatorId.equals(creatorId),
      orderBy: (t) => t.createdAt,
    );
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  /// List outgoing collaboration requests made by this student.
  Future<List<CollaborationRequest>> getOutgoingRequests(
    Session session,
    int studentId,
  ) async {
    final list = await CollaborationRequest.db.find(
      session,
      where: (t) => t.studentId.equals(studentId),
      orderBy: (t) => t.createdAt,
    );
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  /// Project owner response: accept or reject the collaboration request.
  Future<CollaborationRequest> respondToRequest(
    Session session,
    int requestId,
    int creatorId,
    String status,
  ) async {
    if (status != 'accepted' && status != 'rejected') {
      throw Exception('Invalid status: must be accepted or rejected.');
    }

    final request = await CollaborationRequest.db.findById(session, requestId);
    if (request == null) {
      throw Exception('Collaboration request not found.');
    }

    if (request.projectCreatorId != creatorId) {
      throw Exception('Only the project owner can respond to this request.');
    }

    if (request.status != 'pending') {
      throw Exception('This request has already been ${request.status}.');
    }

    final project = await ProjectListing.db.findById(
      session,
      request.projectId,
    );
    if (project == null) {
      throw Exception('Project not found.');
    }

    if (status == 'accepted' && project.openPositions <= 0) {
      throw Exception('Cannot accept: all positions have been filled.');
    }

    final updated = request.copyWith(status: status);
    final saved = await CollaborationRequest.db.updateRow(session, updated);

    // If accepted, decrement open positions
    if (status == 'accepted') {
      final newOpen = project.openPositions - 1;
      await ProjectListing.db.updateRow(
        session,
        project.copyWith(
          openPositions: newOpen,
          status: newOpen == 0 ? 'in_progress' : project.status,
        ),
      );
    }

    // In-App Notification for applicant
    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: request.studentId,
        activityType: status == 'accepted'
            ? 'collab_accepted'
            : 'collab_rejected',
        title: status == 'accepted'
            ? 'TeamUp Request Accepted! 🎉'
            : 'TeamUp Request Update',
        message: status == 'accepted'
            ? 'You were accepted onto the team for "${project.title}"! Reach out to start building.'
            : 'Your request to join "${project.title}" was not accepted at this time.',
        isRead: false,
        createdAt: DateTime.now(),
      ),
    );

    return saved;
  }
}
