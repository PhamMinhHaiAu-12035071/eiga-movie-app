import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/env/env_development.dart';

void main() {
  group('EnvDevelopment', () {
    test('apiUrl should not be null', () {
      // Act & Assert
      expect(EnvDev.apiUrl, isNotNull);
      expect(EnvDev.apiUrl, isA<String>());
      expect(EnvDev.apiUrl.isNotEmpty, true);
    });

    test('appName should not be null', () {
      // Act & Assert
      expect(EnvDev.appName, isNotNull);
      expect(EnvDev.appName, isA<String>());
      expect(EnvDev.appName.isNotEmpty, true);
    });

    test('environmentName should not be null', () {
      // Act & Assert
      expect(EnvDev.environmentName, isNotNull);
      expect(EnvDev.environmentName, isA<String>());
      expect(EnvDev.environmentName.isNotEmpty, true);
    });

    test('apiUrl value should be properly decrypted from obfuscated form', () {
      // This test validates that the envied package is correctly
      // deobfuscating the environment variable
      final apiUrl = EnvDev.apiUrl;

      // We can't know the exact value without the .env.dev file,
      // but we can check it looks like a valid URL
      expect(apiUrl.startsWith('http'), true);
    });

    test('appName value should be properly decrypted from obfuscated form', () {
      // This test validates that the envied package is correctly
      // deobfuscating the environment variable
      final appName = EnvDev.appName;

      // We can't know the exact value but can verify it's a reasonable app name
      expect(appName.length > 2, true);
    });

    test(
      'environmentName value should be properly decrypted from obfuscated form',
      () {
        // This test validates that the envied package is correctly
        // deobfuscating the environment variable
        final environmentName = EnvDev.environmentName;

        // We expect the environment name to be "development" or similar
        expect(
          ['development', 'dev', 'develop'].any(
            (env) => environmentName.toLowerCase().contains(env),
          ),
          true,
          reason: 'Environment name should be related to development',
        );
      },
    );
  });
}
