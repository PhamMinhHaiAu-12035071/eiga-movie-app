import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_subtitle.dart';
// Import the mock classes from header_title_component.dart
import 'package:ksk_app/widgetbook/components/onboarding/atoms/header_title_component.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for HeaderSubtitle
WidgetbookComponent getHeaderSubtitleComponent() {
  return WidgetbookComponent(
    name: 'HeaderSubtitle',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          // Add knobs for customizing the subtitle
          final text = context.knobs.string(
            label: 'Subtitle Text',
            description: 'Text to display as the subtitle',
            initialValue: 'CINEMA UI KIT.',
          );

          final textColor = context.knobs.color(
            label: 'Text Color',
            description: 'Color of the subtitle text',
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
                    const Text('Header Subtitle Component:'),
                    const SizedBox(height: 20),
                    // Use the header subtitle with mocked dependencies
                    HeaderSubtitle(
                      text: text,
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
