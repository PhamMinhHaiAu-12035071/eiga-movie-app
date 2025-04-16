// test/core/router/app_router_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/router/app_router.dart';
import 'package:ksk_app/core/router/app_router.gr.dart';

void main() {
  late AppRouter appRouter;

  setUp(() {
    appRouter = AppRouter();
  });

  group('AppRouter Configuration Tests', () {
    test('routes should contain exactly two routes', () {
      // Act
      final routes = appRouter.routes;

      // Assert
      expect(routes, isNotNull);
      expect(routes.length, equals(2));
    });

    test('first route should be OnboardingRoute with correct configuration',
        () {
      // Act
      final routes = appRouter.routes;
      final onboardingRoute = routes[0];

      // Assert
      expect(onboardingRoute.path, equals('/'));
      expect(onboardingRoute.page, equals(OnboardingRoute.page));
      expect(onboardingRoute.initial, isTrue);
    });

    test('second route should be LoginRoute with correct configuration', () {
      // Act
      final routes = appRouter.routes;
      final loginRoute = routes[1];

      // Assert
      expect(loginRoute.path, equals('/login'));
      expect(loginRoute.page, equals(LoginRoute.page));
      expect(
        loginRoute.initial,
        isFalse,
      ); // initial is explicitly false for non-initial routes
    });

    test('appRouter should initialize without errors', () {
      // Just testing that initialization doesn't throw
      expect(AppRouter.new, returnsNormally);
    });
  });
}
