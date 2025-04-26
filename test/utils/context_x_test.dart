import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/utils/context_x.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockAppSizes extends Mock implements AppSizes {}

class MockAppDurations extends Mock implements AppDurations {}

class MockAppColors extends Mock implements AppColors {}

void main() {
  late MockBuildContext mockContext;
  late MockAppSizes mockSizes;
  late MockAppDurations mockDurations;
  late MockAppColors mockColors;

  setUp(() {
    mockContext = MockBuildContext();
    mockSizes = MockAppSizes();
    mockDurations = MockAppDurations();
    mockColors = MockAppColors();

    // Register mocks with GetIt
    final getIt = GetIt.instance;
    if (getIt.isRegistered<AppSizes>()) {
      getIt.unregister<AppSizes>();
    }
    if (getIt.isRegistered<AppDurations>()) {
      getIt.unregister<AppDurations>();
    }
    if (getIt.isRegistered<AppColors>()) {
      getIt.unregister<AppColors>();
    }

    getIt
      ..registerSingleton<AppSizes>(mockSizes)
      ..registerSingleton<AppDurations>(mockDurations)
      ..registerSingleton<AppColors>(mockColors);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('AppTheme extension', () {
    test('sizes getter returns correct instance from GetIt', () {
      final result = mockContext.sizes;
      expect(result, equals(mockSizes));
    });

    test('durations getter returns correct instance from GetIt', () {
      final result = mockContext.durations;
      expect(result, equals(mockDurations));
    });

    test('colors getter returns correct instance from GetIt', () {
      final result = mockContext.colors;
      expect(result, equals(mockColors));
    });

    test('throws StateError when AppSizes is not registered', () {
      // Unregister AppSizes
      GetIt.I.unregister<AppSizes>();

      expect(() => mockContext.sizes, throwsA(isA<StateError>()));
    });

    test('throws StateError when AppDurations is not registered', () {
      // Unregister AppDurations
      GetIt.I.unregister<AppDurations>();

      expect(() => mockContext.durations, throwsA(isA<StateError>()));
    });

    test('throws StateError when AppColors is not registered', () {
      // Unregister AppColors
      GetIt.I.unregister<AppColors>();

      expect(() => mockContext.colors, throwsA(isA<StateError>()));
    });
  });
}
