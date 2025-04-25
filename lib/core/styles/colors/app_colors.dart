import 'package:flutter/material.dart';

/// Defines standard color contracts for the application
abstract class AppColors {
  MaterialColor get primary;
  MaterialColor get secondary;
  MaterialColor get black;
  MaterialColor get white;
  MaterialColor get grey;
  MaterialColor get onboardingBlue;

  Color get bgMain;
  Color get accent;
  Color get textPrimary;
  Color get textSecondary;

  Color get slateBlue;
  Color get onboardingBackground;
  Color get onboardingGradientStart;
  Color get onboardingGradientEnd;

  Color get bgMainDark;
  Color get primaryDark;
  Color get secondaryDark;
  Color get accentDark;
  Color get textPrimaryDark;
  Color get textSecondaryDark;

  Color get transparent;
}
