import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/env/domain/env_config_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockEnvConfigRepository extends Mock implements EnvConfigRepository {}

void main() {
  group('EnvConfigRepository', () {
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
}
