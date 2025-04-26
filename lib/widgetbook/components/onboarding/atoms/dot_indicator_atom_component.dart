import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/dot_indicator_atom.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for DotIndicatorAtom
WidgetbookComponent getDotIndicatorAtomComponent() {
  return WidgetbookComponent(
    name: 'DotIndicatorAtom',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          final isActive = context.knobs.boolean(
            label: 'Active',
            description: 'Toggle dot active state',
            initialValue: true,
          );

          return Center(
            child: DotIndicatorAtom(isActive: isActive),
          );
        },
      ),
    ],
  );
}
