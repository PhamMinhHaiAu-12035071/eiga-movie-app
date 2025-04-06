import 'package:auto_route/auto_route.dart';
import 'package:ksk_app/features/onboarding/router/onboarding_router.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  final onBoardingRoutes = OnBoardingRouter().routes;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/onboarding/*',
          page: EmptyRouterPage.page,
          children: onBoardingRoutes,
        ),
      ];
}
