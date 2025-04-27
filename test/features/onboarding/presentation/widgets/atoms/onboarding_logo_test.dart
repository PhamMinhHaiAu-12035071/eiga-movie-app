import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
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

class MockAppSizes extends Mock implements AppSizes {
  @override
  double get h56 => 56.0;

  @override
  double get h32 => 32.0;

  @override
  double get r12 => 12.0;
}

void main() {
  late MockAppImage mockAppImage;
  late MockAppColors mockAppColors;
  late MockAppSizes mockAppSizes;

  setUpAll(() {
    // Register mocks once for all tests in this file
    mockAppImage = MockAppImage();
    mockAppColors = MockAppColors();
    mockAppSizes = MockAppSizes();
    GetIt.I.registerSingleton<AppImage>(mockAppImage);
    GetIt.I.registerSingleton<AppColors>(mockAppColors);
    GetIt.I.registerSingleton<AppSizes>(mockAppSizes);
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
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
            ),
          ),
        ),
      );

      // Verify Container has correct size and border radius
      final containerFinder = find.descendant(
        of: find.byType(OnboardingLogo),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints?.maxWidth, 56);
      expect(container.constraints?.maxHeight, 56);

      final boxDecoration = container.decoration! as BoxDecoration;
      expect((boxDecoration.borderRadius! as BorderRadius).topLeft.x, 12);

      // Verify container background color
      expect(boxDecoration.color, mockAppColors.white);

      // Verify SizedBox for image has correct size
      final imageSizedBoxFinder = find.descendant(
        of: find.byType(OnboardingLogo),
        matching: find.byType(SizedBox),
      );
      expect(imageSizedBoxFinder, findsOneWidget);

      final imageSizedBox = tester.widget<SizedBox>(imageSizedBoxFinder);
      expect(imageSizedBox.width, 32);
      expect(imageSizedBox.height, 32);

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
      final containerFinder = find.descendant(
        of: find.byType(OnboardingLogo),
        matching: find.byType(Container),
      );
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
      final imageSizedBoxFinder = find.descendant(
        of: find.byType(OnboardingLogo),
        matching: find.byType(SizedBox),
      );
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
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
            ),
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
    });

    testWidgets('Image uses BoxFit.contain and correct key', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
            ),
          ),
        ),
      );

      final imageFinder = find.byKey(const Key('onboarding_logo_image'));
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
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
            ),
          ),
        ),
      );

      final imageFinder = find.byKey(const Key('onboarding_logo_image'));
      final imageWidget = tester.widget<Image>(imageFinder);

      // Verify that the image provider type is AssetImage and path matches
      expect(imageWidget.image, isA<AssetImage>());
      expect(
        (imageWidget.image as AssetImage).assetName,
        mockAppImage.onboarding.logo.path,
      );
    });

    // NEW TESTS BELOW

    testWidgets('uses correct key for container', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
            ),
          ),
        ),
      );

      expect(
        find.byKey(const Key('onboarding_logo_container')),
        findsOneWidget,
      );
    });

    testWidgets('uses correct key for imageContainer', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
            ),
          ),
        ),
      );

      expect(
        find.byKey(const Key('onboarding_logo_image_container')),
        findsOneWidget,
      );
    });

    testWidgets('only overrides containerSize', (tester) async {
      const customSize = 80.0;
      // Also need to provide imageSize that's less than customSize
      const imageSize = 40.0;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: customSize,
              imageSize: imageSize,
            ),
          ),
        ),
      );

      // Check container size is overridden
      final container = tester.widget<Container>(
        find.byKey(const Key('onboarding_logo_container')),
      );
      expect(container.constraints?.maxWidth, customSize);
      expect(container.constraints?.maxHeight, customSize);

      // Check other properties remain default
      final boxDecoration = container.decoration! as BoxDecoration;
      expect((boxDecoration.borderRadius! as BorderRadius).topLeft.x, 12);
      expect(boxDecoration.color, mockAppColors.white);

      // Check image size is as provided
      final imageSizedBox = tester.widget<SizedBox>(
        find.byKey(const Key('onboarding_logo_image_container')),
      );
      expect(imageSizedBox.width, imageSize);
      expect(imageSizedBox.height, imageSize);
    });

    testWidgets('only overrides imageSize', (tester) async {
      const customImgSize = 50.0;
      // Make container size larger than image size to satisfy the assertion
      const containerSize = 70.0;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: containerSize,
              imageSize: customImgSize,
            ),
          ),
        ),
      );

      // Check image size is overridden
      final imageSizedBox = tester.widget<SizedBox>(
        find.byKey(const Key('onboarding_logo_image_container')),
      );
      expect(imageSizedBox.width, customImgSize);
      expect(imageSizedBox.height, customImgSize);

      // Check container properties remain as set
      final container = tester.widget<Container>(
        find.byKey(const Key('onboarding_logo_container')),
      );
      expect(container.constraints?.maxWidth, containerSize);
      expect(container.constraints?.maxHeight, containerSize);

      final boxDecoration = container.decoration! as BoxDecoration;
      expect((boxDecoration.borderRadius! as BorderRadius).topLeft.x, 12);
      expect(boxDecoration.color, mockAppColors.white);
    });

    testWidgets('only overrides borderRadius', (tester) async {
      const customRadius = 25.0;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
              borderRadius: customRadius,
            ),
          ),
        ),
      );

      // Check border radius is overridden
      final container = tester.widget<Container>(
        find.byKey(const Key('onboarding_logo_container')),
      );
      final boxDecoration = container.decoration! as BoxDecoration;
      expect(
        (boxDecoration.borderRadius! as BorderRadius).topLeft.x,
        customRadius,
      );

      // Check other properties remain default
      expect(container.constraints?.maxWidth, 56);
      expect(container.constraints?.maxHeight, 56);
      expect(boxDecoration.color, mockAppColors.white);

      // Check image size remains default
      final imageSizedBox = tester.widget<SizedBox>(
        find.byKey(const Key('onboarding_logo_image_container')),
      );
      expect(imageSizedBox.width, 32);
      expect(imageSizedBox.height, 32);
    });

    testWidgets('only overrides containerColor', (tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
              containerColor: customColor,
            ),
          ),
        ),
      );

      // Check color is overridden
      final container = tester.widget<Container>(
        find.byKey(const Key('onboarding_logo_container')),
      );
      final boxDecoration = container.decoration! as BoxDecoration;
      expect(boxDecoration.color, customColor);

      // Check other properties remain default
      expect(container.constraints?.maxWidth, 56);
      expect(container.constraints?.maxHeight, 56);
      expect((boxDecoration.borderRadius! as BorderRadius).topLeft.x, 12);

      // Check image size remains default
      final imageSizedBox = tester.widget<SizedBox>(
        find.byKey(const Key('onboarding_logo_image_container')),
      );
      expect(imageSizedBox.width, 32);
      expect(imageSizedBox.height, 32);
    });

    testWidgets('has correct widget tree structure', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
            ),
          ),
        ),
      );

      // Find Container
      final containerFinder =
          find.byKey(const Key('onboarding_logo_container'));
      expect(containerFinder, findsOneWidget);

      // Find Center inside Container
      final centerFinder = find.descendant(
        of: containerFinder,
        matching: find.byType(Center),
      );
      expect(centerFinder, findsOneWidget);

      // Find SizedBox inside Center
      final sizedBoxFinder = find.descendant(
        of: centerFinder,
        matching: find.byType(SizedBox),
      );
      expect(sizedBoxFinder, findsOneWidget);

      // Find Image inside SizedBox
      final imageFinder = find.descendant(
        of: sizedBoxFinder,
        matching: find.byType(Image),
      );
      expect(imageFinder, findsOneWidget);
    });
  });
}
