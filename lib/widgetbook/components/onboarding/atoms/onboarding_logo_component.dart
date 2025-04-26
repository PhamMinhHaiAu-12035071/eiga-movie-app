import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:ksk_app/core/styles/colors/app_colors.dart' show AppColors;
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
          final containerSize = context.knobs.double.slider(
            label: 'Container Size',
            description: 'Size of the container (width = height)',
            min: 40,
            max: 200,
            initialValue: 59,
            divisions: 16,
          );

          final imageSize = context.knobs.double.slider(
            label: 'Image Size',
            description: 'Size of the logo image (width = height)',
            min: 20,
            max: 150,
            initialValue: 37,
            divisions: 13,
          );

          final borderRadius = context.knobs.double.slider(
            label: 'Border Radius',
            description: 'Border radius of the container',
            max: 30,
            initialValue: 12,
            divisions: 6,
          );

          final containerColor = context.knobs.color(
            label: 'Container Color',
            description: 'Background color of the container',
          );

          // Wrap with MockAppImage provider since
          // OnboardingLogo depends on AppImage
          return MockAppImage.provider(
            child: Scaffold(
              backgroundColor: GetIt.I<AppColors>().grey.shade200,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    OnboardingLogo(
                      containerSize: containerSize,
                      imageSize: imageSize,
                      borderRadius: borderRadius,
                      containerColor: containerColor,
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
