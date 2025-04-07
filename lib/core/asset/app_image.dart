import 'package:flutter/material.dart';
import 'package:ksk_app/generated/assets.gen.dart';

/// A class that provides access to all image assets in the application.
///
/// This class follows the factory pattern to provide different sets of images
/// based on themes (light/dark) or other conditions (like screen size).
@immutable
class AppImage {
  /// Returns the appropriate [AppImage] instance
  /// based on the current theme brightness
  factory AppImage.of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? AppImage.light() : AppImage.dark();
  }

  /// Creates an instance with the light theme images.
  ///
  /// This is the default for the app.
  factory AppImage.light() => AppImage._(
        onboarding: OnboardingImages(),
        splash: SplashImages(),
      );

  /// Creates an instance with dark theme images.
  ///
  /// Use this when the app is in dark mode. Currently identical
  /// to light mode, but can be customized when dark variants
  /// of images are added.
  factory AppImage.dark() => AppImage._(
        onboarding: OnboardingImages(),
        splash: SplashImages(),
      );

  const AppImage._({
    required this.onboarding,
    required this.splash,
  });

  /// Onboarding screen images
  final OnboardingImages onboarding;

  /// Splash screen images
  final SplashImages splash;
}

/// A class that contains all onboarding images
@immutable
class OnboardingImages {
  /// Creates a new instance of [OnboardingImages]
  OnboardingImages({
    AssetGenImage? screen1,
    AssetGenImage? screen2,
    AssetGenImage? screen3,
  })  : screen1 = screen1 ?? Assets.images.onboarding.onboarding1,
        screen2 = screen2 ?? Assets.images.onboarding.onboarding2,
        screen3 = screen3 ?? Assets.images.onboarding.onboarding3;

  /// Image for the first onboarding screen
  final AssetGenImage screen1;

  /// Image for the second onboarding screen
  final AssetGenImage screen2;

  /// Image for the third onboarding screen
  final AssetGenImage screen3;

  /// Returns all onboarding images as a list
  List<AssetGenImage> get values => [screen1, screen2, screen3];
}

/// A class that contains all splash screen images
@immutable
class SplashImages {
  /// Creates a new instance of [SplashImages]
  SplashImages({
    AssetGenImage? appLogo,
    AssetGenImage? background,
  })  : appLogo = appLogo ?? Assets.images.splash.appLogo,
        background = background ?? Assets.images.splash.splashBg;

  /// The app logo displayed on splash screen
  final AssetGenImage appLogo;

  /// The background image for splash screen
  final AssetGenImage background;

  /// Returns all splash images as a list
  List<AssetGenImage> get values => [appLogo, background];
}
