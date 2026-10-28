import 'package:flutter/material.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';

class CreateProjectDialog extends StatefulWidget {
  final VoidCallback onCreated;

  const CreateProjectDialog({super.key, required this.onCreated});

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onCreated,
  }) {
    return showDialog(
      context: context,
      builder: (context) => CreateProjectDialog(onCreated: onCreated),
    );
  }

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skillsController = TextEditingController(
    text: 'Flutter, Dart, REST API',
  );
  final _techController = TextEditingController(text: 'Serverpod, PostgreSQL');
  final _positionsController = TextEditingController(text: '2');

  String _selectedCategory = 'Mobile Development';
  bool _isLoading = false;
  String? _error;

  final _categories = [
    'Artificial Intelligence',
    'Web Development',
    'Mobile Development',
    'Data Analytics',
    'Cybersecurity',
    'IoT',
    'Social Impact',
    'Other',
  ];

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final desc = _descriptionController.text.trim();
    final positions = int.tryParse(_positionsController.text.trim()) ?? 2;
    final creator = SessionService.instance.currentStudent;

    if (title.isEmpty || desc.isEmpty || creator?.id == null) {
      setState(() => _error = 'Please fill out all required fields.');
      return;
    }

    final skills = _skillsController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final tech = _techController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final now = DateTime.now();
      final project = ProjectListing(
        title: title,
        description: desc,
        creatorId: creator!.id!,
        creatorName: creator.name,
        creatorBranch: creator.branch,
        techStack: tech.isEmpty ? ['Dart', 'Serverpod'] : tech,
        requiredSkills: skills.isEmpty ? ['Problem Solving'] : skills,
        category: _selectedCategory,
        totalPositions: positions,
        openPositions: positions,
        status: 'open',
        createdAt: now,
      );

      await client.project.createProject(project, creator.id!);

      if (mounted) {
        Navigator.pop(context);
        widget.onCreated();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('TeamUp project posted successfully! 🚀'),
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
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.surface,
      title: const Row(
        children: [
          Icon(Icons.rocket_launch_rounded, color: AppColors.secondaryPurple),
          SizedBox(width: 10),
          Text(
            'Post TeamUp Project',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.dangerLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _error!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.danger,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              AppTextField(
                label: 'Project Title *',
                hint: 'e.g. AI-Powered Smart Campus Navigation',
                controller: _titleController,
              ),
              const SizedBox(height: 12),
              const Text(
                'Project Category *',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                isExpanded: true,
                items: _categories
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c, style: const TextStyle(fontSize: 13)),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _selectedCategory = v);
                },
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'Open Team Positions (Number) *',
                hint: '2',
                controller: _positionsController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.group_add_rounded,
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'Required Skills (comma separated)',
                hint: 'Flutter, PyTorch, Node.js, UI/UX',
                controller: _skillsController,
                prefixIcon: Icons.code_rounded,
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'Tech Stack (comma separated)',
                hint: 'Serverpod, PostgreSQL, Flutter',
                controller: _techController,
                prefixIcon: Icons.layers_outlined,
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'Project Description *',
                hint:
                    'Describe what the project aims to solve and what teammates will build...',
                controller: _descriptionController,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AppButton(
                    label: 'Publish Project',
                    variant: AppButtonVariant.gradient,
                    isLoading: _isLoading,
                    onPressed: _submit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
