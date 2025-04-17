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
        // Add material theme addon for light/dark themes and other useful addons
        addons: [
          getMaterialThemeAddon(),
          TextScaleAddon(),
          InspectorAddon(),
          GridAddon(100),
          AlignmentAddon(),
          ZoomAddon(),
          DeviceFrameAddon(
            devices: [
              /// ios devices
              Devices.ios.iPhone12Mini,
              Devices.ios.iPhone12,
              Devices.ios.iPhone12ProMax,
              Devices.ios.iPhone13Mini,
              Devices.ios.iPhone13,
              Devices.ios.iPhone13ProMax,
              Devices.ios.iPhoneSE,
              Devices.ios.iPad,
              Devices.ios.iPadAir4,
              Devices.ios.iPadPro11Inches,
              Devices.ios.iPad12InchesGen2,
              Devices.ios.iPad12InchesGen4,

              /// android devices
              Devices.android.samsungGalaxyS20,
              Devices.android.samsungGalaxyNote20,
              Devices.android.samsungGalaxyNote20Ultra,
              Devices.android.samsungGalaxyA50,
              Devices.android.onePlus8Pro,
              Devices.android.sonyXperia1II,
              Devices.android.smallPhone,
              Devices.android.mediumPhone,
              Devices.android.bigPhone,
              Devices.android.smallTablet,
              Devices.android.mediumTablet,
              Devices.android.largeTablet,
            ],
          ),
        ],
      ),
    );
  }
}
