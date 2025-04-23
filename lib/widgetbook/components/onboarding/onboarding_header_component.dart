import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for OnboardingHeader
WidgetbookComponent getOnboardingHeaderComponent() {
  return WidgetbookComponent(
    name: 'OnboardingHeader',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => const Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                OnboardingHeader(),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
