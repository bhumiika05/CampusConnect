import 'package:flutter/material.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/state_views.dart';
import '../../core/widgets/student_avatar.dart';
import 'study_requests_screen.dart';
import 'widgets/send_study_request_dialog.dart';
import 'widgets/study_preferences_sheet.dart';

class StudyBuddyScreen extends StatefulWidget {
  const StudyBuddyScreen({super.key});

  @override
  State<StudyBuddyScreen> createState() => _StudyBuddyScreenState();
}

class _StudyBuddyScreenState extends State<StudyBuddyScreen> {
  List<StudyRecommendation> _allRecommendations = [];
  bool _isLoading = true;
  String? _error;

  String _searchQuery = '';
  String _selectedMode = 'All';
  String _selectedBranch = 'All';

  final _branches = [
    'All',
    'Computer Science',
    'Artificial Intelligence & DS',
    'Information Technology',
    'Electronics & Communication',
    'Data Science',
    'Mechanical & Automation',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
    SessionService.instance.addListener(_onSessionChange);
  }

  @override
  void dispose() {
    SessionService.instance.removeListener(_onSessionChange);
    super.dispose();
  }

  void _onSessionChange() {
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    final student = SessionService.instance.currentStudent;
    if (student?.id == null) return;

    setState(() => _isLoading = true);

    try {
      final recs = await client.studyBuddy.getRecommendations(student!.id!);
      if (mounted) {
        setState(() {
          _allRecommendations = recs;
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

  List<StudyRecommendation> get _filteredRecommendations {
    return _allRecommendations.where((rec) {
      final cand = rec.student;

      // Mode filter
      if (_selectedMode != 'All') {
        final mode = rec.preferences?.studyMode;
        if (mode != null && mode.toLowerCase() != _selectedMode.toLowerCase()) {
          return false;
        }
      }

      // Branch filter
      if (_selectedBranch != 'All') {
        if (cand.branch.toLowerCase() != _selectedBranch.toLowerCase()) {
          return false;
        }
      }

      // Keyword search
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.toLowerCase().trim();
        final matchName = cand.name.toLowerCase().contains(q);
        final matchBranch = cand.branch.toLowerCase().contains(q);
        final matchBio = cand.bio.toLowerCase().contains(q);
        final matchSkills = cand.skills.any((s) => s.toLowerCase().contains(q));
        final matchSubjects =
            rec.preferences?.subjects.any((s) => s.toLowerCase().contains(q)) ??
            false;
        if (!matchName &&
            !matchBranch &&
            !matchBio &&
            !matchSkills &&
            !matchSubjects) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecommendations;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Study Buddy Finder',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Discover study partners matched by subjects & schedules',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // My Preferences Action
                      IconButton(
                        icon: const Icon(
                          Icons.tune_rounded,
                          color: AppColors.secondaryPurple,
                        ),
                        tooltip: 'Edit Study Preferences',
                        onPressed: () {
                          StudyPreferencesSheet.show(
                            context,
                            onSaved: _loadRecommendations,
                          );
                        },
                      ),
                      // Requests Action
                      IconButton(
                        icon: const Icon(
                          Icons.mail_outline_rounded,
                          color: AppColors.primaryNavy,
                        ),
                        tooltip: 'View Requests',
                        onPressed: () {
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
                  const SizedBox(height: 12),
                  // Search Bar
                  TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search by subject, skill, or student name...',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.textMuted,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 18),
                              onPressed: () =>
                                  setState(() => _searchQuery = ''),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Filter chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Study Mode chips
                        ...['All', 'Online', 'Offline', 'Hybrid'].map((mode) {
                          final isSelected = _selectedMode == mode;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(mode == 'All' ? 'All Modes' : mode),
                              selected: isSelected,
                              selectedColor: AppColors.secondaryPurpleSoft,
                              onSelected: (val) {
                                if (val) setState(() => _selectedMode = mode);
                              },
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        // Branch filter dropdown
                        DropdownButton<String>(
                          value: _selectedBranch,
                          underline: const SizedBox(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          items: _branches.map((b) {
                            return DropdownMenuItem(
                              value: b,
                              child: Text(b == 'All' ? 'All Branches' : b),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedBranch = val);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: _isLoading
            ? const LoadingView(message: 'Calculating matching scores...')
            : _error != null
            ? ErrorView(message: _error!, onRetry: _loadRecommendations)
            : filtered.isEmpty
            ? const EmptyStateView(
                icon: Icons.person_off_rounded,
                title: 'No Matching Study Buddies',
                description:
                    'Try adjusting your search query or reset your filters.',
              )
            : RefreshIndicator(
                onRefresh: _loadRecommendations,
                color: AppColors.secondaryPurple,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final rec = filtered[index];
                    return _buildStudentCard(rec);
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildStudentCard(StudyRecommendation rec) {
    final cand = rec.student;
    final prefs = rec.preferences;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Avatar, Info, Compatibility Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StudentAvatar(
                  name: cand.name,
                  avatarUrl: cand.avatarUrl,
                  radius: 24,
                  isOrganizer: cand.isOrganizer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              cand.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => _showScoreBreakdownDialog(rec),
                            child: CompatibilityScoreBadge(
                              score: rec.compatibilityScore,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${cand.branch} • ${cand.academicYear}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Short Bio
            Text(
              cand.bio,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),

            // Shared Subjects highlight
            if (rec.sharedSubjects.isNotEmpty) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shared: ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryPurple,
                    ),
                  ),
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: rec.sharedSubjects.map((s) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryPurpleSoft,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            s,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryPurple,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],

            // Preferred mode & timing indicators
            if (prefs != null) ...[
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        prefs.studyMode == 'Online'
                            ? Icons.laptop_chromebook_rounded
                            : prefs.studyMode == 'Offline'
                            ? Icons.location_city_rounded
                            : Icons.sync_alt_rounded,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Mode: ${prefs.studyMode}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (prefs.preferredTimings.isNotEmpty)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          prefs.preferredTimings.first,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // Skills chips
            if (cand.skills.isNotEmpty) ...[
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: cand.skills.take(4).map((skill) {
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
                      skill,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 14),
            ],

            // Action Buttons: View Profile & Connect
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'View Profile',
                    variant: AppButtonVariant.outline,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    onPressed: () => _showStudentProfileModal(rec),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    label: 'Connect',
                    icon: Icons.send_rounded,
                    variant: AppButtonVariant.gradient,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {
                      SendStudyRequestDialog.show(context, cand);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showScoreBreakdownDialog(StudyRecommendation rec) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.surface,
        title: Row(
          children: [
            const Icon(
              Icons.calculate_rounded,
              color: AppColors.secondaryPurple,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Compatibility Breakdown',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Match with ${rec.student.name}: ${rec.compatibilityScore}%',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Preference-based compatibility score computed by the Serverpod deterministic algorithm:',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 14),
            _buildScoreItem(
              'Shared Subjects',
              'Up to 40 pts',
              rec.sharedSubjects.isNotEmpty ? 'Overlap found' : 'No overlap',
            ),
            _buildScoreItem(
              'Study Timings',
              'Up to 25 pts',
              rec.timingMatch ? 'Compatible schedule' : 'Different hours',
            ),
            _buildScoreItem(
              'Study Mode',
              'Up to 20 pts',
              rec.modeMatch ? 'Matching or Hybrid' : 'Mismatched mode',
            ),
            _buildScoreItem(
              'Learning Goals',
              'Up to 15 pts',
              rec.sharedGoals.isNotEmpty
                  ? '${rec.sharedGoals.length} shared goals'
                  : 'Different goals',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                rec.scoreBreakdown,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textPrimary,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem(String title, String maxPts, String result) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          Text(
            result,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryPurple,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showStudentProfileModal(StudyRecommendation rec) {
    final cand = rec.student;
    final prefs = rec.preferences;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: StudentAvatar(
                  name: cand.name,
                  avatarUrl: cand.avatarUrl,
                  radius: 36,
                  isOrganizer: cand.isOrganizer,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  cand.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${cand.branch} • ${cand.academicYear}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: CompatibilityScoreBadge(score: rec.compatibilityScore),
              ),
              const SizedBox(height: 20),
              const Text(
                'About',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                cand.bio,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              if (prefs != null) ...[
                const Text(
                  'Subjects Looking to Study',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: prefs.subjects
                      .map((s) => Chip(label: Text(s)))
                      .toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Preferred Timings & Mode',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  'Mode: ${prefs.studyMode} | Level: ${prefs.skillLevel}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  'Times: ${prefs.preferredTimings.join(", ")}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              const Text(
                'Technical Skills',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: cand.skills.map((s) => Chip(label: Text(s))).toList(),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Send Study Request',
                variant: AppButtonVariant.gradient,
                width: double.infinity,
                onPressed: () {
                  Navigator.pop(context);
                  SendStudyRequestDialog.show(context, cand);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
