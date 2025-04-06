import 'package:ksk_app/core/env/domain/env_config_repository.dart';
import 'package:ksk_app/core/env/infrastructure/env_config_repository_impl.dart';
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
