import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/dot_indicator_atom.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for DotIndicatorAtom
WidgetbookComponent getDotIndicatorAtomComponent() {
  return WidgetbookComponent(
    name: 'DotIndicatorAtom',
    useCases: [
      WidgetbookUseCase(
        name: 'Active',
        builder: (context) => const Center(
          child: DotIndicatorAtom(isActive: true),
        ),
      ),
      WidgetbookUseCase(
        name: 'Inactive',
        builder: (context) => const Center(
          child: DotIndicatorAtom(isActive: false),
        ),
      ),
      WidgetbookUseCase(
        name: 'Active and Inactive together',
        builder: (context) => const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DotIndicatorAtom(isActive: true),
              SizedBox(width: 8),
              DotIndicatorAtom(isActive: false),
            ],
          ),
        ),
      ),
    ],
  );
}
