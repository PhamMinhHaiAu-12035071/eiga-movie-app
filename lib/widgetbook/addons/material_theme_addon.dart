import 'package:flutter/material.dart';
import 'package:ksk_app/core/themes/app_theme.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a MaterialThemeAddon with light and dark themes
MaterialThemeAddon getMaterialThemeAddon() {
  return MaterialThemeAddon(
    themes: [
      WidgetbookTheme(
        name: 'Light',
        data: AppTheme.light(ThemeData.light()).themeData,
      ),
      WidgetbookTheme(
        name: 'Dark',
        data: AppTheme.dark(ThemeData.dark()).themeData,
      ),
    ],
  );
}
