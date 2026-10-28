import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CampusLogo extends StatelessWidget {
  final double size;
  final bool showTagline;

  const CampusLogo({
    super.key,
    this.size = 48,
    this.showTagline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: AppColors.heroGradient,
            borderRadius: BorderRadius.circular(size * 0.28),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryPurple.withValues(alpha: 0.35),
                blurRadius: size * 0.3,
                offset: Offset(0, size * 0.1),
              ),
            ],
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.hub_rounded,
                  size: size * 0.55,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
                Positioned(
                  top: size * 0.2,
                  right: size * 0.2,
                  child: Container(
                    width: size * 0.15,
                    height: size * 0.15,
                    decoration: const BoxDecoration(
                      color: AppColors.accentCyan,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showTagline) ...[
          const SizedBox(height: 12),
          const Text(
            'CampusConnect',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'One Campus. Endless Connections.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ],
    );
  }
}
