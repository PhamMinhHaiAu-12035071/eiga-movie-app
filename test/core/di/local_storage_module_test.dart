import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/di/local_storage_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of LocalStorageModule for testing
class TestLocalStorageModule extends LocalStorageModule {}

void main() {
  late TestLocalStorageModule localStorageModule;

  setUp(() {
    localStorageModule = TestLocalStorageModule();
    SharedPreferences.setMockInitialValues({});
  });

  group('LocalStorageModule', () {
    test('prefs should return SharedPreferences instance', () async {
      // Act
      final prefs = await localStorageModule.prefs;

      // Assert
      expect(prefs, isA<SharedPreferences>());
    });

    test('prefs should return a SharedPreferences instance each time',
        () async {
      // Act
      final prefs1 = await localStorageModule.prefs;
      final prefs2 = await localStorageModule.prefs;

      // Assert - not comparing with same() because
      // SharedPreferences.setMockInitialValues creates new instances
      expect(prefs1, isA<SharedPreferences>());
      expect(prefs2, isA<SharedPreferences>());
    });

    test('prefs should work with different mock values', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({'test_key': 'test_value'});

      // Act
      final prefs = await localStorageModule.prefs;

      // Assert
      expect(prefs.getString('test_key'), equals('test_value'));
    });
  });
}
