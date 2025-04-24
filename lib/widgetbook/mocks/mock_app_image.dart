import 'package:flutter/material.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/generated/assets.gen.dart';

/// A mock implementation of AppImage for Widgetbook
class MockAppImage {
  /// Creates a mock instance for Widgetbook
  MockAppImage({
    OnboardingImages? onboarding,
    SplashImages? splash,
  })  : onboarding = onboarding ?? MockOnboardingImages(),
        splash = splash ?? MockSplashImages();

  /// Constructor that mimics AppImage.of(context)
  factory MockAppImage.of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_MockAppImageProvider>();
    return provider?.mockAppImage ?? MockAppImage();
  }

  /// Onboarding screen images
  final OnboardingImages onboarding;

  /// Splash screen images
  final SplashImages splash;

  /// Provides mock AppImage in the widget tree
  static Widget provider({required Widget child}) {
    return _MockAppImageProvider(
      mockAppImage: MockAppImage(),
      child: child,
    );
  }
}

/// Provider for MockAppImage
class _MockAppImageProvider extends InheritedWidget {
  const _MockAppImageProvider({
    required this.mockAppImage,
    required super.child,
  });

  final MockAppImage mockAppImage;

  @override
  bool updateShouldNotify(_MockAppImageProvider oldWidget) =>
      mockAppImage != oldWidget.mockAppImage;
}

/// Mock onboarding images
class MockOnboardingImages extends OnboardingImages {
  /// Creates mock onboarding images
  MockOnboardingImages()
      : super(
          screen1:
              MockAssetGenImage('assets/images/onboarding/onboarding1.png'),
          screen2:
              MockAssetGenImage('assets/images/onboarding/onboarding2.png'),
          screen3:
              MockAssetGenImage('assets/images/onboarding/onboarding3.png'),
          logo: MockAssetGenImage('assets/images/onboarding/logo.png'),
        );
}

/// Mock splash images
class MockSplashImages extends SplashImages {
  /// Creates mock splash images
  MockSplashImages()
      : super(
          appLogo: MockAssetGenImage('assets/images/splash/app_logo.png'),
          background: MockAssetGenImage('assets/images/splash/splash_bg.png'),
        );
}

/// Mock asset gen image that renders a colored box or placeholder
class MockAssetGenImage extends AssetGenImage {
  /// Creates a mock asset
  MockAssetGenImage(super.path);

  @override
  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    // For Widgetbook, just show a placeholder with the asset name
    return Image.asset(
      path,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: (context, error, stackTrace) {
        // If asset loading fails, show a colored box with the path
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Text(
            path.split('/').last,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        );
      },
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }
}
