import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/state_views.dart';

class ActivityCenterScreen extends StatefulWidget {
  const ActivityCenterScreen({super.key});

  @override
  State<ActivityCenterScreen> createState() => _ActivityCenterScreenState();
}

class _ActivityCenterScreenState extends State<ActivityCenterScreen> {
  List<ActivityNotification> _activities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final studentId = SessionService.instance.currentStudent?.id;
    if (studentId == null) return;

    setState(() => _isLoading = true);

    try {
      final list = await client.activity.getMyActivities(studentId);
      if (mounted) {
        setState(() {
          _activities = list;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _markAllRead() async {
    final studentId = SessionService.instance.currentStudent?.id;
    if (studentId == null) return;

    try {
      await client.activity.markAllAsRead(studentId);
      await _load();
      await SessionService.instance.refreshUnreadCount();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All notifications marked as read.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (_) {}
  }

  Future<void> _markRead(ActivityNotification notif) async {
    final studentId = SessionService.instance.currentStudent?.id;
    if (studentId == null || notif.id == null || notif.isRead) return;

    try {
      await client.activity.markAsRead(notif.id!, studentId);
      await _load();
      await SessionService.instance.refreshUnreadCount();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _activities.where((a) => !a.isRead).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Activity Center'),
        actions: [
          if (unreadCount > 0)
            TextButton.icon(
              icon: const Icon(
                Icons.done_all_rounded,
                size: 16,
                color: AppColors.secondaryPurple,
              ),
              label: const Text(
                'Mark all read',
                style: TextStyle(
                  color: AppColors.secondaryPurple,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: _markAllRead,
            ),
        ],
      ),
      body: _isLoading
          ? const LoadingView(message: 'Loading your activity...')
          : _activities.isEmpty
          ? const EmptyStateView(
              icon: Icons.notifications_none_rounded,
              title: 'No Notifications Yet',
              description:
                  'Stay tuned! You will receive updates when students connect or projects update.',
            )
          : RefreshIndicator(
              onRefresh: _load,
              color: AppColors.secondaryPurple,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _activities.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final notif = _activities[index];

                  return Card(
                    color: notif.isRead
                        ? AppColors.surface
                        : AppColors.surfaceAlt,
                    child: InkWell(
                      onTap: () => _markRead(notif),
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: notif.isRead
                                    ? AppColors.border.withValues(alpha: 0.5)
                                    : AppColors.secondaryPurpleSoft,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                notif.activityType.contains('study')
                                    ? Icons.people_alt_rounded
                                    : notif.activityType.contains('collab')
                                    ? Icons.rocket_launch_rounded
                                    : Icons.event_available_rounded,
                                size: 20,
                                color: notif.isRead
                                    ? AppColors.textSecondary
                                    : AppColors.secondaryPurple,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          notif.title,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: notif.isRead
                                                ? FontWeight.w600
                                                : FontWeight.w700,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                      if (!notif.isRead)
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: AppColors.secondaryPurple,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notif.message,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    DateFormat(
                                      'MMM d, h:mm a',
                                    ).format(notif.createdAt),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
