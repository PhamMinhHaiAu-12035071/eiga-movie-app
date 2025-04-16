import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/features/env/domain/env_config_repository.dart';
import 'package:ksk_app/features/env/env_development.dart';
import 'package:ksk_app/features/env/infrastructure/env_config_repository_impl.dart';

/// A custom implementation of [EnvConfigRepositoryImpl] that throws exceptions
/// for testing error handling
class ErrorThrowingEnvConfigRepositoryImpl extends EnvConfigRepositoryImpl {
  @override
  String get apiUrl => throw Exception('Failed to get API URL');

  @override
  String get appName => throw Exception('Failed to get app name');

  @override
  String get environmentName =>
      throw Exception('Failed to get environment name');
}

/// A custom implementation that returns empty values
class EmptyEnvConfigRepositoryImpl extends EnvConfigRepositoryImpl {
  @override
  String get apiUrl => '';

  @override
  String get appName => '';

  @override
  String get environmentName => '';
}

void main() {
  late EnvConfigRepositoryImpl repository;

  setUp(() {
    repository = EnvConfigRepositoryImpl();
  });

  group('EnvConfigRepositoryImpl', () {
    test('should implement EnvConfigRepository', () {
      // Assert
      expect(repository, isA<EnvConfigRepository>());
    });

    test('apiUrl should return value from EnvDev', () {
      // We're testing actual implementation that depends on EnvDev
      // We can't easily mock static classes without extra tools
      // This is more of an integration test that confirms the real value
      final result = repository.apiUrl;

      expect(result, isNotNull);
      expect(result, equals(EnvDev.apiUrl));
    });

    test('appName should return value from EnvDev', () {
      final result = repository.appName;

      expect(result, isNotNull);
      expect(result, equals(EnvDev.appName));
    });

    test('environmentName should return value from EnvDev', () {
      final result = repository.environmentName;

      expect(result, isNotNull);
      expect(result, equals(EnvDev.environmentName));
    });
  });

  group('EnvConfigRepositoryImpl with DI', () {
    final getIt = GetIt.instance;

    setUp(() {
      getIt.registerLazySingleton<EnvConfigRepository>(
        EnvConfigRepositoryImpl.new,
      );
    });

    tearDown(getIt.reset);

    test('should be registered correctly in DI container', () {
      // Act
      final resolvedRepo = getIt<EnvConfigRepository>();

      // Assert
      expect(resolvedRepo, isA<EnvConfigRepositoryImpl>());
    });

    test('should return same instance when resolved multiple times', () {
      // Act
      final firstInstance = getIt<EnvConfigRepository>();
      final secondInstance = getIt<EnvConfigRepository>();

      // Assert
      expect(firstInstance, same(secondInstance));
    });
  });

  group('EnvConfigRepositoryImpl Error Handling', () {
    final getIt = GetIt.instance;

    tearDown(getIt.reset);

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
  });

  group('EnvConfigRepositoryImpl Integration', () {
    final getIt = GetIt.instance;
    late EnvConfigRepository repository;

    setUp(() {
      getIt.registerLazySingleton<EnvConfigRepository>(
        EnvConfigRepositoryImpl.new,
      );
      repository = getIt<EnvConfigRepository>();
    });

    tearDown(getIt.reset);

    test('apiUrl from repository should match EnvDev value', () {
      // Act
      final repoApiUrl = repository.apiUrl;
      final envDevApiUrl = EnvDev.apiUrl;

      // Assert
      expect(repoApiUrl, isNotEmpty);
      expect(repoApiUrl, equals(envDevApiUrl));
    });

    test('appName from repository should match EnvDev value', () {
      // Act
      final repoAppName = repository.appName;
      final envDevAppName = EnvDev.appName;

      // Assert
      expect(repoAppName, isNotEmpty);
      expect(repoAppName, equals(envDevAppName));
    });

    test('environmentName from repository should match EnvDev value', () {
      // Act
      final repoEnvName = repository.environmentName;
      final envDevEnvName = EnvDev.environmentName;

      // Assert
      expect(repoEnvName, isNotEmpty);
      expect(repoEnvName, equals(envDevEnvName));
    });

    test('all environment values should be consistent throughout the system',
        () {
      // This test ensures the complete chain works correctly
      // Repository -> EnvDev -> Generated code -> Real env values

      // Validate API URL
      expect(repository.apiUrl, isNotEmpty);
      expect(repository.apiUrl, startsWith('http'));

      // Validate app name
      expect(repository.appName, isNotEmpty);
      expect(repository.appName.length > 2, true);

      // Validate environment name
      expect(repository.environmentName, isNotEmpty);
      expect(
        ['development', 'dev', 'develop'].any(
          (env) => repository.environmentName.toLowerCase().contains(env),
        ),
        true,
        reason: 'Environment name should be related to development',
      );
    });
  });
}
