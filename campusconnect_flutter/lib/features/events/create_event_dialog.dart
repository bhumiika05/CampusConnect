import 'package:flutter/material.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';

class CreateEventDialog extends StatefulWidget {
  final VoidCallback onCreated;

  const CreateEventDialog({super.key, required this.onCreated});

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onCreated,
  }) {
    return showDialog(
      context: context,
      builder: (context) => CreateEventDialog(onCreated: onCreated),
    );
  }

  @override
  State<CreateEventDialog> createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  final _titleController = TextEditingController();
  final _venueController = TextEditingController();
  final _capacityController = TextEditingController(text: '100');
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Workshops';
  bool _isLoading = false;
  String? _error;

  final _categories = [
    'Workshops',
    'Competitions',
    'Seminars',
    'Tech Showcase',
    'Placement Prep',
    'Cultural',
    'Society Recruitment',
  ];

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final venue = _venueController.text.trim();
    final desc = _descriptionController.text.trim();
    final capacity = int.tryParse(_capacityController.text.trim()) ?? 100;
    final organizer = SessionService.instance.currentStudent;

    if (title.isEmpty || venue.isEmpty || organizer?.id == null) {
      setState(() => _error = 'Please fill out all required fields.');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final now = DateTime.now();
      final event = CampusEvent(
        title: title,
        description: desc.isEmpty
            ? 'Exciting campus event organized by student community.'
            : desc,
        category: _selectedCategory,
        venue: venue,
        startTime: now.add(const Duration(days: 7, hours: 14)),
        endTime: now.add(const Duration(days: 7, hours: 18)),
        organizer: organizer!.name,
        organizerId: organizer.id,
        isPublished: true,
        capacity: capacity,
        registeredCount: 0,
        bannerColor: '0xFF7C3AED',
        createdAt: now,
      );

      await client.event.createEvent(event, organizer.id!);

      if (mounted) {
        Navigator.pop(context);
        widget.onCreated();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Campus event created & published successfully! 🎉'),
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
          Icon(
            Icons.add_circle_outline_rounded,
            color: AppColors.secondaryPurple,
          ),
          SizedBox(width: 10),
          Text(
            'Create Campus Event',
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
                label: 'Event Title *',
                hint: 'e.g. Mobile App Dev & Cloud Workshop',
                controller: _titleController,
              ),
              const SizedBox(height: 12),
              const Text(
                'Category *',
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
                label: 'Campus Venue *',
                hint: 'e.g. Auditorium Hall A, Block 3',
                controller: _venueController,
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'Capacity (Max Attendees)',
                hint: '100',
                controller: _capacityController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.people_outline_rounded,
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'Description',
                hint: 'What will students learn and participate in?',
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
                    label: 'Publish Event',
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
