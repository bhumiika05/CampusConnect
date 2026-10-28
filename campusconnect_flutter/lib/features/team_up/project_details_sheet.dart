import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';

class ProjectDetailsSheet extends StatefulWidget {
  final ProjectListing project;
  final VoidCallback onApplied;

  const ProjectDetailsSheet({
    super.key,
    required this.project,
    required this.onApplied,
  });

  static Future<void> show(
    BuildContext context, {
    required ProjectListing project,
    required VoidCallback onApplied,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          ProjectDetailsSheet(project: project, onApplied: onApplied),
    );
  }

  @override
  State<ProjectDetailsSheet> createState() => _ProjectDetailsSheetState();
}

class _ProjectDetailsSheetState extends State<ProjectDetailsSheet> {
  final _messageController = TextEditingController(
    text:
        'Hi! I would love to contribute to this project. I have experience with the required tech stack.',
  );
  bool _showApplyForm = false;
  bool _isLoading = false;
  String? _error;

  Future<void> _apply() async {
    final studentId = SessionService.instance.currentStudent?.id;
    if (studentId == null || widget.project.id == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await client.collaboration.sendRequest(
        widget.project.id!,
        studentId,
        _messageController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);
        widget.onApplied();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Collaboration application sent to project owner! 🚀',
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString().replaceAll('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final proj = widget.project;
    final currentStudent = SessionService.instance.currentStudent;
    final isMyProject = currentStudent?.id == proj.creatorId;
    final isFull = proj.openPositions <= 0;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryBadge(category: proj.category),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isFull
                      ? AppColors.dangerLight
                      : AppColors.successLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isFull
                      ? 'ALL POSITIONS FILLED'
                      : '${proj.openPositions} SPOTS REMAINING',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isFull ? AppColors.danger : AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            proj.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Created by ${proj.creatorName} (${proj.creatorBranch}) • ${DateFormat('MMM d').format(proj.createdAt)}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About the Project',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    proj.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Required Skills',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: proj.requiredSkills
                        .map((s) => Chip(label: Text(s)))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tech Stack',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: proj.techStack.map((t) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryPurpleSoft,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          t,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryPurple,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (_showApplyForm) ...[
                    const SizedBox(height: 20),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: 10),
                    const Text(
                      'Application Message',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_error != null) ...[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.dangerLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.danger,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    AppTextField(
                      label: 'Introduce Yourself & Your Role',
                      hint: 'What skills can you contribute to this project?',
                      controller: _messageController,
                      maxLines: 3,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (isMyProject)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'This is your project. Use "Manage Collaborations" to review applicants.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            )
          else if (!_showApplyForm)
            AppButton(
              label: isFull ? 'Positions Filled' : 'Apply to Join Team',
              icon: Icons.send_rounded,
              variant: AppButtonVariant.gradient,
              width: double.infinity,
              onPressed: isFull
                  ? null
                  : () => setState(() => _showApplyForm = true),
            )
          else
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Back',
                    variant: AppButtonVariant.outline,
                    onPressed: () => setState(() => _showApplyForm = false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    label: 'Submit Application',
                    variant: AppButtonVariant.gradient,
                    isLoading: _isLoading,
                    onPressed: _apply,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
