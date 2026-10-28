import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/state_views.dart';
import '../../core/widgets/student_avatar.dart';

class StudyRequestsScreen extends StatefulWidget {
  const StudyRequestsScreen({super.key});

  @override
  State<StudyRequestsScreen> createState() => _StudyRequestsScreenState();
}

class _StudyRequestsScreenState extends State<StudyRequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<StudyRequest> _incoming = [];
  List<StudyRequest> _outgoing = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadRequests() async {
    final myId = SessionService.instance.currentStudent?.id;
    if (myId == null) return;

    setState(() => _isLoading = true);

    try {
      final inc = await client.studyRequest.getIncomingRequests(myId);
      final out = await client.studyRequest.getOutgoingRequests(myId);

      if (mounted) {
        setState(() {
          _incoming = inc;
          _outgoing = out;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _respond(StudyRequest req, String status) async {
    final myId = SessionService.instance.currentStudent?.id;
    if (myId == null || req.id == null) return;

    try {
      await client.studyRequest.respondToRequest(req.id!, myId, status);
      await _loadRequests();
      await SessionService.instance.refreshUnreadCount();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              status == 'accepted'
                  ? 'Accepted study request with ${req.senderName}! 🎉'
                  : 'Declined request.',
            ),
            backgroundColor: status == 'accepted'
                ? AppColors.success
                : AppColors.textSecondary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  Future<void> _cancel(StudyRequest req) async {
    final myId = SessionService.instance.currentStudent?.id;
    if (myId == null || req.id == null) return;

    try {
      await client.studyRequest.cancelRequest(req.id!, myId);
      await _loadRequests();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Study request cancelled.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Study Buddy Requests'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.secondaryPurple,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.secondaryPurple,
          tabs: [
            Tab(text: 'Incoming (${_incoming.length})'),
            Tab(text: 'Outgoing (${_outgoing.length})'),
          ],
        ),
      ),
      body: _isLoading
          ? const LoadingView(message: 'Loading requests...')
          : TabBarView(
              controller: _tabController,
              children: [
                _buildIncomingTab(),
                _buildOutgoingTab(),
              ],
            ),
    );
  }

  Widget _buildIncomingTab() {
    if (_incoming.isEmpty) {
      return const EmptyStateView(
        icon: Icons.mark_email_read_rounded,
        title: 'No Incoming Requests',
        description:
            'When other students find your profile compatible and send you study requests, they will show up here.',
      );
    }

    return RefreshIndicator(
      onRefresh: _loadRequests,
      color: AppColors.secondaryPurple,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _incoming.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final req = _incoming[index];
          final isPending = req.status == 'pending';

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      StudentAvatar(
                        name: req.senderName,
                        avatarUrl: req.senderAvatarUrl,
                        radius: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              req.senderName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '${req.senderBranch} • ${DateFormat('MMM d, h:mm a').format(req.createdAt)}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      StatusBadge(status: req.status),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '"${req.message}"',
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (isPending) ...[
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Decline',
                            variant: AppButtonVariant.outline,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            onPressed: () => _respond(req, 'rejected'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            label: 'Accept & Connect',
                            variant: AppButtonVariant.gradient,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            onPressed: () => _respond(req, 'accepted'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOutgoingTab() {
    if (_outgoing.isEmpty) {
      return const EmptyStateView(
        icon: Icons.send_rounded,
        title: 'No Outgoing Requests',
        description:
            'You haven\'t sent any study requests yet. Browse recommended study buddies and hit Connect!',
      );
    }

    return RefreshIndicator(
      onRefresh: _loadRequests,
      color: AppColors.secondaryPurple,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _outgoing.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final req = _outgoing[index];
          final isPending = req.status == 'pending';

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      StudentAvatar(
                        name: req.recipientName,
                        radius: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              req.recipientName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Sent on ${DateFormat('MMM d, h:mm a').format(req.createdAt)}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      StatusBadge(status: req.status),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '"${req.message}"',
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (isPending) ...[
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.cancel_outlined,
                          size: 16,
                          color: AppColors.danger,
                        ),
                        label: const Text(
                          'Cancel Request',
                          style: TextStyle(
                            color: AppColors.danger,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () => _cancel(req),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
