import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ksk_app/features/storage/domain/errors/storage_failure.dart';
import 'package:ksk_app/features/storage/domain/interfaces/local_storage_service.dart';
import 'package:ksk_app/features/storage/infrastructure/services/shared_preferences_storage_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockSharedPreferences mockPrefs;
  late LocalStorageService storageService;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    storageService = SharedPreferencesStorageService(mockPrefs);
  });

  group('SharedPreferencesStorageService', () {
    const testKey = 'test_key';
    const testValue = true;

    group('getBool', () {
      test('should return Right with the correct value when successful',
          () async {
        // Arrange
        when(() => mockPrefs.getBool(testKey)).thenReturn(testValue);

        // Act
        final result = await storageService.getBool(testKey);

        // Assert
        expect(result, equals(right<StorageFailure, bool?>(testValue)));
        verify(() => mockPrefs.getBool(testKey)).called(1);
      });

      test('should return Right with null when key not found', () async {
        // Arrange
        when(() => mockPrefs.getBool(testKey)).thenReturn(null);

        // Act
        final result = await storageService.getBool(testKey);

        // Assert
        expect(result, equals(right<StorageFailure, bool?>(null)));
        verify(() => mockPrefs.getBool(testKey)).called(1);
      });

      test('should return Left with StorageFailure when an exception occurs',
          () async {
        // Arrange
        when(() => mockPrefs.getBool(testKey))
            .thenThrow(Exception('Test exception'));

        // Act
        final result = await storageService.getBool(testKey);

        // Assert
        result.fold(
          (failure) => expect(failure, isA<StorageFailure>()),
          (value) => fail('Should return Left with StorageFailure'),
        );
        verify(() => mockPrefs.getBool(testKey)).called(1);
      });
    });

    group('setBool', () {
      test('should return Right with true when successful', () async {
        // Arrange
        when(() => mockPrefs.setBool(testKey, testValue))
            .thenAnswer((_) async => true);

        // Act
        final result = await storageService.setBool(testKey, value: testValue);

        // Assert
        expect(result, equals(right<StorageFailure, bool>(true)));
        verify(() => mockPrefs.setBool(testKey, testValue)).called(1);
      });

      test('should return Left with StorageFailure when an exception occurs',
          () async {
        // Arrange
        when(() => mockPrefs.setBool(testKey, testValue))
            .thenThrow(Exception('Test exception'));

        // Act
        final result = await storageService.setBool(testKey, value: testValue);

        // Assert
        result.fold(
          (failure) => expect(failure, isA<StorageFailure>()),
          (value) => fail('Should return Left with StorageFailure'),
        );
        verify(() => mockPrefs.setBool(testKey, testValue)).called(1);
      });
    });

    group('containsKey', () {
      test('should return Right with true when key exists', () async {
        // Arrange
        when(() => mockPrefs.containsKey(testKey)).thenReturn(true);

        // Act
        final result = await storageService.containsKey(testKey);

        // Assert
        expect(result, equals(right<StorageFailure, bool>(true)));
        verify(() => mockPrefs.containsKey(testKey)).called(1);
      });

      test('should return Right with false when key does not exist', () async {
        // Arrange
        when(() => mockPrefs.containsKey(testKey)).thenReturn(false);

        // Act
        final result = await storageService.containsKey(testKey);

        // Assert
        expect(result, equals(right<StorageFailure, bool>(false)));
        verify(() => mockPrefs.containsKey(testKey)).called(1);
      });

      test('should return Left with StorageFailure when an exception occurs',
          () async {
        // Arrange
        when(() => mockPrefs.containsKey(testKey))
            .thenThrow(Exception('Test exception'));

        // Act
        final result = await storageService.containsKey(testKey);

        // Assert
        result.fold(
          (failure) => expect(failure, isA<StorageFailure>()),
          (value) => fail('Should return Left with StorageFailure'),
        );
        verify(() => mockPrefs.containsKey(testKey)).called(1);
      });
    });

    group('remove', () {
      test('should return Right with true when successful', () async {
        // Arrange
        when(() => mockPrefs.remove(testKey)).thenAnswer((_) async => true);

        // Act
        final result = await storageService.remove(testKey);

        // Assert
        expect(result, equals(right<StorageFailure, bool>(true)));
        verify(() => mockPrefs.remove(testKey)).called(1);
      });

      test('should return Left with StorageFailure when an exception occurs',
          () async {
        // Arrange
        when(() => mockPrefs.remove(testKey))
            .thenThrow(Exception('Test exception'));

        // Act
        final result = await storageService.remove(testKey);

        // Assert
        result.fold(
          (failure) => expect(failure, isA<StorageFailure>()),
          (value) => fail('Should return Left with StorageFailure'),
        );
        verify(() => mockPrefs.remove(testKey)).called(1);
      });
    });

    group('clear', () {
      test('should return Right with true when successful', () async {
        // Arrange
        when(() => mockPrefs.clear()).thenAnswer((_) async => true);

        // Act
        final result = await storageService.clear();

        // Assert
        expect(result, equals(right<StorageFailure, bool>(true)));
        verify(() => mockPrefs.clear()).called(1);
      });

      test('should return Left with StorageFailure when an exception occurs',
          () async {
        // Arrange
        when(() => mockPrefs.clear()).thenThrow(Exception('Test exception'));

        // Act
        final result = await storageService.clear();

        // Assert
        result.fold(
          (failure) => expect(failure, isA<StorageFailure>()),
          (value) => fail('Should return Left with StorageFailure'),
        );
        verify(() => mockPrefs.clear()).called(1);
      });
    });
  });
}
