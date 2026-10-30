import 'package:flutter/material.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/student_avatar.dart';
import '../../core/widgets/switch_user_sheet.dart';
import '../auth/login_screen.dart';
import '../study_buddy/widgets/study_preferences_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    SessionService.instance.addListener(_refresh);
  }

  @override
  void dispose() {
    SessionService.instance.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  void _showEditProfileDialog() {
    final student = SessionService.instance.currentStudent;
    if (student == null) return;

    final nameController = TextEditingController(text: student.name);
    final bioController = TextEditingController(text: student.bio);
    final skillsController = TextEditingController(
      text: student.skills.join(', '),
    );
    final interestsController = TextEditingController(
      text: student.interests.join(', '),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.surface,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(label: 'Full Name', controller: nameController),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Bio',
                  controller: bioController,
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Skills (comma separated)',
                  controller: skillsController,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: 'Interests (comma separated)',
                  controller: interestsController,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          AppButton(
            label: 'Save Changes',
            variant: AppButtonVariant.gradient,
            onPressed: () async {
              final updated = student.copyWith(
                name: nameController.text.trim(),
                bio: bioController.text.trim(),
                skills: skillsController.text
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList(),
                interests: interestsController.text
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList(),
                updatedAt: DateTime.now(),
              );
              await SessionService.instance.updateProfile(updated);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully! ✨'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final student = SessionService.instance.currentStudent;
    final prefs = SessionService.instance.currentPreferences;

    if (student == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Center(
          child: AppButton(
            label: 'Sign In',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Student Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Profile',
            onPressed: _showEditProfileDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    StudentAvatar(
                      name: student.name,
                      avatarUrl: student.avatarUrl,
                      radius: 40,
                      isOrganizer: student.isOrganizer,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${student.branch} • ${student.academicYear}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      student.email,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    if (student.isOrganizer) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryPurpleSoft,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified_rounded,
                              size: 14,
                              color: AppColors.secondaryPurple,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'CAMPUS EVENT ORGANIZER',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondaryPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const Divider(height: 28, color: AppColors.border),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        student.bio,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Skills & Interests Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Technical Skills',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: student.skills
                          .map((s) => Chip(label: Text(s)))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Personal Interests',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: student.interests
                          .map((i) => Chip(label: Text(i)))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Study Preferences Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Study Preferences',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            StudyPreferencesSheet.show(
                              context,
                              onSaved: () => setState(() {}),
                            );
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: AppColors.secondaryPurple),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    if (prefs != null) ...[
                      Text(
                        'Subjects: ${prefs.subjects.join(", ")}',
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Study Mode: ${prefs.studyMode}',
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Timings: ${prefs.preferredTimings.join(", ")}',
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Goals: ${prefs.learningGoals.join(", ")}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ] else
                      const Text(
                        'No study preferences configured yet.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Demo Actions
            AppButton(
              label: 'Switch Student Account (Demo)',
              icon: Icons.switch_account_rounded,
              variant: AppButtonVariant.outline,
              width: double.infinity,
              onPressed: () => SwitchUserSheet.show(context),
            ),
            const SizedBox(height: 12),
            AppButton(
              label: 'Reset Demo Data to Initial State',
              icon: Icons.refresh_rounded,
              variant: AppButtonVariant.outline,
              width: double.infinity,
              onPressed: _resetDemoData,
            ),
            const SizedBox(height: 12),
            AppButton(
              label: 'Sign Out',
              icon: Icons.logout_rounded,
              variant: AppButtonVariant.danger,
              width: double.infinity,
              onPressed: () {
                SessionService.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _resetDemoData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.surface,
        title: const Text(
          'Reset Demo Data?',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'This will re-seed all sample student profiles, campus events, project collaborations, and weekly planner activities to their initial pristine state.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reset Now'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: AppColors.secondaryPurple),
        ),
      );

      try {
        await client.seed.seedInitialData(force: true);
        await SessionService.instance.initSession();
        if (mounted) {
          Navigator.pop(context); // close loading
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Demo data re-seeded successfully! ✨'),
              backgroundColor: AppColors.success,
            ),
          );
          setState(() {});
        }
      } catch (e) {
        if (mounted) {
          Navigator.pop(context); // close loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to reset demo data: $e'),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      }
    }
  }
}
