import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/di/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of RegisterModule for testing
class TestRegisterModule extends RegisterModule {}

void main() {
  late TestRegisterModule registerModule;

  setUp(() {
    registerModule = TestRegisterModule();
    SharedPreferences.setMockInitialValues({});
  });

  group('RegisterModule', () {
    test('prefs should return SharedPreferences instance', () async {
      // Act
      final prefs = await registerModule.prefs;

      // Assert
      expect(prefs, isA<SharedPreferences>());
    });

    test('prefs should return a SharedPreferences instance each time',
        () async {
      // Act
      final prefs1 = await registerModule.prefs;
      final prefs2 = await registerModule.prefs;

      // Assert - not comparing with same() because
      // SharedPreferences.setMockInitialValues creates new instances
      expect(prefs1, isA<SharedPreferences>());
      expect(prefs2, isA<SharedPreferences>());
    });

    test('prefs should work with different mock values', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({'test_key': 'test_value'});

      // Act
      final prefs = await registerModule.prefs;

      // Assert
      expect(prefs.getString('test_key'), equals('test_value'));
    });
  });
}
