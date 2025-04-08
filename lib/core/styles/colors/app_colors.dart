import 'package:flutter/material.dart';

/// Chứa các màu sắc cơ bản của ứng dụng
class AppColors {
  const AppColors._();

  // Main Colors as MaterialColor
  static const MaterialColor primary = MaterialColor(
    0xFF0057FF,
    {
      50: Color(0xFFE3F0FF),
      100: Color(0xFFBBD9FF),
      200: Color(0xFF8ABFFF),
      300: Color(0xFF57A5FF),
      400: Color(0xFF2A8CFF),
      500: Color(0xFF0057FF),
      600: Color(0xFF004CD9),
      700: Color(0xFF003EB3),
      800: Color(0xFF00328F),
      900: Color(0xFF002673),
    },
  );

  static const MaterialColor secondary = MaterialColor(
    0xFF4F46E5,
    {
      50: Color(0xFFEFEEFC),
      100: Color(0xFFD7D5F8),
      200: Color(0xFFB6B3F1),
      300: Color(0xFF938FEB),
      400: Color(0xFF7974E7),
      500: Color(0xFF4F46E5),
      600: Color(0xFF4840C5),
      700: Color(0xFF3C35A3),
      800: Color(0xFF312A82),
      900: Color(0xFF252069),
    },
  );

  static const MaterialColor black = MaterialColor(
    0xFF000000,
    {
      50: Color(0xFFE6E6E6),
      100: Color(0xFFCCCCCC),
      200: Color(0xFF999999),
      300: Color(0xFF666666),
      400: Color(0xFF333333),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  static const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    {
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFF7F7F7),
      700: Color(0xFFE6E6E6),
      800: Color(0xFFD6D6D6),
      900: Color(0xFFC4C4C4),
    },
  );

  static const MaterialColor grey = MaterialColor(
    0xFF9E9E9E,
    {
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F5),
      200: Color(0xFFEEEEEE),
      300: Color(0xFFE0E0E0),
      400: Color(0xFFBDBDBD),
      500: Color(0xFF9E9E9E),
      600: Color(0xFF757575),
      700: Color(0xFF616161),
      800: Color(0xFF424242),
      900: Color(0xFF212121),
    },
  );

  static const MaterialColor onboardingBlue = MaterialColor(
    0xFF7384A2,
    {
      50: Color(0xFFF0F2F6),
      100: Color(0xFFD9DEE7),
      200: Color(0xFFBFC8D8),
      300: Color(0xFFA5B2C9),
      400: Color(0xFF8A9BB8),
      500: Color(0xFF7384A2),
      600: Color(0xFF607395),
      700: Color(0xFF4C5C78),
      800: Color(0xFF3B475C),
      900: Color(0xFF2A3240),
    },
  );

  // Light Theme Colors
  static const Color bgMain = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFE0E7FF);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);

  // Onboarding Colors
  static const Color skipButtonColor = Color(0xFF607395);
  static const Color onboardingBackground = Color(0xFFE9F0F2);

  // Dark Theme Colors
  static const Color bgMainDark = Color(0xFF121212);
  static const Color primaryDark = Color(0xFF3B82F6);
  static const Color secondaryDark = Color(0xFF6366F1);
  static const Color accentDark = Color(0xFF1E293B);
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);

  // Common direct color accessors
  static const Color transparent = Colors.transparent;
}
