// lib/core/router/app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:ksk_app/core/router/app_router.gr.dart'
    show LoginRoute, OnboardingRoute;

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: OnboardingRoute.page, initial: true),
        AutoRoute(path: '/login', page: LoginRoute.page),
      ];
}
