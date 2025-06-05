// lib/shared/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Primary green theme for agricultural marketplace
  static const Color primary = Color(0xFF2E7D32); // Dark green
  static const Color primaryLight = Color(0xFF4CAF50); // Medium green
  static const Color primaryDark = Color(0xFF1B5E20); // Very dark green
  
  // Secondary colors
  static const Color secondary = Color(0xFF8BC34A); // Light green
  static const Color accent = Color(0xFFFF9800); // Orange for highlights
  
  // Background colors
  static const Color background = Color(0xFFF1F8E9); // Very light green
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Specific feature colors
  static const Color sellerColor = Color(0xFF2E7D32); // Green for sellers
  static const Color buyerColor = Color(0xFF1976D2); // Blue for buyers
  static const Color adminColor = Color(0xFF7B1FA2); // Purple for admin
  
  // Border and divider colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFBDBDBD);
  
  // Button colors
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = Color(0xFFE8F5E8);
  static const Color buttonDisabled = Color(0xFFE0E0E0);
  
  // Chart/graph colors for admin dashboard
  static const List<Color> chartColors = [
    Color(0xFF4CAF50), // Green
    Color(0xFF2196F3), // Blue
    Color(0xFFFF9800), // Orange
    Color(0xFF9C27B0), // Purple
    Color(0xFFF44336), // Red
    Color(0xFF00BCD4), // Cyan
  ];
}