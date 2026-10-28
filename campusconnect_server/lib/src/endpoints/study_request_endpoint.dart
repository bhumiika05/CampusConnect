import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StudyRequestEndpoint extends Endpoint {
  /// Send a study connection request.
  Future<StudyRequest> sendRequest(
    Session session,
    int senderId,
    int recipientId,
    String message,
  ) async {
    if (senderId == recipientId) {
      throw Exception('You cannot send a study request to yourself.');
    }

    // Check for existing pending or accepted request
    final existing = await StudyRequest.db.findFirstRow(
      session,
      where: (t) =>
          ((t.senderId.equals(senderId) & t.recipientId.equals(recipientId)) |
              (t.senderId.equals(recipientId) &
                  t.recipientId.equals(senderId))) &
          (t.status.equals('pending') | t.status.equals('accepted')),
    );

    if (existing != null) {
      throw Exception(
        'An active or pending connection request already exists between you and this student.',
      );
    }

    final senderProfile = await StudentProfile.db.findById(session, senderId);
    final recipientProfile = await StudentProfile.db.findById(
      session,
      recipientId,
    );

    if (senderProfile == null || recipientProfile == null) {
      throw Exception('Student profile not found.');
    }

    final now = DateTime.now();
    final request = StudyRequest(
      senderId: senderId,
      senderName: senderProfile.name,
      senderBranch: senderProfile.branch,
      senderAvatarUrl: senderProfile.avatarUrl,
      recipientId: recipientId,
      recipientName: recipientProfile.name,
      message: message.trim().isEmpty
          ? 'Hey! Would love to study together.'
          : message.trim(),
      status: 'pending',
      createdAt: now,
      updatedAt: now,
    );

    final inserted = await StudyRequest.db.insertRow(session, request);

    // Create In-App Notification for recipient
    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: recipientId,
        activityType: 'study_request',
        title: 'New Study Request',
        message:
            '${senderProfile.name} sent you a study buddy connection request!',
        isRead: false,
        createdAt: now,
      ),
    );

    return inserted;
  }

  /// List incoming study requests.
  Future<List<StudyRequest>> getIncomingRequests(
    Session session,
    int recipientId,
  ) async {
    final list = await StudyRequest.db.find(
      session,
      where: (t) => t.recipientId.equals(recipientId),
      orderBy: (t) => t.createdAt,
    );
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  /// List outgoing study requests.
  Future<List<StudyRequest>> getOutgoingRequests(
    Session session,
    int senderId,
  ) async {
    final list = await StudyRequest.db.find(
      session,
      where: (t) => t.senderId.equals(senderId),
      orderBy: (t) => t.createdAt,
    );
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  /// Accept or reject incoming request.
  Future<StudyRequest> respondToRequest(
    Session session,
    int requestId,
    int responderId,
    String status,
  ) async {
    if (status != 'accepted' && status != 'rejected') {
      throw Exception('Invalid status: must be accepted or rejected.');
    }

    final request = await StudyRequest.db.findById(session, requestId);
    if (request == null) {
      throw Exception('Study request not found.');
    }

    if (request.recipientId != responderId) {
      throw Exception('Only the recipient can respond to this study request.');
    }

    if (request.status != 'pending') {
      throw Exception('This request is already ${request.status}.');
    }

    final now = DateTime.now();
    final updated = request.copyWith(
      status: status,
      updatedAt: now,
    );

    final saved = await StudyRequest.db.updateRow(session, updated);

    // Notify sender of outcome
    final recipientProfile = await StudentProfile.db.findById(
      session,
      responderId,
    );
    final recipientName = recipientProfile?.name ?? 'A student';

    await ActivityNotification.db.insertRow(
      session,
      ActivityNotification(
        recipientId: request.senderId,
        activityType: status == 'accepted'
            ? 'study_accepted'
            : 'study_rejected',
        title: status == 'accepted'
            ? 'Study Request Accepted! 🎉'
            : 'Study Request Update',
        message: status == 'accepted'
            ? '$recipientName accepted your study request. You can now coordinate study sessions!'
            : '$recipientName declined your study request.',
        isRead: false,
        createdAt: now,
      ),
    );

    return saved;
  }

  /// Cancel outgoing pending request.
  Future<StudyRequest> cancelRequest(
    Session session,
    int requestId,
    int senderId,
  ) async {
    final request = await StudyRequest.db.findById(session, requestId);
    if (request == null) {
      throw Exception('Study request not found.');
    }

    if (request.senderId != senderId) {
      throw Exception('Only the sender can cancel this request.');
    }

    if (request.status != 'pending') {
      throw Exception('Only pending requests can be cancelled.');
    }

    final updated = request.copyWith(
      status: 'cancelled',
      updatedAt: DateTime.now(),
    );

    return await StudyRequest.db.updateRow(session, updated);
  }
}
