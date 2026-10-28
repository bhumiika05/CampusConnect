import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/state_views.dart';

class CollabRequestsSheet extends StatefulWidget {
  final VoidCallback onUpdated;

  const CollabRequestsSheet({super.key, required this.onUpdated});

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onUpdated,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CollabRequestsSheet(onUpdated: onUpdated),
    );
  }

  @override
  State<CollabRequestsSheet> createState() => _CollabRequestsSheetState();
}

class _CollabRequestsSheetState extends State<CollabRequestsSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CollaborationRequest> _incoming = [];
  List<CollaborationRequest> _outgoing = [];
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
      final inc = await client.collaboration.getIncomingRequests(myId);
      final out = await client.collaboration.getOutgoingRequests(myId);

      if (mounted) {
        setState(() {
          _incoming = inc;
          _outgoing = out;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _respond(CollaborationRequest req, String status) async {
    final myId = SessionService.instance.currentStudent?.id;
    if (myId == null || req.id == null) return;

    try {
      await client.collaboration.respondToRequest(req.id!, myId, status);
      await _loadRequests();
      widget.onUpdated();
      await SessionService.instance.refreshUnreadCount();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              status == 'accepted'
                  ? 'Accepted ${req.studentName} onto the project team! 🎉'
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.group_work_rounded,
                color: AppColors.secondaryPurple,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'TeamUp Collaboration Requests',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.secondaryPurple,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.secondaryPurple,
            tabs: [
              Tab(text: 'Applicants (${_incoming.length})'),
              Tab(text: 'My Requests (${_outgoing.length})'),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _isLoading
                ? const LoadingView(message: 'Loading requests...')
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildIncomingTab(),
                      _buildOutgoingTab(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomingTab() {
    if (_incoming.isEmpty) {
      return const EmptyStateView(
        icon: Icons.assignment_turned_in_rounded,
        title: 'No Pending Applicants',
        description:
            'When peers apply to collaborate on your projects, their requests will appear here for review.',
      );
    }

    return ListView.separated(
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            req.studentName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${req.studentBranch} • For "${req.projectTitle}"',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    StatusBadge(status: req.status),
                  ],
                ),
                const SizedBox(height: 10),
                if (req.studentSkills.isNotEmpty) ...[
                  Wrap(
                    spacing: 6,
                    children: req.studentSkills
                        .map(
                          (s) => Chip(label: Text(s), padding: EdgeInsets.zero),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                ],
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '"${req.message}"',
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                if (isPending) ...[
                  const SizedBox(height: 12),
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          label: 'Accept into Team',
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
    );
  }

  Widget _buildOutgoingTab() {
    if (_outgoing.isEmpty) {
      return const EmptyStateView(
        icon: Icons.send_rounded,
        title: 'No Outgoing Applications',
        description:
            'You haven\'t applied to join any projects yet. Check out open opportunities in the TeamUp feed!',
      );
    }

    return ListView.separated(
      itemCount: _outgoing.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final req = _outgoing[index];

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        req.projectTitle,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    StatusBadge(status: req.status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Applied on ${DateFormat('MMM d, h:mm a').format(req.createdAt)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '"${req.message}"',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
