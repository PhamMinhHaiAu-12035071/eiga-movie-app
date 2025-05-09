import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ksk_app/features/onboarding/infrastructure/repositories/onboarding_repository_impl.dart';
import 'package:ksk_app/features/storage/storage.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockLocalStorageService extends Mock implements LocalStorageService {}

void main() {
  late MockLocalStorageService mockStorageService;
  late OnboardingRepositoryImpl repository;
  const onboardingSeenKey = 'onboarding_seen';

  setUp(() {
    mockStorageService = MockLocalStorageService();
    repository = OnboardingRepositoryImpl(mockStorageService);
  });

  group('OnboardingRepositoryImpl Tests', () {
    // --- checkIfOnboardingSeen ---

    test(
        'checkIfOnboardingSeen should return Right(true) '
        'when storage returns true', () async {
      // Arrange
      when(() => mockStorageService.getBool(onboardingSeenKey))
          .thenAnswer((_) async => const Right<StorageFailure, bool>(true));

      // Act
      final result = await repository.checkIfOnboardingSeen();

      // Assert
      expect(result, const Right<StorageFailure, bool>(true));
      verify(() => mockStorageService.getBool(onboardingSeenKey)).called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
        'checkIfOnboardingSeen should return Right(false) '
        'when storage returns false', () async {
      // Arrange
      when(() => mockStorageService.getBool(onboardingSeenKey))
          .thenAnswer((_) async => const Right<StorageFailure, bool>(false));

      // Act
      final result = await repository.checkIfOnboardingSeen();

      // Assert
      expect(result, const Right<StorageFailure, bool>(false));
      verify(() => mockStorageService.getBool(onboardingSeenKey)).called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
        'checkIfOnboardingSeen should return Right(false) '
        'when storage returns null', () async {
      // Arrange
      when(() => mockStorageService.getBool(onboardingSeenKey)).thenAnswer(
        (_) async =>
            const Right<StorageFailure, bool?>(null), // Storage returns null
      );

      // Act
      final result = await repository.checkIfOnboardingSeen();

      // Assert
      // The implementation maps null to false
      expect(result, const Right<StorageFailure, bool>(false));
      verify(() => mockStorageService.getBool(onboardingSeenKey)).called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
        'checkIfOnboardingSeen should return Left(StorageFailure) '
        'when storage fails', () async {
      // Arrange
      const failure = StorageFailure.storageError('Failed to read');
      when(() => mockStorageService.getBool(onboardingSeenKey))
          .thenAnswer((_) async => const Left<StorageFailure, bool>(failure));

      // Act
      final result = await repository.checkIfOnboardingSeen();

      // Assert
      expect(result, const Left<StorageFailure, bool>(failure));
      verify(() => mockStorageService.getBool(onboardingSeenKey)).called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    // --- markOnboardingAsSeen ---

    test(
        'markOnboardingAsSeen should return Right(true) '
        'when storage succeeds', () async {
      // Arrange
      when(() => mockStorageService.setBool(onboardingSeenKey, value: true))
          .thenAnswer((_) async => const Right<StorageFailure, bool>(true));

      // Act
      final result = await repository.markOnboardingAsSeen();

      // Assert
      expect(result, const Right<StorageFailure, bool>(true));
      verify(() => mockStorageService.setBool(onboardingSeenKey, value: true))
          .called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
        'markOnboardingAsSeen should return Left(StorageFailure) '
        'when storage fails', () async {
      // Arrange
      const failure = StorageFailure.storageError('Failed to write');
      when(() => mockStorageService.setBool(onboardingSeenKey, value: true))
          .thenAnswer((_) async => const Left<StorageFailure, bool>(failure));

      // Act
      final result = await repository.markOnboardingAsSeen();

      // Assert
      expect(result, const Left<StorageFailure, bool>(failure));
      verify(() => mockStorageService.setBool(onboardingSeenKey, value: true))
          .called(1);
      verifyNoMoreInteractions(mockStorageService);
    });
  });
}
