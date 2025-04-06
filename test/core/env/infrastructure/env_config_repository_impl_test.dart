import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/env/domain/env_config_repository.dart';
import 'package:ksk_app/core/env/env_development.dart';
import 'package:ksk_app/core/env/infrastructure/env_config_repository_impl.dart';

class MockEnvDev {
  static const String apiUrl = 'https://test-api.com';
  static const String appName = 'Test App';
  static const String environmentName = 'test';
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
}
