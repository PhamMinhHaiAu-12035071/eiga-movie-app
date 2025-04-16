import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/generated/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

class MockAssetGenImage extends Mock implements AssetGenImage {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockAssetGenImage());
  });

  group('OnboardingImages', () {
    test('default constructor uses Assets', () {
      final images = OnboardingImages();
      expect(images.screen1, equals(Assets.images.onboarding.onboarding1));
      expect(images.screen2, equals(Assets.images.onboarding.onboarding2));
      expect(images.screen3, equals(Assets.images.onboarding.onboarding3));
      expect(images.logo, equals(Assets.images.onboarding.logo));
      expect(
        images.values,
        containsAll(
          [images.screen1, images.screen2, images.screen3, images.logo],
        ),
      );
    });

    test('custom constructor uses provided images', () {
      final mock1 = MockAssetGenImage();
      final mock2 = MockAssetGenImage();
      final mock3 = MockAssetGenImage();
      final mockLogo = MockAssetGenImage();
      final images = OnboardingImages(
        screen1: mock1,
        screen2: mock2,
        screen3: mock3,
        logo: mockLogo,
      );
      expect(images.screen1, mock1);
      expect(images.screen2, mock2);
      expect(images.screen3, mock3);
      expect(images.logo, mockLogo);
      expect(images.values, containsAll([mock1, mock2, mock3, mockLogo]));
    });
  });

  group('SplashImages', () {
    test('default constructor uses Assets', () {
      final images = SplashImages();
      expect(images.appLogo, equals(Assets.images.splash.appLogo));
      expect(images.background, equals(Assets.images.splash.splashBg));
      expect(images.values, containsAll([images.appLogo, images.background]));
    });

    test('custom constructor uses provided images', () {
      final mockLogo = MockAssetGenImage();
      final mockBg = MockAssetGenImage();
      final images = SplashImages(appLogo: mockLogo, background: mockBg);
      expect(images.appLogo, mockLogo);
      expect(images.background, mockBg);
      expect(images.values, containsAll([mockLogo, mockBg]));
    });
  });

  group('AppImage', () {
    test('light() returns AppImage with light theme images', () {
      final appImage = AppImage.light();
      expect(appImage.onboarding, isA<OnboardingImages>());
      expect(appImage.splash, isA<SplashImages>());
    });

    test('dark() returns AppImage with dark theme images', () {
      final appImage = AppImage.dark();
      expect(appImage.onboarding, isA<OnboardingImages>());
      expect(appImage.splash, isA<SplashImages>());
    });

    testWidgets('of() returns light theme for Brightness.light',
        (tester) async {
      late AppImage appImage;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Builder(
            builder: (context) {
              appImage = AppImage.of(context);
              return Container();
            },
          ),
        ),
      );
      expect(appImage.onboarding, isA<OnboardingImages>());
      expect(appImage.splash, isA<SplashImages>());
    });

    testWidgets('of() returns dark theme for Brightness.dark', (tester) async {
      late AppImage appImage;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Builder(
            builder: (context) {
              appImage = AppImage.of(context);
              return Container();
            },
          ),
        ),
      );
      expect(appImage.onboarding, isA<OnboardingImages>());
      expect(appImage.splash, isA<SplashImages>());
    });
  });
}
