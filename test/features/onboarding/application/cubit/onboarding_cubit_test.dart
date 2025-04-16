import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_cubit.dart';
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_state.dart';
import 'package:ksk_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:ksk_app/features/storage/domain/errors/storage_failure.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockOnboardingRepository repository;
  late OnboardingCubit cubit;

  setUp(() {
    // Initialize mocks
    repository = MockOnboardingRepository();

    // Initialize cubit with mocked repository
    cubit = OnboardingCubit(repository);
  });

  tearDown(() {
    // Clean up
    cubit.close();
  });

  group('OnboardingCubit', () {
    // Initial state test
    test('initial state should contain three default slides and currentPage=0',
        () {
      final state = cubit.state;
      expect(state.slides.length, 3);
      expect(state.currentPage, 0);
      expect(state.error, isNull);
      expect(state.isLastPage, isFalse);
    });

    // UpdatePage tests
    blocTest<OnboardingCubit, OnboardingState>(
      'updatePage should update currentPage',
      build: () => cubit,
      act: (cubit) => cubit.updatePage(1),
      expect: () => [
        predicate<OnboardingState>(
          (state) => state.currentPage == 1 && state.slides.length == 3,
        ),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'updatePage should work for any valid page index',
      build: () => cubit,
      act: (cubit) => cubit.updatePage(2),
      expect: () => [
        predicate<OnboardingState>(
          (state) => state.currentPage == 2 && state.isLastPage == true,
        ),
      ],
    );

    // NextPage tests
    blocTest<OnboardingCubit, OnboardingState>(
      'nextPage should increment currentPage',
      build: () => cubit,
      act: (cubit) => cubit.nextPage(),
      expect: () => [
        predicate<OnboardingState>(
          (state) => state.currentPage == 1 && state.isLastPage == false,
        ),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'nextPage should not increment beyond last page',
      build: () => cubit,
      seed: () =>
          cubit.state.copyWith(currentPage: 2), // Last page (0-based index)
      act: (cubit) => cubit.nextPage(),
      expect: () => <OnboardingState>[], // No state change expected
    );

    // CompleteOnboarding tests
    blocTest<OnboardingCubit, OnboardingState>(
      'completeOnboarding should call repository.markOnboardingAsSeen',
      build: () {
        when(() => repository.markOnboardingAsSeen())
            .thenAnswer((_) async => const Right(true));
        return cubit;
      },
      act: (cubit) => cubit.completeOnboarding(),
      verify: (_) {
        verify(() => repository.markOnboardingAsSeen()).called(1);
      },
      expect: () => <OnboardingState>[], // No state change on success
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'completeOnboarding should emit error state on failure',
      build: () {
        when(() => repository.markOnboardingAsSeen()).thenAnswer(
          (_) async => const Left(StorageFailure.storageError('Test error')),
        );
        return cubit;
      },
      act: (cubit) => cubit.completeOnboarding(),
      expect: () => [
        predicate<OnboardingState>(
          (state) => state.error == 'Failed to save onboarding status',
        ),
      ],
    );

    // CheckIfOnboardingSeen tests
    test(
        'checkIfOnboardingSeen should return true when repository returns true',
        () async {
      when(() => repository.checkIfOnboardingSeen())
          .thenAnswer((_) async => const Right(true));

      final result = await cubit.checkIfOnboardingSeen();

      expect(result, isTrue);
      expect(cubit.state.error, isNull); // No error should be set
    });

    test(
        'checkIfOnboardingSeen should return false '
        'when repository returns false', () async {
      when(() => repository.checkIfOnboardingSeen())
          .thenAnswer((_) async => const Right(false));

      final result = await cubit.checkIfOnboardingSeen();

      expect(result, isFalse);
      expect(cubit.state.error, isNull); // No error should be set
    });

    test(
        'checkIfOnboardingSeen should return false and emit error state '
        'on failure', () async {
      when(() => repository.checkIfOnboardingSeen()).thenAnswer(
        (_) async => const Left(StorageFailure.storageError('Test error')),
      );

      final result = await cubit.checkIfOnboardingSeen();

      expect(result, isFalse); // Default behavior on error
      expect(cubit.state.error, equals('Failed to retrieve onboarding status'));
    });
  });
}
