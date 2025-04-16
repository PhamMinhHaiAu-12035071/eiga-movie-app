import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/durations/app_durations_impl.dart';

void main() {
  // Test the implementation class directly
  group('AppDurationsImpl', () {
    late AppDurations appDurations;

    setUp(() {
      appDurations = const AppDurationsImpl();
    });

    test('veryShort should be 100ms', () {
      expect(appDurations.veryShort, const Duration(milliseconds: 100));
    });

    test('short should be 200ms', () {
      expect(appDurations.short, const Duration(milliseconds: 200));
    });

    test('medium should be 300ms', () {
      expect(appDurations.medium, const Duration(milliseconds: 300));
    });

    test('long should be 500ms', () {
      expect(appDurations.long, const Duration(milliseconds: 500));
    });

    test('extraLong should be 800ms', () {
      expect(appDurations.extraLong, const Duration(milliseconds: 800));
    });

    test('oneSecond should be 1 second', () {
      expect(appDurations.oneSecond, const Duration(seconds: 1));
    });
  });
}
