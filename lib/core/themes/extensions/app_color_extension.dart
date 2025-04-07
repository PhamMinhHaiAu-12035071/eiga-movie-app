import 'package:flutter/material.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Mở rộng theme với các màu sắc tùy chỉnh
@immutable
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  const AppColorExtension({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
  });

  /// Factory để tạo instance cho dark theme
  factory AppColorExtension.dark() {
    return const AppColorExtension(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      accent: AppColors.accentDark,
      textPrimary: AppColors.textPrimaryDark,
      textSecondary: AppColors.textSecondaryDark,
    );
  }

  /// Factory để tạo instance cho light theme
  factory AppColorExtension.light() {
    return const AppColorExtension(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      accent: AppColors.accent,
      textPrimary: AppColors.textPrimary,
      textSecondary: AppColors.textSecondary,
    );
  }
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;

  @override
  ThemeExtension<AppColorExtension> copyWith({
    Color? primary,
    Color? secondary,
    Color? accent,
    Color? textPrimary,
    Color? textSecondary,
  }) {
    return AppColorExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  ThemeExtension<AppColorExtension> lerp(
    covariant ThemeExtension<AppColorExtension>? other,
    double t,
  ) {
    if (other is! AppColorExtension) {
      return this;
    }

    return AppColorExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}
