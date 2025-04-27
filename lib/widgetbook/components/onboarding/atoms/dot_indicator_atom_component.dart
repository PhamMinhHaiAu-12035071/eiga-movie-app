import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/dot_indicator.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for DotIndicator
WidgetbookComponent getDotIndicatorAtomComponent() {
  return WidgetbookComponent(
    name: 'DotIndicator',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          final isActive = context.knobs.boolean(
            label: 'Active',
            description: 'Toggle dot active state',
            initialValue: true,
          );

          final activeSize = context.knobs.double.slider(
            label: 'Active Size',
            description: 'Width of active dot',
            min: 8,
            max: 32,
            initialValue: 16,
          );

          final inactiveSize = context.knobs.double.slider(
            label: 'Inactive Size',
            description: 'Width and height of inactive dot',
            min: 4,
            max: 16,
            initialValue: 8,
          );

          final horizontalMargin = context.knobs.double.slider(
            label: 'Horizontal Margin',
            description: 'Horizontal spacing between dots',
            max: 16,
            initialValue: 8,
          );

          final borderRadius = context.knobs.double.slider(
            label: 'Border Radius',
            description: 'Roundness of dot corners',
            max: 16,
            initialValue: 4,
          );

          final inactiveOpacity = context.knobs.double.slider(
            label: 'Inactive Opacity',
            description: 'Opacity for inactive dot (0.0 to 1.0)',
            min: 0.1,
            max: 1,
            initialValue: 0.4,
          );

          // Colors
          final useCustomColor = context.knobs.boolean(
            label: 'Use Custom Color',
            description: 'Use a custom color instead of theme color',
          );

          final colorOptions = {
            'Blue': Colors.blue,
            'Red': Colors.red,
            'Green': Colors.green,
            'Purple': Colors.purple,
            'Orange': Colors.orange,
            'Pink': Colors.pink,
          };

          final selectedColor = context.knobs.list(
            label: 'Active Color',
            description: 'Color of the active dot',
            options: colorOptions.keys.toList(),
            initialOption: 'Blue',
          );

          return Center(
            child: DotIndicator(
              isActive: isActive,
              activeSize: activeSize,
              inactiveSize: inactiveSize,
              margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
              borderRadius: borderRadius,
              activeColor: useCustomColor ? colorOptions[selectedColor] : null,
              inactiveOpacity: inactiveOpacity,
            ),
          );
        },
      ),
    ],
  );
}
