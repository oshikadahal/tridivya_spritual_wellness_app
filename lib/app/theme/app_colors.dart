import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF136767);
  static const Color primaryDark = Color(0xFF0D5555);
  static const Color primaryLight = Color(0xFF1E8A8A);

  // Secondary colors
  static const Color secondary = Color(0xFFFFA500);
  static const Color secondaryDark = Color(0xFFFFA500);
  static const Color secondaryLight = Color(0xFFFFD700);

  // Accent colors
  static const Color accent = Color(0xFFE74C3C);
  static const Color accentDark = Color(0xFFC0392B);
  static const Color accentLight = Color(0xFFF5A5A5);

  // Neutral colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyDark = Color(0xFF333333);

  // Status colors
  static const Color success = Colors.green;
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;
  static const Color info = Colors.blue;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
