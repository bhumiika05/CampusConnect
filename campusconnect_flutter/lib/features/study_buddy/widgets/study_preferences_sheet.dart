import 'package:flutter/material.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../../core/services/session_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

class StudyPreferencesSheet extends StatefulWidget {
  final VoidCallback onSaved;

  const StudyPreferencesSheet({super.key, required this.onSaved});

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onSaved,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StudyPreferencesSheet(onSaved: onSaved),
    );
  }

  @override
  State<StudyPreferencesSheet> createState() => _StudyPreferencesSheetState();
}

class _StudyPreferencesSheetState extends State<StudyPreferencesSheet> {
  final _subjectsController = TextEditingController();
  final _interestsController = TextEditingController();

  String _studyMode = 'Hybrid';
  String _skillLevel = 'Intermediate';
  final Set<String> _selectedTimings = {};
  final Set<String> _selectedGoals = {};
  bool _isLoading = false;

  final _timingsOptions = [
    'Morning (9AM - 12PM)',
    'Afternoon (2PM - 5PM)',
    'Evening (6PM - 9PM)',
    'Late Night (9PM - 12AM)',
    'Flexible',
  ];

  final _goalsOptions = [
    'Exam Prep',
    'Skill Building',
    'Coursework Mastery',
    'Project Development',
    'Placement Prep',
    'Research Project',
  ];

  @override
  void initState() {
    super.initState();
    final prefs = SessionService.instance.currentPreferences;
    if (prefs != null) {
      _subjectsController.text = prefs.subjects.join(', ');
      _interestsController.text = prefs.technicalInterests.join(', ');
      _studyMode = prefs.studyMode;
      _skillLevel = prefs.skillLevel;
      _selectedTimings.addAll(prefs.preferredTimings);
      _selectedGoals.addAll(prefs.learningGoals);
    } else {
      _selectedTimings.add('Evening (6PM - 9PM)');
      _selectedGoals.addAll(['Exam Prep', 'Skill Building']);
    }
  }

  Future<void> _save() async {
    final studentId = SessionService.instance.currentStudent?.id;
    if (studentId == null) return;

    setState(() => _isLoading = true);

    final subjects = _subjectsController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final interests = _interestsController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final prefs = StudyPreferences(
      studentId: studentId,
      subjects: subjects.isEmpty
          ? ['Operating Systems', 'Database Systems']
          : subjects,
      technicalInterests: interests,
      preferredTimings: _selectedTimings.toList(),
      studyMode: _studyMode,
      learningGoals: _selectedGoals.toList(),
      skillLevel: _skillLevel,
      updatedAt: DateTime.now(),
    );

    await SessionService.instance.updatePreferences(prefs);

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context);
      widget.onSaved();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Study preferences updated! Recommendations refreshed. ✨',
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
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
              const Icon(Icons.tune_rounded, color: AppColors.secondaryPurple),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Study Buddy Preferences',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Tweak your preferences to tune matching recommendations',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    label: 'Subjects You Want to Study (comma separated)',
                    hint: 'e.g. Operating Systems, Networks, ML',
                    controller: _subjectsController,
                    prefixIcon: Icons.menu_book_rounded,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Preferred Study Mode',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: ['Online', 'Offline', 'Hybrid'].map((mode) {
                      final isSelected = _studyMode == mode;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(mode),
                          selected: isSelected,
                          selectedColor: AppColors.secondaryPurpleSoft,
                          onSelected: (val) {
                            if (val) setState(() => _studyMode = mode);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Preferred Study Timings',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _timingsOptions.map((time) {
                      final isSelected = _selectedTimings.contains(time);
                      return FilterChip(
                        label: Text(time),
                        selected: isSelected,
                        selectedColor: AppColors.secondaryPurpleSoft,
                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _selectedTimings.add(time);
                            } else {
                              _selectedTimings.remove(time);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Learning Goals',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _goalsOptions.map((goal) {
                      final isSelected = _selectedGoals.contains(goal);
                      return FilterChip(
                        label: Text(goal),
                        selected: isSelected,
                        selectedColor: AppColors.secondaryPurpleSoft,
                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _selectedGoals.add(goal);
                            } else {
                              _selectedGoals.remove(goal);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Current Skill Level',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: ['Beginner', 'Intermediate', 'Advanced'].map((
                      lvl,
                    ) {
                      final isSelected = _skillLevel == lvl;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(lvl),
                          selected: isSelected,
                          selectedColor: AppColors.secondaryPurpleSoft,
                          onSelected: (val) {
                            if (val) setState(() => _skillLevel = lvl);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Save Preferences',
            variant: AppButtonVariant.gradient,
            width: double.infinity,
            isLoading: _isLoading,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}
