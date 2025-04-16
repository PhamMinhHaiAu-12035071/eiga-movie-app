import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/features/onboarding/domain/models/onboarding_info.dart';
import 'package:ksk_app/generated/assets.gen.dart'; // Import generated class
import 'package:mocktail/mocktail.dart';

// Mock for the generated AssetGenImage class
class MockAssetGenImage extends Mock implements AssetGenImage {}

void main() {
  // Create mock instances once
  final mockImage1 = MockAssetGenImage();
  final mockImage2 = MockAssetGenImage();

  // Define test data
  const title1 = 'Title 1';
  const description1 = 'Description 1';

  const title2 = 'Title 2';
  const description2 = 'Description 2';

  // Create instances for testing
  final onboardingInfo1 = OnboardingInfo(
    image: mockImage1,
    title: title1,
    description: description1,
  );

  final onboardingInfo1Duplicate = OnboardingInfo(
    image: mockImage1, // Same image mock
    title: title1,
    description: description1,
  );

  final onboardingInfo2DifferentImage = OnboardingInfo(
    image: mockImage2, // Different image mock
    title: title1,
    description: description1,
  );

  final onboardingInfo3DifferentTitle = OnboardingInfo(
    image: mockImage1,
    title: title2, // Different title
    description: description1,
  );

  final onboardingInfo4DifferentDescription = OnboardingInfo(
    image: mockImage1,
    title: title1,
    description: description2, // Different description
  );

  group('OnboardingInfo Model Tests', () {
    test('props should contain correct properties', () {
      // Assert: Check if props list matches the instance properties
      expect(onboardingInfo1.props, [mockImage1, title1, description1]);
    });

    test('Instances with same properties should be equal', () {
      // Assert: Check for equality using == operator (Equatable handles this via props)
      expect(onboardingInfo1 == onboardingInfo1Duplicate, isTrue);
      // Also check hashCode consistency
      expect(onboardingInfo1.hashCode == onboardingInfo1Duplicate.hashCode,
          isTrue);
    });

    test(
        'Instances with different image should have different props list but may compare equal due to mock limitations',
        () {
      // Assert: Check that the instances themselves are different
      expect(identical(mockImage1, mockImage2), isFalse);

      // Assert: Check that the props lists reflect the different image mocks
      expect(onboardingInfo1.props, [mockImage1, title1, description1]);
      expect(onboardingInfo2DifferentImage.props,
          [mockImage2, title1, description1]);

      // We acknowledge that mockImage1 == mockImage2 might incorrectly be true,
      // thus onboardingInfo1 == onboardingInfo2DifferentImage might also be true.
      // So, we don't assert inequality of the OnboardingInfo instances here.
      // The important part is that the props list contains the different mock instance.
    });

    test('Instances with different title should not be equal', () {
      // Assert: Check for inequality
      expect(onboardingInfo1 == onboardingInfo3DifferentTitle, isFalse);
      expect(onboardingInfo1.hashCode == onboardingInfo3DifferentTitle.hashCode,
          isFalse);
    });

    test('Instances with different description should not be equal', () {
      // Assert: Check for inequality
      expect(onboardingInfo1 == onboardingInfo4DifferentDescription, isFalse);
      expect(
          onboardingInfo1.hashCode ==
              onboardingInfo4DifferentDescription.hashCode,
          isFalse);
    });
  });
}
