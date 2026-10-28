import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ActivityEndpoint extends Endpoint {
  /// Fetch recent activity notifications for a student.
  Future<List<ActivityNotification>> getMyActivities(
    Session session,
    int recipientId,
  ) async {
    final list = await ActivityNotification.db.find(
      session,
      where: (t) => t.recipientId.equals(recipientId),
      orderBy: (t) => t.createdAt,
      limit: 50,
    );
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  /// Mark a single notification as read.
  Future<bool> markAsRead(
    Session session,
    int notificationId,
    int recipientId,
  ) async {
    final notif = await ActivityNotification.db.findById(
      session,
      notificationId,
    );
    if (notif == null) return false;
    if (notif.recipientId != recipientId) return false;

    await ActivityNotification.db.updateRow(
      session,
      notif.copyWith(isRead: true),
    );
    return true;
  }

  /// Mark all notifications as read for a student.
  Future<bool> markAllAsRead(Session session, int recipientId) async {
    final unread = await ActivityNotification.db.find(
      session,
      where: (t) => t.recipientId.equals(recipientId) & t.isRead.equals(false),
    );

    for (final notif in unread) {
      await ActivityNotification.db.updateRow(
        session,
        notif.copyWith(isRead: true),
      );
    }
    return true;
  }
}
