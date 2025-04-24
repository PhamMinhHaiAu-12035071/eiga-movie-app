import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/organisms/onboarding_header.dart';
import 'package:ksk_app/widgetbook/mocks/mock_app_image.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for OnboardingHeader
WidgetbookComponent getOnboardingHeaderComponent() {
  return WidgetbookComponent(
    name: 'OnboardingHeader',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          // Add knobs for customizing the header
          final title = context.knobs.string(
            label: 'Title',
            description: 'The main title of the header',
            initialValue: 'EIGA',
          );

          final subtitle = context.knobs.string(
            label: 'Subtitle',
            description: 'The subtitle text of the header',
            initialValue: 'CINEMA UI KIT.',
          );

          // Use slider directly for gap adjustment
          final gapWidth = context.knobs.double.slider(
            label: 'Gap Width',
            description: 'Adjust the width of the gap between logo and text',
            min: 8,
            max: 48,
            initialValue: 16, // Default value
            divisions: 40,
          );

          return MockAppImage.provider(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    OnboardingHeader(
                      title: title,
                      subtitle: subtitle,
                      gapWidth: gapWidth,
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
