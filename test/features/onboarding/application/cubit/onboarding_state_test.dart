import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_state.dart';
import 'package:ksk_app/features/onboarding/domain/models/onboarding_info.dart';
import 'package:ksk_app/generated/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

class MockAssetGenImage extends Mock implements AssetGenImage {}

void main() {
  late MockAssetGenImage mockImage1;
  late MockAssetGenImage mockImage2;
  late MockAssetGenImage mockImage3;

  setUp(() {
    mockImage1 = MockAssetGenImage();
    mockImage2 = MockAssetGenImage();
    mockImage3 = MockAssetGenImage();
  });

  group('OnboardingState', () {
    test('props should include all state properties', () {
      final state = OnboardingState(
        slides: [
          OnboardingInfo(
            image: mockImage1,
            title: 'Title 1',
            description: 'Description 1',
          ),
        ],
        currentPage: 1,
        error: 'Some error',
      );

      expect(state.props, [state.slides, state.currentPage, state.error]);
    });

    test('isLastPage should return true when on last page', () {
      // Create a state with 3 slides and currentPage = 2 (0-based index)
      final state = OnboardingState(
        slides: [
          OnboardingInfo(
            image: mockImage1,
            title: 'Title 1',
            description: 'Description 1',
          ),
          OnboardingInfo(
            image: mockImage2,
            title: 'Title 2',
            description: 'Description 2',
          ),
          OnboardingInfo(
            image: mockImage3,
            title: 'Title 3',
            description: 'Description 3',
          ),
        ],
        currentPage: 2,
      );

      expect(state.isLastPage, isTrue);
    });

    test('isLastPage should return false when not on last page', () {
      // Create a state with 3 slides and currentPage = 1 (0-based index)
      final state = OnboardingState(
        slides: [
          OnboardingInfo(
            image: mockImage1,
            title: 'Title 1',
            description: 'Description 1',
          ),
          OnboardingInfo(
            image: mockImage2,
            title: 'Title 2',
            description: 'Description 2',
          ),
          OnboardingInfo(
            image: mockImage3,
            title: 'Title 3',
            description: 'Description 3',
          ),
        ],
        currentPage: 1,
      );

      expect(state.isLastPage, isFalse);
    });

    test('default constructor parameters should be set correctly', () {
      final slides = [
        OnboardingInfo(
          image: mockImage1,
          title: 'Title',
          description: 'Description',
        ),
      ];

      // Test with only required parameter
      final defaultState = OnboardingState(slides: slides);
      expect(defaultState.slides, equals(slides));
      expect(defaultState.currentPage, equals(0)); // Default value
      expect(defaultState.error, isNull); // Default value
    });

    group('copyWith', () {
      test('should update all properties when provided', () {
        final initialState = OnboardingState(
          slides: [
            OnboardingInfo(
              image: mockImage1,
              title: 'Title 1',
              description: 'Description 1',
            ),
          ],
        );

        final newSlides = [
          OnboardingInfo(
            image: mockImage2,
            title: 'Title 2',
            description: 'Description 2',
          ),
        ];

        final updatedState = initialState.copyWith(
          slides: newSlides,
          currentPage: 1,
          error: 'Some error',
        );

        expect(updatedState.slides, equals(newSlides));
        expect(updatedState.currentPage, equals(1));
        expect(updatedState.error, equals('Some error'));
      });

      test('should only update provided properties', () {
        final initialState = OnboardingState(
          slides: [
            OnboardingInfo(
              image: mockImage1,
              title: 'Title 1',
              description: 'Description 1',
            ),
          ],
          error: 'Initial error',
        );

        // Only update currentPage
        final updatedState1 = initialState.copyWith(
          currentPage: 1,
        );

        expect(updatedState1.slides, equals(initialState.slides));
        expect(updatedState1.currentPage, equals(1));
        expect(updatedState1.error, equals(initialState.error));

        // Only update error
        final updatedState2 = initialState.copyWith(
          error: 'New error',
        );

        expect(updatedState2.slides, equals(initialState.slides));
        expect(updatedState2.currentPage, equals(initialState.currentPage));
        expect(updatedState2.error, equals('New error'));

        // Only update slides
        final newSlides = [
          OnboardingInfo(
            image: mockImage2,
            title: 'Title 2',
            description: 'Description 2',
          ),
        ];

        final updatedState3 = initialState.copyWith(
          slides: newSlides,
        );

        expect(updatedState3.slides, equals(newSlides));
        expect(updatedState3.currentPage, equals(initialState.currentPage));
        expect(updatedState3.error, equals(initialState.error));
      });
    });
  });
}
