import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/onboarding_logo.dart';
import 'package:ksk_app/generated/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

// Mocks for dependencies (can be shared or moved to a helper file)
class MockAssetGenImage extends Mock implements AssetGenImage {
  final String _mockPath =
      'assets/images/onboarding/logo.png'; // Store mock path

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
  }) =>
      Image.asset(
        // Use Image.asset
        _mockPath, // Use the mock path
        key: key,
        fit: fit,
        width: width,
        height: height,
      );

  @override
  String get path => _mockPath; // Return the mock path
}

class MockOnboardingImages extends Mock implements OnboardingImages {
  final _mockLogo = MockAssetGenImage();
  @override
  AssetGenImage get logo => _mockLogo;
}

class MockAppImage extends Mock implements AppImage {
  final _mockOnboarding = MockOnboardingImages();
  @override
  OnboardingImages get onboarding => _mockOnboarding;
}

void main() {
  late MockAppImage mockAppImage;

  setUpAll(() {
    // Register AppImage once for all tests in this file
    mockAppImage = MockAppImage();
    GetIt.I.registerSingleton<AppImage>(mockAppImage);
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  group('OnboardingLogo Atom', () {
    testWidgets('renders correctly with given height', (tester) async {
      const testHeight = 100.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OnboardingLogo(height: testHeight),
          ),
        ),
      );

      // Verify SizedBox with correct height
      final sizedBoxFinder = find.byType(SizedBox);
      expect(sizedBoxFinder, findsOneWidget);
      final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      expect(sizedBox.height, testHeight);

      // Verify Image is rendered
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('applies correct semantics', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OnboardingLogo(height: 50),
          ),
        ),
      );

      // Find the OnboardingLogo widget first
      final logoFinder = find.byType(OnboardingLogo);
      expect(logoFinder, findsOneWidget);

      // Find Semantics with the correct label within the OnboardingLogo widget
      final semanticsFinder = find.descendant(
        of: logoFinder,
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Semantics &&
              widget.properties.label == 'App logo - EIGA',
        ),
      );
      expect(semanticsFinder, findsOneWidget);

      // Check if the specific test key exists within the logo widget
      expect(
        find.descendant(
          of: logoFinder,
          matching: find.byKey(const Key('onboarding_logo_image')),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Image uses BoxFit.contain and correct key', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OnboardingLogo(height: 50),
          ),
        ),
      );

      final imageFinder = find.byKey(const Key('onboarding_header_image'));
      expect(imageFinder, findsOneWidget);

      final image = tester.widget<Image>(imageFinder);
      expect(image.fit, BoxFit.contain);
    });

    testWidgets('Image uses correct asset path', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OnboardingLogo(height: 50),
          ),
        ),
      );

      final imageFinder = find.byKey(const Key('onboarding_header_image'));
      final imageWidget = tester.widget<Image>(imageFinder);

      // Verify that the image provider type is AssetImage and path matches
      expect(imageWidget.image, isA<AssetImage>());
      expect(
        (imageWidget.image as AssetImage).assetName,
        mockAppImage.onboarding.logo.path,
      );
    });
  });
}
