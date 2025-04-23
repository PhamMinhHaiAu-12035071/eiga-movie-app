import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_next_button.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for OnboardingNextButton
WidgetbookComponent getOnboardingNextButtonComponent() {
  return WidgetbookComponent(
    name: 'OnboardingNextButton',
    useCases: [
      WidgetbookUseCase(
        name: 'Interactive Demo',
        builder: (context) {
          // Use knobs for padding to demonstrate numeric controls
          final padding = context.knobs.double.slider(
            label: 'Padding',
            description: 'Adjust the padding around the button',
            initialValue: 20,
            max: 50,
          );

          // Demo button action with feedback
          void handleButtonPress() {
            // In a real app, this would do something meaningful
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Button pressed!'),
                duration: Duration(seconds: 1),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: OnboardingNextButton(
                      onPressed: handleButtonPress,
                      text: context.knobs.string(
                        label: 'Button Text',
                        description: 'Text displayed on the button',
                        initialValue: 'Next',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}
