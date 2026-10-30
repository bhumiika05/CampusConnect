import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CompatibilityScoreBadge extends StatelessWidget {
  final int score;
  final bool showLabel;
  final double fontSize;

  const CompatibilityScoreBadge({
    super.key,
    required this.score,
    this.showLabel = true,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    if (score >= 75) {
      bg = AppColors.successLight;
      fg = AppColors.success;
    } else if (score >= 45) {
      bg = AppColors.infoLight;
      fg = AppColors.info;
    } else {
      bg = AppColors.warningLight;
      fg = AppColors.warning;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt_rounded, size: fontSize + 2, color: fg),
          const SizedBox(width: 3),
          Text(
            showLabel ? '$score% Match' : '$score%',
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String display = status.toUpperCase();

    switch (status.toLowerCase()) {
      case 'accepted':
      case 'confirmed':
      case 'open':
        bg = AppColors.successLight;
        fg = AppColors.success;
        break;
      case 'pending':
      case 'in_progress':
        bg = AppColors.warningLight;
        fg = AppColors.warning;
        break;
      case 'rejected':
      case 'cancelled':
      case 'completed':
        bg = AppColors.dangerLight;
        fg = AppColors.danger;
        break;
      default:
        bg = AppColors.surfaceAlt;
        fg = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        display,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w700,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class CategoryBadge extends StatelessWidget {
  final String category;
  final IconData? icon;

  const CategoryBadge({super.key, required this.category, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondaryPurpleSoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: AppColors.secondaryPurple),
            const SizedBox(width: 4),
          ],
          Text(
            category,
            style: const TextStyle(
              color: AppColors.secondaryPurple,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class AppBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const AppBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

