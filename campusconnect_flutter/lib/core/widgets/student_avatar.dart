import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StudentAvatar extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final double radius;
  final bool isOrganizer;

  const StudentAvatar({
    super.key,
    required this.name,
    this.avatarUrl,
    this.radius = 24,
    this.isOrganizer = false,
  });

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (name.isNotEmpty) {
      return name.substring(0, 1).toUpperCase();
    }
    return 'CC';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isOrganizer ? AppColors.secondaryPurple : AppColors.border,
              width: isOrganizer ? 2 : 1.5,
            ),
          ),
          child: ClipOval(
            child: avatarUrl != null && avatarUrl!.startsWith('http')
                ? Image.network(
                    avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildInitials(),
                  )
                : _buildInitials(),
          ),
        ),
        if (isOrganizer)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.secondaryPurple,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.verified_rounded,
                size: 11,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInitials() {
    final hash = name.hashCode.abs();
    final colors = [
      AppColors.primaryNavy,
      AppColors.secondaryPurple,
      AppColors.accentLightBlue,
      const Color(0xFF4338CA),
      const Color(0xFF059669),
      const Color(0xFFD97706),
    ];
    final color = colors[hash % colors.length];

    return Container(
      color: color.withValues(alpha: 0.12),
      child: Center(
        child: Text(
          _initials,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: radius * 0.75,
          ),
        ),
      ),
    );
  }
}
