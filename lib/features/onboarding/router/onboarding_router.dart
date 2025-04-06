// features/onboarding/onboarding_router.dart
import 'package:auto_route/auto_route.dart'
    show AutoRoute, AutoRouterConfig, RootStackRouter, StackRouter;
import 'package:ksk_app/core/router/app_router.dart';
import 'package:ksk_app/features/onboarding/presentation/onboarding_page.dart';

part 'onboarding_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class OnBoardingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '', page: OnboardingPage.page, initial: true),
      ];
}
