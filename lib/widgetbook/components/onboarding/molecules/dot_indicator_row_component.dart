import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/dot_indicator_row.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for DotIndicatorRow
WidgetbookComponent getDotIndicatorRowComponent() {
  return WidgetbookComponent(
    name: 'DotIndicatorRow',
    useCases: [
      WidgetbookUseCase(
        name: 'Page 0/3',
        builder: (context) => const Center(
          child: DotIndicatorRow(pageCount: 3, currentIndex: 0),
        ),
      ),
      WidgetbookUseCase(
        name: 'Page 1/3',
        builder: (context) => const Center(
          child: DotIndicatorRow(pageCount: 3, currentIndex: 1),
        ),
      ),
      WidgetbookUseCase(
        name: 'Page 2/3',
        builder: (context) => const Center(
          child: DotIndicatorRow(pageCount: 3, currentIndex: 2),
        ),
      ),
      WidgetbookUseCase(
        name: '5 pages',
        builder: (context) => const Center(
          child: DotIndicatorRow(pageCount: 5, currentIndex: 2),
        ),
      ),
    ],
  );
}
