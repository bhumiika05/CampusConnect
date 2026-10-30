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
import '../copilot/campus_copilot_screen.dart';
import '../events/event_details_screen.dart';
import '../navigation/main_scaffold.dart';
import '../study_buddy/study_requests_screen.dart';
import '../study_buddy/widgets/send_study_request_dialog.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  DashboardData? _dashboardData;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
    SessionService.instance.addListener(_onSessionChange);
  }

  @override
  void dispose() {
    SessionService.instance.removeListener(_onSessionChange);
    super.dispose();
  }

  void _onSessionChange() {
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    final student = SessionService.instance.currentStudent;
    if (student?.id == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      final data = await client.dashboard.getDashboardData(student!.id!);
      if (mounted) {
        setState(() {
          _dashboardData = data;
          _isLoading = false;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingView(message: 'Loading your campus feed...');
    }

    if (_error != null) {
      return ErrorView(
        message: 'Could not load dashboard data.',
        onRetry: () {
          setState(() => _isLoading = true);
          _loadDashboard();
        },
      );
    }

    final data = _dashboardData;
    final currentStudent = SessionService.instance.currentStudent;

    return RefreshIndicator(
      onRefresh: _loadDashboard,
      color: AppColors.secondaryPurple,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Welcome & Profile Completion Banner
            _buildGreetingCard(
              currentStudent,
              data?.profileCompletionPercent ?? 80,
            ),
            const SizedBox(height: 14),

            // AI Campus Copilot Interactive Card
            _buildCopilotHeroCard(context),
            const SizedBox(height: 16),

            // Quick Actions
            _buildQuickActions(context),
            const SizedBox(height: 24),

            // Recommended Study Buddies Section
            _buildSectionHeader(
              title: 'Recommended Study Buddies',
              subtitle: 'Ranked by academic compatibility score',
              onViewAll: () {
                // Switch tab to Study Buddies
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScaffold(initialIndex: 1),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            if (data == null || data.recommendedBuddies.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'No recommendations yet. Update your study preferences!',
                ),
              )
            else
              SizedBox(
                height: 210,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.recommendedBuddies.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final rec = data.recommendedBuddies[index];
                    return _buildBuddyPreviewCard(rec);
                  },
                ),
              ),
            const SizedBox(height: 28),

            // Upcoming Campus Events Section
            _buildSectionHeader(
              title: 'Upcoming Campus Events',
              subtitle: 'Workshops, competitions & seminars',
              onViewAll: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScaffold(initialIndex: 2),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            if (data == null || data.upcomingEvents.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('No upcoming events right now.'),
              )
            else
              ...data.upcomingEvents
                  .take(3)
                  .map((event) => _buildEventCard(event)),
            const SizedBox(height: 28),

            // Open TeamUp Projects Section
            _buildSectionHeader(
              title: 'TeamUp Collaboration',
              subtitle: 'Open positions looking for teammates',
              onViewAll: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScaffold(initialIndex: 3),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            if (data == null || data.openProjects.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('No open projects right now.'),
              )
            else
              ...data.openProjects
                  .take(2)
                  .map((proj) => _buildProjectCard(proj)),
            const SizedBox(height: 28),

            // Recent Campus Activity
            if (data != null && data.recentActivities.isNotEmpty) ...[
              _buildSectionHeader(
                title: 'Recent Activity',
                subtitle: 'Your connection requests & updates',
              ),
              const SizedBox(height: 12),
              Card(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.recentActivities.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: AppColors.border),
                  itemBuilder: (context, index) {
                    final notif = data.recentActivities[index];
                    return ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: notif.isRead
                              ? AppColors.surfaceAlt
                              : AppColors.secondaryPurpleSoft,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          notif.activityType.contains('study')
                              ? Icons.people_alt_rounded
                              : notif.activityType.contains('collab')
                              ? Icons.rocket_launch_rounded
                              : Icons.event_available_rounded,
                          size: 18,
                          color: notif.isRead
                              ? AppColors.textSecondary
                              : AppColors.secondaryPurple,
                        ),
                      ),
                      title: Text(
                        notif.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: notif.isRead
                              ? FontWeight.w600
                              : FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        notif.message,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: Text(
                        DateFormat('MMM d').format(notif.createdAt),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingCard(StudentProfile? student, int completion) {
    final firstName = student?.name.split(' ').first ?? 'Student';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
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
                      'Hello, $firstName 👋',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${student?.branch ?? 'Student'} • ${student?.academicYear ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_user_rounded,
                      color: AppColors.accentCyan,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$completion% Profile',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: completion / 100,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.accentCyan,
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopilotHeroCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CampusCopilotScreen(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4338CA), Color(0xFF6D28D9), Color(0xFF0284C7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6D28D9).withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'AI Campus Copilot',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.accentCyan.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'LIVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'What should I do this week? Get a personalized 4-pillar campus roadmap.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildActionTile(
            icon: Icons.person_search_rounded,
            color: AppColors.secondaryPurple,
            label: 'Find Buddy',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScaffold(initialIndex: 1),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          _buildActionTile(
            icon: Icons.calendar_month_rounded,
            color: AppColors.accentLightBlue,
            label: 'Events',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScaffold(initialIndex: 2),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          _buildActionTile(
            icon: Icons.rocket_launch_rounded,
            color: const Color(0xFF10B981),
            label: 'TeamUp',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScaffold(initialIndex: 3),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          _buildActionTile(
            icon: Icons.event_note_rounded,
            color: const Color(0xFF6366F1),
            label: 'My Week',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScaffold(initialIndex: 4),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          _buildActionTile(
            icon: Icons.mark_email_unread_rounded,
            color: const Color(0xFFF59E0B),
            label: 'Requests',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudyRequestsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    VoidCallback? onViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: const Text(
              'View All →',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryPurple,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBuddyPreviewCard(StudyRecommendation rec) {
    final cand = rec.student;

    return Container(
      width: 200,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StudentAvatar(
                name: cand.name,
                avatarUrl: cand.avatarUrl,
                radius: 18,
              ),
              const Spacer(),
              CompatibilityScoreBadge(
                score: rec.compatibilityScore,
                showLabel: false,
                fontSize: 11,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            cand.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            '${cand.branch} • ${cand.academicYear}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          if (rec.sharedSubjects.isNotEmpty)
            Text(
              'Shared: ${rec.sharedSubjects.take(2).join(", ")}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryPurple,
              ),
            )
          else
            Text(
              rec.preferences?.studyMode != null
                  ? 'Mode: ${rec.preferences!.studyMode}'
                  : 'Active Learner',
              maxLines: 1,
              style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
          const Spacer(),
          AppButton(
            label: 'Connect',
            variant: AppButtonVariant.secondary,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            onPressed: () {
              SendStudyRequestDialog.show(context, cand);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(CampusEvent event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsScreen(event: event),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Box
              Container(
                width: 52,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.secondaryPurpleSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('MMM').format(event.startTime).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondaryPurple,
                      ),
                    ),
                    Text(
                      DateFormat('d').format(event.startTime),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondaryPurple,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryBadge(category: event.category),
                    const SizedBox(height: 6),
                    Text(
                      event.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.venue,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(ProjectListing proj) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryBadge(category: proj.category),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${proj.openPositions} SPOTS OPEN',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              proj.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              proj.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: proj.requiredSkills.map((s) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    s,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
