import 'package:flutter/material.dart';
import 'package:ksk_app/shared/widgets/responsive_initializer.dart';
import 'package:ksk_app/widgetbook/addons/material_theme_addon.dart';
import 'package:ksk_app/widgetbook/directories.dart';
import 'package:widgetbook/widgetbook.dart';

/// Widgetbook app for showcasing components
class WidgetbookApp extends StatelessWidget {
  /// Creates a new instance of [WidgetbookApp]
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveInitializer(
      builder: (context) => Widgetbook.material(
        // Use all components organized by feature
        directories: directories,
        // Add material theme addon for light/dark themes
        addons: [
          getMaterialThemeAddon(),
        ],
      ),
    );
  }
}
