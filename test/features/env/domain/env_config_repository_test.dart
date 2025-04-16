import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/features/env/domain/env_config_repository.dart';
import 'package:mocktail/mocktail.dart';

/// A mock implementation of [EnvConfigRepository] for testing
class MockEnvConfigRepository extends Mock implements EnvConfigRepository {}

/// A fake implementation of [EnvConfigRepository] for testing
/// with predefined values
class FakeEnvConfigRepository implements EnvConfigRepository {
  @override
  String get apiUrl => 'https://fake-api.test.com';

  @override
  String get appName => 'Fake Test App';

  @override
  String get environmentName => 'test';
}

/// Helper functions for common test operations
class EnvTestHelpers {
  /// Validates that a URL string is well-formed
  static bool isValidUrl(String url) {
    if (url.isEmpty) return false;

    // Simple validation - could be enhanced for production code
    return url.startsWith('http://') || url.startsWith('https://');
  }

  /// Validates that an app name is reasonable
  static bool isValidAppName(String name) {
    return name.isNotEmpty && name.length >= 3;
  }

  /// Validates that an environment name is reasonable
  static bool isValidEnvironmentName(String name) {
    final validEnvironments = [
      'development',
      'dev',
      'staging',
      'production',
      'prod',
      'test',
    ];
    return validEnvironments.any((env) => name.toLowerCase().contains(env));
  }
}

void main() {
  group('EnvConfigRepository Interface', () {
    test('should be able to create a mock for testing', () {
      // Arrange
      final repository = MockEnvConfigRepository();

      // Act & Assert
      expect(repository, isA<EnvConfigRepository>());
    });

    test('should define apiUrl getter', () {
      // Arrange
      final repository = MockEnvConfigRepository();
      when(() => repository.apiUrl).thenReturn('https://test-api.com');

      // Act
      final result = repository.apiUrl;

      // Assert
      expect(result, 'https://test-api.com');
      verify(() => repository.apiUrl).called(1);
    });

    test('should define appName getter', () {
      // Arrange
      final repository = MockEnvConfigRepository();
      when(() => repository.appName).thenReturn('Test App');

      // Act
      final result = repository.appName;

      // Assert
      expect(result, 'Test App');
      verify(() => repository.appName).called(1);
    });

    test('should define environmentName getter', () {
      // Arrange
      final repository = MockEnvConfigRepository();
      when(() => repository.environmentName).thenReturn('test');

      // Act
      final result = repository.environmentName;

      // Assert
      expect(result, 'test');
      verify(() => repository.environmentName).called(1);
    });
  });

  group('EnvConfigRepository Mock Usage', () {
    final getIt = GetIt.instance;

    tearDown(getIt.reset);

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
