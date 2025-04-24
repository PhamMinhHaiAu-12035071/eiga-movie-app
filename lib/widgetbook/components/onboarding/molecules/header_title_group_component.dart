import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/header_title_group.dart';
// Import the mock classes from header_title_component.dart
import 'package:ksk_app/widgetbook/components/onboarding/atoms/header_title_component.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for HeaderTitleGroup
WidgetbookComponent getHeaderTitleGroupComponent() {
  return WidgetbookComponent(
    name: 'HeaderTitleGroup',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          // Add knobs for customizing the title group
          final title = context.knobs.string(
            label: 'Title',
            description: 'Main title text',
            initialValue: 'EIGA',
          );

          final subtitle = context.knobs.string(
            label: 'Subtitle',
            description: 'Subtitle text',
            initialValue: 'CINEMA UI KIT.',
          );

          final textColor = context.knobs.color(
            label: 'Text Color',
            description: 'Color of the text',
            initialValue: Colors.black,
          );

          // Create mocks for the component
          final mockTextStyles = TextStylesMock();
          final mockColors = ColorsMock(textColor);

          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Header Title Group Component:'),
                    const SizedBox(height: 20),
                    // Use the header title group with mocked dependencies
                    HeaderTitleGroup(
                      title: title,
                      subtitle: subtitle,
                      textStyles: mockTextStyles,
                      colors: mockColors,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}
