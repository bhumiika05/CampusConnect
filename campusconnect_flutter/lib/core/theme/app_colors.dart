import 'package:flutter/material.dart';

class AppColors {
  // Primary brand palette (Navy, Purple, Light Blue)
  static const Color primaryNavy = Color(0xFF0F172A);
  static const Color primaryNavyLight = Color(0xFF1E293B);
  static const Color primaryNavySoft = Color(0xFF334155);

  static const Color secondaryPurple = Color(0xFF7C3AED);
  static const Color secondaryPurpleLight = Color(0xFF8B5CF6);
  static const Color secondaryPurpleSoft = Color(0xFFEDE9FE);

  static const Color accentLightBlue = Color(0xFF0284C7);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentSkyLight = Color(0xFFE0F2FE);

  // Background and surfaces (Clean, vibrant light mode)
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF1F5F9);
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // Status and Badges
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF312E81), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient vibrantCardGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF0284C7), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
