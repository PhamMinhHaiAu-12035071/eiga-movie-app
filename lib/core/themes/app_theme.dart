import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
    final colors = GetIt.I<AppColors>();
    final data = themeData.copyWith(
      scaffoldBackgroundColor: colors.bgMainDark,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.bgMainDark,
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
    final colors = GetIt.I<AppColors>();
    final data = themeData.copyWith(
      scaffoldBackgroundColor: colors.bgMain,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.bgMain,
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

  static final AppTextStyles _textStyles = GetIt.I<AppTextStyles>();

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
          displaySmall: _textStyles.heading3Xl(
            color: themeData.textTheme.displaySmall?.color,
          ),
          headlineLarge: _textStyles.heading2Xl(
            color: themeData.textTheme.headlineLarge?.color,
          ),
          headlineMedium: _textStyles.headingXl(
            color: themeData.textTheme.headlineMedium?.color,
          ),
          headlineSmall: _textStyles.headingLg(
            color: themeData.textTheme.headlineSmall?.color,
          ),
          titleLarge: _textStyles.heading(
            color: themeData.textTheme.titleLarge?.color,
          ),
          titleMedium: _textStyles.headingSm(
            color: themeData.textTheme.titleMedium?.color,
          ),
          titleSmall: _textStyles.headingXs(
            color: themeData.textTheme.titleSmall?.color,
          ),
          labelLarge: _textStyles.bodyLg(
            fontWeight: FontWeight.w700,
            color: themeData.textTheme.labelLarge?.color,
          ),
          labelMedium: _textStyles.body(
            fontWeight: FontWeight.w700,
            color: themeData.textTheme.labelMedium?.color,
          ),
          labelSmall: _textStyles.bodySm(
            fontWeight: FontWeight.w700,
            color: themeData.textTheme.labelSmall?.color,
          ),
          bodyLarge: _textStyles.bodyLg(
            color: themeData.textTheme.bodyLarge?.color,
          ),
          bodyMedium: _textStyles.body(
            color: themeData.textTheme.bodyMedium?.color,
          ),
          bodySmall: _textStyles.bodySm(
            color: themeData.textTheme.bodySmall?.color,
          ),
        ),
      );
}
