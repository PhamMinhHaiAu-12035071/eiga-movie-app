import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/onboarding_logo.dart';
import 'package:ksk_app/widgetbook/mocks/mock_app_image.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for OnboardingLogo
WidgetbookComponent getOnboardingLogoComponent() {
  return WidgetbookComponent(
    name: 'OnboardingLogo',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          // Add knobs for customizing the logo
          final height = context.knobs.double.slider(
            label: 'Height',
            description: 'Height of the logo',
            min: 20,
            max: 200,
            initialValue: 56,
            divisions: 18,
          );

          // Wrap with MockAppImage provider since
          // OnboardingLogo depends on AppImage
          return MockAppImage.provider(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('OnboardingLogo with adjustable height:'),
                    const SizedBox(height: 20),
                    OnboardingLogo(height: height),
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
