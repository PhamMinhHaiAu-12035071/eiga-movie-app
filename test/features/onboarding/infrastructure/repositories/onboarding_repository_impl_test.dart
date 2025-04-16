import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ksk_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:ksk_app/features/onboarding/infrastructure/repositories/onboarding_repository_impl.dart';
import 'package:ksk_app/features/storage/domain/errors/storage_failure.dart';
import 'package:ksk_app/features/storage/storage.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockLocalStorageService extends Mock implements LocalStorageService {}

void main() {
  late MockLocalStorageService mockStorageService;
  late OnboardingRepositoryImpl repository;
  const String onboardingSeenKey = 'onboarding_seen';

  setUp(() {
    mockStorageService = MockLocalStorageService();
    repository = OnboardingRepositoryImpl(mockStorageService);
  });

  group('OnboardingRepositoryImpl Tests', () {
    // --- checkIfOnboardingSeen ---

    test(
        'checkIfOnboardingSeen should return Right(true) when storage returns true',
        () async {
      // Arrange
      when(() => mockStorageService.getBool(onboardingSeenKey))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await repository.checkIfOnboardingSeen();

      // Assert
      expect(result, const Right(true));
      verify(() => mockStorageService.getBool(onboardingSeenKey)).called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
        'checkIfOnboardingSeen should return Right(false) when storage returns false',
        () async {
      // Arrange
      when(() => mockStorageService.getBool(onboardingSeenKey))
          .thenAnswer((_) async => const Right(false));

      // Act
      final result = await repository.checkIfOnboardingSeen();

      // Assert
      expect(result, const Right(false));
      verify(() => mockStorageService.getBool(onboardingSeenKey)).called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
        'checkIfOnboardingSeen should return Right(false) when storage returns null',
        () async {
      // Arrange
      when(() => mockStorageService.getBool(onboardingSeenKey))
          .thenAnswer((_) async => const Right(null)); // Storage returns null

      // Act
      final result = await repository.checkIfOnboardingSeen();

      // Assert
      // The implementation maps null to false
      expect(result, const Right(false));
      verify(() => mockStorageService.getBool(onboardingSeenKey)).called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
        'checkIfOnboardingSeen should return Left(StorageFailure) when storage fails',
        () async {
      // Arrange
      final failure = StorageFailure.storageError('Failed to read');
      when(() => mockStorageService.getBool(onboardingSeenKey))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await repository.checkIfOnboardingSeen();

      // Assert
      expect(result, Left(failure));
      verify(() => mockStorageService.getBool(onboardingSeenKey)).called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    // --- markOnboardingAsSeen ---

    test('markOnboardingAsSeen should return Right(true) when storage succeeds',
        () async {
      // Arrange
      when(() => mockStorageService.setBool(onboardingSeenKey, value: true))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await repository.markOnboardingAsSeen();

      // Assert
      expect(result, const Right(true));
      verify(() => mockStorageService.setBool(onboardingSeenKey, value: true))
          .called(1);
      verifyNoMoreInteractions(mockStorageService);
    });

    test(
        'markOnboardingAsSeen should return Left(StorageFailure) when storage fails',
        () async {
      // Arrange
      final failure = StorageFailure.storageError('Failed to write');
      when(() => mockStorageService.setBool(onboardingSeenKey, value: true))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await repository.markOnboardingAsSeen();

      // Assert
      expect(result, Left(failure));
      verify(() => mockStorageService.setBool(onboardingSeenKey, value: true))
          .called(1);
      verifyNoMoreInteractions(mockStorageService);
    });
  });
}
