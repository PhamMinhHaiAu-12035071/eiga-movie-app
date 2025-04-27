import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/dot_indicator_row.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for DotIndicatorRow
WidgetbookComponent getDotIndicatorRowComponent() {
  return WidgetbookComponent(
    name: 'DotIndicatorRow',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          final pageCount = context.knobs.int.slider(
            label: 'Page count',
            description: 'Total number of pages',
            initialValue: 3,
            min: 1,
            max: 10,
            divisions: 9,
          );

          final rawIndex = context.knobs.int.slider(
            label: 'Current index',
            description: 'Active page indicator',
            max: 9,
            divisions: 9,
          );

          final useCustomSpacing = context.knobs.boolean(
            label: 'Use custom spacing',
            description: 'If false, will use default from context.sizes.h8',
          );

          double? spacing;
          if (useCustomSpacing) {
            spacing = context.knobs.double.slider(
              label: 'Spacing',
              description: 'Space between dots (null uses default)',
              initialValue: 8,
              max: 32,
              divisions: 32,
            );
          }

          final currentIndex = rawIndex.clamp(0, pageCount - 1);

          return Center(
            child: DotIndicatorRow(
              pageCount: pageCount,
              currentIndex: currentIndex,
              spacing: spacing,
            ),
          );
        },
      ),
    ],
  );
}
