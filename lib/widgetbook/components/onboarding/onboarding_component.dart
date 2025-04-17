import 'package:ksk_app/features/onboarding/presentation/onboarding_page.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for OnboardingPage
WidgetbookComponent getOnboardingPageComponent() {
  return WidgetbookComponent(
    name: 'OnboardingPage',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => const OnboardingPage(),
      ),
    ],
  );
}
