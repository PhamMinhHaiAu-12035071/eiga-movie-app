import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/core/themes/extensions/app_asset_extension.dart';
import 'package:ksk_app/core/themes/extensions/app_color_extension.dart';

/// Lớp quản lý theme của ứng dụng
@immutable
class AppTheme {
  /// Tạo theme dark cho ứng dụng
  factory AppTheme.dark(ThemeData themeData) {
    final data = themeData.copyWith(
      scaffoldBackgroundColor: AppColors.bgMainDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgMainDark,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
    );

    final finalData = _buildThemeData(
      themeData: data,
      extensions: [
        AppAssetExtension.dark(),
        AppColorExtension.dark(),
      ],
      brightness: Brightness.dark,
    );

    return AppTheme._(finalData);
  }

  /// Tạo theme light cho ứng dụng
  factory AppTheme.light(ThemeData themeData) {
    final data = themeData.copyWith(
      scaffoldBackgroundColor: AppColors.bgMain,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgMain,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
    );

    final finalData = _buildThemeData(
      themeData: data,
      extensions: [
        AppAssetExtension.light(),
        AppColorExtension.light(),
      ],
      brightness: Brightness.light,
    );

    return AppTheme._(finalData);
  }

  const AppTheme._(this.themeData);

  /// ThemeData cơ bản của ứng dụng
  final ThemeData themeData;

  /// Xây dựng ThemeData với các thiết lập cụ thể
  static ThemeData _buildThemeData({
    required ThemeData themeData,
    required List<ThemeExtension> extensions,
    required Brightness brightness,
  }) =>
      themeData.copyWith(
        brightness: brightness,
        extensions: extensions,
        textTheme:
            GoogleFonts.montserratTextTheme(themeData.textTheme).copyWith(
          displaySmall: AppTextStyle.heading3Xl(
            color: themeData.textTheme.displaySmall?.color,
          ),
          headlineLarge: AppTextStyle.heading2Xl(
            color: themeData.textTheme.headlineLarge?.color,
          ),
          headlineMedium: AppTextStyle.headingXl(
            color: themeData.textTheme.headlineMedium?.color,
          ),
          headlineSmall: AppTextStyle.headingLg(
            color: themeData.textTheme.headlineSmall?.color,
          ),
          titleLarge: AppTextStyle.heading(
            color: themeData.textTheme.titleLarge?.color,
          ),
          titleMedium: AppTextStyle.headingSm(
            color: themeData.textTheme.titleMedium?.color,
          ),
          titleSmall: AppTextStyle.headingXs(
            color: themeData.textTheme.titleSmall?.color,
          ),
          labelLarge: AppTextStyle.bodyLg(
            fontWeight: FontWeight.w700,
            color: themeData.textTheme.labelLarge?.color,
          ),
          labelMedium: AppTextStyle.body(
            fontWeight: FontWeight.w700,
            color: themeData.textTheme.labelMedium?.color,
          ),
          labelSmall: AppTextStyle.bodySm(
            fontWeight: FontWeight.w700,
            color: themeData.textTheme.labelSmall?.color,
          ),
          bodyLarge: AppTextStyle.bodyLg(
            color: themeData.textTheme.bodyLarge?.color,
          ),
          bodyMedium: AppTextStyle.body(
            color: themeData.textTheme.bodyMedium?.color,
          ),
          bodySmall: AppTextStyle.bodySm(
            color: themeData.textTheme.bodySmall?.color,
          ),
        ),
      );
}
