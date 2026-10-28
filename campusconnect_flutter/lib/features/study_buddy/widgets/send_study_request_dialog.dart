import 'package:flutter/material.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../../client.dart';
import '../../../core/services/session_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/student_avatar.dart';

class SendStudyRequestDialog extends StatefulWidget {
  final StudentProfile recipient;

  const SendStudyRequestDialog({super.key, required this.recipient});

  static Future<void> show(BuildContext context, StudentProfile recipient) {
    return showDialog(
      context: context,
      builder: (context) => SendStudyRequestDialog(recipient: recipient),
    );
  }

  @override
  State<SendStudyRequestDialog> createState() => _SendStudyRequestDialogState();
}

class _SendStudyRequestDialogState extends State<SendStudyRequestDialog> {
  final _messageController = TextEditingController(
    text:
        'Hey! I saw our matching study interests and would love to study together.',
  );
  bool _isLoading = false;
  String? _error;

  Future<void> _send() async {
    final myId = SessionService.instance.currentStudent?.id;
    final recipientId = widget.recipient.id;

    if (myId == null || recipientId == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await client.studyRequest.sendRequest(
        myId,
        recipientId,
        _messageController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Study request sent to ${widget.recipient.name}! 📚'),
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
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      title: Row(
        children: [
          StudentAvatar(
            name: widget.recipient.name,
            avatarUrl: widget.recipient.avatarUrl,
            radius: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Connect Study Buddy',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  widget.recipient.name,
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
      content: SingleChildScrollView(
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
                  style: const TextStyle(fontSize: 12, color: AppColors.danger),
                ),
              ),
              const SizedBox(height: 12),
            ],
            AppTextField(
              label: 'Personal Note',
              hint: 'Mention what subjects you want to prepare...',
              controller: _messageController,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
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
                  label: 'Send Request',
                  variant: AppButtonVariant.gradient,
                  isLoading: _isLoading,
                  onPressed: _send,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
