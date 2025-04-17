import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_dot_indicator.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for OnboardingDotIndicator
WidgetbookComponent getDotIndicatorComponent() {
  return WidgetbookComponent(
    name: 'OnboardingDotIndicator',
    useCases: [
      WidgetbookUseCase(
        name: 'Page 0/3',
        builder: (context) =>
            const OnboardingDotIndicator(pageCount: 3, currentIndex: 0),
      ),
      WidgetbookUseCase(
        name: 'Page 1/3',
        builder: (context) =>
            const OnboardingDotIndicator(pageCount: 3, currentIndex: 1),
      ),
      WidgetbookUseCase(
        name: 'Page 2/3',
        builder: (context) =>
            const OnboardingDotIndicator(pageCount: 3, currentIndex: 2),
      ),
    ],
  );
}
