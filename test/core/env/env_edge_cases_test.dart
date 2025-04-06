import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/env/domain/env_config_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'env_test_helpers.dart';

void main() {
  final getIt = GetIt.instance;

  tearDown(getIt.reset);

  group('Environment Configuration Edge Cases', () {
    test('Should handle repository that returns empty values', () {
      // Arrange
      getIt.registerLazySingleton<EnvConfigRepository>(
        EmptyEnvConfigRepositoryImpl.new,
      );
      final repository = getIt<EnvConfigRepository>();

      // Act & Assert
      expect(repository.apiUrl, isEmpty);
      expect(repository.appName, isEmpty);
      expect(repository.environmentName, isEmpty);

      // Verify validation behavior
      expect(EnvTestHelpers.isValidUrl(repository.apiUrl), isFalse);
      expect(EnvTestHelpers.isValidAppName(repository.appName), isFalse);
      expect(
        EnvTestHelpers.isValidEnvironmentName(repository.environmentName),
        isFalse,
      );
    });

    test('Should handle exceptions when accessing environment variables', () {
      // Arrange
      getIt.registerLazySingleton<EnvConfigRepository>(
        ErrorThrowingEnvConfigRepositoryImpl.new,
      );
      final repository = getIt<EnvConfigRepository>();

      // Act & Assert
      expect(() => repository.apiUrl, throwsException);
      expect(() => repository.appName, throwsException);
      expect(() => repository.environmentName, throwsException);
    });

    test('Should correctly use mock implementations', () {
      // Arrange
      final mockRepository = MockEnvConfigRepository();
      when(() => mockRepository.apiUrl).thenReturn('https://mock-api.test.com');
      when(() => mockRepository.appName).thenReturn('Mock Test App');
      when(() => mockRepository.environmentName).thenReturn('mock');

      getIt.registerLazySingleton<EnvConfigRepository>(
        () => mockRepository,
      );
      final repository = getIt<EnvConfigRepository>();

      // Act
      final apiUrl = repository.apiUrl;
      final appName = repository.appName;
      final environmentName = repository.environmentName;

      // Assert
      expect(apiUrl, 'https://mock-api.test.com');
      expect(appName, 'Mock Test App');
      expect(environmentName, 'mock');

      // Verify calls
      verify(() => mockRepository.apiUrl).called(1);
      verify(() => mockRepository.appName).called(1);
      verify(() => mockRepository.environmentName).called(1);
    });

    test('Should handle fake implementation with predefined values', () {
      // Arrange
      getIt.registerLazySingleton<EnvConfigRepository>(
        FakeEnvConfigRepository.new,
      );
      final repository = getIt<EnvConfigRepository>();

      // Act & Assert
      expect(repository.apiUrl, 'https://fake-api.test.com');
      expect(repository.appName, 'Fake Test App');
      expect(repository.environmentName, 'test');

      // Verify validation behavior
      expect(EnvTestHelpers.isValidUrl(repository.apiUrl), isTrue);
      expect(EnvTestHelpers.isValidAppName(repository.appName), isTrue);
      expect(
        EnvTestHelpers.isValidEnvironmentName(repository.environmentName),
        isTrue,
      );
    });
  });
}
