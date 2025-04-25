import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
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

class MockAppColors extends Mock implements AppColors {
  @override
  MaterialColor get white => const MaterialColor(
        0xFFFFFFFF, // White color
        <int, Color>{
          50: Colors.white,
          100: Colors.white,
          200: Colors.white,
          300: Colors.white,
          400: Colors.white,
          500: Colors.white,
          600: Colors.white,
          700: Colors.white,
          800: Colors.white,
          900: Colors.white,
        },
      );
}

void main() {
  late MockAppImage mockAppImage;
  late MockAppColors mockAppColors;

  setUpAll(() {
    // Register mocks once for all tests in this file
    mockAppImage = MockAppImage();
    mockAppColors = MockAppColors();
    GetIt.I.registerSingleton<AppImage>(mockAppImage);
    GetIt.I.registerSingleton<AppColors>(mockAppColors);
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  group('OnboardingLogo Atom', () {
    Widget buildTestApp(Widget widget) {
      return MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      );
    }

    testWidgets('renders correctly with default parameters', (tester) async {
      // Initialize ScreenUtil for the test
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(const OnboardingLogo()),
        ),
      );

      // Verify Container has correct size and border radius
      final containerFinder =
          find.byKey(const Key('onboarding_logo_container'));
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints?.maxWidth, 59.sp);
      expect(container.constraints?.maxHeight, 59.sp);

      final boxDecoration = container.decoration! as BoxDecoration;
      expect((boxDecoration.borderRadius! as BorderRadius).topLeft.x, 12.r);

      // Verify container background color
      expect(boxDecoration.color, mockAppColors.white);

      // Verify SizedBox for image has correct size
      final imageSizedBoxFinder =
          find.byKey(const Key('onboarding_logo_image'));
      expect(imageSizedBoxFinder, findsOneWidget);

      final imageSizedBox = tester.widget<SizedBox>(imageSizedBoxFinder);
      expect(imageSizedBox.width, 37.sp);
      expect(imageSizedBox.height, 37.sp);

      // Verify Image is rendered
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders correctly with custom parameters', (tester) async {
      const testContainerSize = 100.0;
      const testImageSize = 60.0;
      const testBorderRadius = 20.0;
      const testContainerColor = Colors.blue;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: testContainerSize,
              imageSize: testImageSize,
              borderRadius: testBorderRadius,
              containerColor: testContainerColor,
            ),
          ),
        ),
      );

      // Verify Container with correct size and border radius
      final containerFinder =
          find.byKey(const Key('onboarding_logo_container'));
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints?.maxWidth, testContainerSize);
      expect(container.constraints?.maxHeight, testContainerSize);

      final boxDecoration = container.decoration! as BoxDecoration;
      expect(
        (boxDecoration.borderRadius! as BorderRadius).topLeft.x,
        testBorderRadius,
      );

      // Verify custom background color
      expect(boxDecoration.color, testContainerColor);

      // Verify SizedBox with correct size
      final imageSizedBoxFinder =
          find.byKey(const Key('onboarding_logo_image'));
      expect(imageSizedBoxFinder, findsOneWidget);

      final imageSizedBox = tester.widget<SizedBox>(imageSizedBoxFinder);
      expect(imageSizedBox.width, testImageSize);
      expect(imageSizedBox.height, testImageSize);
    });

    testWidgets('applies correct semantics', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(const OnboardingLogo()),
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
    });

    testWidgets('Image uses BoxFit.contain and correct key', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(const OnboardingLogo()),
        ),
      );

      final imageFinder = find.byKey(const Key('onboarding_header_image'));
      expect(imageFinder, findsOneWidget);

      final image = tester.widget<Image>(imageFinder);
      expect(image.fit, BoxFit.contain);
    });

    testWidgets('Image uses correct asset path', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(const OnboardingLogo()),
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
