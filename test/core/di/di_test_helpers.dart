import 'package:ksk_app/features/env/domain/env_config_repository.dart';
import 'package:ksk_app/features/login/application/cubit/login_cubit.dart';
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_cubit.dart';
import 'package:ksk_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:ksk_app/features/storage/domain/interfaces/local_storage_service.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of LocalStorageService for testing
class MockLocalStorageService extends Mock implements LocalStorageService {}

/// Mock implementation of EnvConfigRepository for testing
class MockEnvConfigRepository extends Mock implements EnvConfigRepository {}

/// Mock implementation of OnboardingRepository for testing
class MockOnboardingRepository extends Mock implements OnboardingRepository {}

/// Mock implementation of LoginCubit for testing
class MockLoginCubit extends Mock implements LoginCubit {}

/// Mock implementation of OnboardingCubit for testing
class MockOnboardingCubit extends Mock implements OnboardingCubit {}

/// Helper class for DI testing
class DiTestHelpers {
  /// Validates if a dependency is registered as a singleton by comparing
  /// instances from multiple resolutions
  static bool isRegisteredAsSingleton<T>(T instance1, T instance2) {
    return identical(instance1, instance2);
  }

  /// Validates if a dependency is registered as a factory by comparing
  /// instances from multiple resolutions
  static bool isRegisteredAsFactory<T>(T instance1, T instance2) {
    return !identical(instance1, instance2);
  }
}
