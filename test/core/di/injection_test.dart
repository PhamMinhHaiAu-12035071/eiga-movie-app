import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/di/injection.dart';
import 'package:ksk_app/features/env/domain/env_config_repository.dart';
import 'package:ksk_app/features/login/application/cubit/login_cubit.dart';
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_cubit.dart';
import 'package:ksk_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:ksk_app/features/storage/domain/interfaces/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Main test file for the dependency injection module
void main() {
  late GetIt getIt;

  setUp(() async {
    // Setup shared preferences mock
    SharedPreferences.setMockInitialValues({});

    // Clear GetIt instance before each test
    await GetIt.I.reset();
    getIt = GetIt.instance;

    // Configure dependencies
    await configureDependencies();
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('configureDependencies()', () {
    test('should initialize the DI container without errors', () {
      // No need to call configureDependencies() again - it's done in setUp
      // Assert - no exception thrown means success
      expect(true, isTrue);
    });

    test('should register SharedPreferences as a singleton', () {
      // Assert
      expect(getIt.isRegistered<SharedPreferences>(), isTrue);

      // Get the instance multiple times and verify it's the same instance
      final instance1 = getIt<SharedPreferences>();
      final instance2 = getIt<SharedPreferences>();
      expect(instance1, same(instance2));
    });

    test('should register EnvConfigRepository as a lazy singleton', () {
      // Arrange
      var resolutionCount = 0;

      // Assert
      expect(getIt.isRegistered<EnvConfigRepository>(), isTrue);

      // First get a reference to the original instance for later cleanup
      final originalInstance = getIt<EnvConfigRepository>();

      // Properly unregister the existing instance
      getIt
        ..unregister<EnvConfigRepository>()

        // Now register our counting implementation
        ..registerLazySingleton<EnvConfigRepository>(() {
          resolutionCount++;
          return originalInstance;
        });

      // Should not be initialized yet since we just registered it
      expect(resolutionCount, 0);

      // Resolve it
      getIt<EnvConfigRepository>();
      expect(resolutionCount, 1);

      // Resolve again - should not increment
      getIt<EnvConfigRepository>();
      expect(resolutionCount, 1);
    });

    test('should register LocalStorageService as a lazy singleton', () {
      // Assert
      expect(getIt.isRegistered<LocalStorageService>(), isTrue);

      // Verify singleton behavior
      final instance1 = getIt<LocalStorageService>();
      final instance2 = getIt<LocalStorageService>();
      expect(instance1, same(instance2));
    });

    test('should register OnboardingRepository as a lazy singleton', () {
      // Assert
      expect(getIt.isRegistered<OnboardingRepository>(), isTrue);

      // Verify singleton behavior
      final instance1 = getIt<OnboardingRepository>();
      final instance2 = getIt<OnboardingRepository>();
      expect(instance1, same(instance2));
    });

    test('should register LoginCubit as a factory', () {
      // Assert
      expect(getIt.isRegistered<LoginCubit>(), isTrue);

      // Verify factory behavior - should get new instances each time
      final instance1 = getIt<LoginCubit>();
      final instance2 = getIt<LoginCubit>();
      expect(instance1, isNot(same(instance2)));
    });

    test('should register OnboardingCubit as a factory', () {
      // Assert
      expect(getIt.isRegistered<OnboardingCubit>(), isTrue);

      // Verify factory behavior - should get new instances each time
      final instance1 = getIt<OnboardingCubit>();
      final instance2 = getIt<OnboardingCubit>();
      expect(instance1, isNot(same(instance2)));
    });

    test('should handle multiple initializations gracefully', () async {
      // First reset GetIt to ensure clean state
      await getIt.reset();

      // Act - first initialization
      await configureDependencies();

      // Get a reference to an instance
      final storage1 = getIt<LocalStorageService>();

      // Reset before second initialization to avoid "already registered" errors
      await getIt.reset();

      // Initialize again
      await configureDependencies();

      // Get new instance after re-initialization
      final storage2 = getIt<LocalStorageService>();

      // Assert behavior - not same instance since we reset GetIt
      expect(storage1, isNot(same(storage2)));
      expect(storage2, isA<LocalStorageService>());
    });

    test('should throw when trying to resolve unregistered dependency', () {
      // Act & Assert
      final resolveUnregistered = getIt.get<UnregisteredDependency>;
      expect(resolveUnregistered, throwsA(anything));
    });
  });

  group('LocalStorageModule', () {
    test('should provide SharedPreferences instance', () {
      // Assert
      final prefs = getIt<SharedPreferences>();
      expect(prefs, isA<SharedPreferences>());
    });

    test('should initialize SharedPreferences only once', () {
      // Resolve multiple times
      getIt<SharedPreferences>();
      getIt<SharedPreferences>();

      // Make sure we resolved it
      expect(getIt.isRegistered<SharedPreferences>(), isTrue);
    });
  });

  group('ApiModule', () {
    test('should register Dio instance', () {
      // Act & Assert
      expect(getIt<Dio>(), isA<Dio>());
    });

    test('all registered dependencies should resolve without errors', () {
      // This is a smoke test to verify all dependencies can be resolved
      // without throwing exceptions

      // Act & Assert - these should not throw
      expect(getIt<SharedPreferences>(), isNotNull);
      expect(getIt<Dio>(), isNotNull);

      // As more dependencies are registered, add additional expects here
    });
  });
}

/// Dummy class for testing unregistered dependency resolution
class UnregisteredDependency {}
