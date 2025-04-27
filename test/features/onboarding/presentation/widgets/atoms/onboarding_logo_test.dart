import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/onboarding_logo.dart';
import 'package:ksk_app/generated/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

// Mocks for dependencies
class MockAssetGenImage extends Mock implements AssetGenImage {
  final String _mockPath = 'assets/images/onboarding/logo.png';

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
        _mockPath,
        key: key,
        fit: fit,
        width: width,
        height: height,
      );

  @override
  String get path => _mockPath;
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

class MockAppSizes extends Mock implements AppSizes {
  @override
  double get h56 => 56;

  @override
  double get h32 => 32;

  @override
  double get r12 => 12;
}

void main() {
  late MockAppImage mockAppImage;
  late MockAppSizes mockAppSizes;

  setUpAll(() {
    // Register mocks once for all tests in this file
    mockAppImage = MockAppImage();
    mockAppSizes = MockAppSizes();
    GetIt.I.registerSingleton<AppImage>(mockAppImage);
    GetIt.I.registerSingleton<AppSizes>(mockAppSizes);
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  group('OnboardingLogo Atom', () {
    Widget buildTestApp(Widget widget) {
      // Use a theme with a defined surface color for testing
      return MaterialApp(
        theme: ThemeData(
          colorScheme: const ColorScheme.light(),
        ),
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

      // Verify container exists
      final containerFinder =
          find.byKey(const Key('onboarding_logo_container'));
      expect(containerFinder, findsOneWidget);

      // Verify container has correct size
      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints?.maxWidth, 56);
      expect(container.constraints?.maxHeight, 56);
      expect(container.color, Colors.white); // Theme surface color

      // Verify container is wrapped with ClipRRect with correct border radius
      final clipRRectFinder = find.ancestor(
        of: containerFinder,
        matching: find.byType(ClipRRect),
      );
      expect(clipRRectFinder, findsOneWidget);
      final clipRRect = tester.widget<ClipRRect>(clipRRectFinder);
      expect(clipRRect.borderRadius, BorderRadius.circular(12));

      // Verify SizedBox for image has correct size
      final imageSizedBoxFinder =
          find.byKey(const Key('onboarding_logo_image_container'));
      expect(imageSizedBoxFinder, findsOneWidget);
      final imageSizedBox = tester.widget<SizedBox>(imageSizedBoxFinder);
      expect(imageSizedBox.width, 32);
      expect(imageSizedBox.height, 32);

      // Verify Image is rendered
      expect(find.byKey(const Key('onboarding_logo_image')), findsOneWidget);
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

      // Verify container with correct size
      final containerFinder =
          find.byKey(const Key('onboarding_logo_container'));
      expect(containerFinder, findsOneWidget);
      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints?.maxWidth, testContainerSize);
      expect(container.constraints?.maxHeight, testContainerSize);

      // Verify custom background color
      expect(container.color, testContainerColor);

      // Verify ClipRRect with custom border radius
      final clipRRectFinder = find.ancestor(
        of: containerFinder,
        matching: find.byType(ClipRRect),
      );
      expect(clipRRectFinder, findsOneWidget);
      final clipRRect = tester.widget<ClipRRect>(clipRRectFinder);
      expect(clipRRect.borderRadius, BorderRadius.circular(testBorderRadius));

      // Verify SizedBox with correct size
      final imageSizedBoxFinder =
          find.byKey(const Key('onboarding_logo_image_container'));
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
              widget.properties.label == 'App logo - EIGA' &&
              widget.properties.header == false &&
              widget.properties.button == false,
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

      // Check container color is default (from theme)
      expect(container.color, Colors.white);

      // Check border radius is default
      final clipRRect = tester.widget<ClipRRect>(
        find.ancestor(
          of: find.byKey(const Key('onboarding_logo_container')),
          matching: find.byType(ClipRRect),
        ),
      );
      expect(clipRRect.borderRadius, BorderRadius.circular(12));

      // Check image size is as provided
      final imageSizedBox = tester.widget<SizedBox>(
        find.byKey(const Key('onboarding_logo_image_container')),
      );
      expect(imageSizedBox.width, imageSize);
      expect(imageSizedBox.height, imageSize);
    });

    testWidgets('only overrides imageSize', (tester) async {
      const customImgSize = 50.0;
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

      // Check container properties
      final container = tester.widget<Container>(
        find.byKey(const Key('onboarding_logo_container')),
      );
      expect(container.constraints?.maxWidth, containerSize);
      expect(container.constraints?.maxHeight, containerSize);
      expect(container.color, Colors.white); // Default from theme
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
      final clipRRect = tester.widget<ClipRRect>(
        find.ancestor(
          of: find.byKey(const Key('onboarding_logo_container')),
          matching: find.byType(ClipRRect),
        ),
      );
      expect(clipRRect.borderRadius, BorderRadius.circular(customRadius));

      // Check other properties remain default
      final container = tester.widget<Container>(
        find.byKey(const Key('onboarding_logo_container')),
      );
      expect(container.constraints?.maxWidth, 56);
      expect(container.constraints?.maxHeight, 56);
      expect(container.color, Colors.white); // Default from theme

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
      expect(container.color, customColor);

      // Check other properties remain default
      expect(container.constraints?.maxWidth, 56);
      expect(container.constraints?.maxHeight, 56);

      final clipRRect = tester.widget<ClipRRect>(
        find.ancestor(
          of: find.byKey(const Key('onboarding_logo_container')),
          matching: find.byType(ClipRRect),
        ),
      );
      expect(clipRRect.borderRadius, BorderRadius.circular(12));

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
        matching: find.byKey(const Key('onboarding_logo_image_container')),
      );
      expect(sizedBoxFinder, findsOneWidget);

      // Find Image inside SizedBox
      final imageFinder = find.descendant(
        of: sizedBoxFinder,
        matching: find.byKey(const Key('onboarding_logo_image')),
      );
      expect(imageFinder, findsOneWidget);
    });

    // Test for the assertion with small imageSize
    testWidgets('enforces imageSize <= containerSize assertion',
        (tester) async {
      expect(
        () => OnboardingLogo(
          containerSize: 50,
          imageSize: 60, // Larger than container size
        ),
        throwsAssertionError,
      );
    });

    // Test for the assertion requiring either containerSize or imageSize
    testWidgets('enforces either containerSize or imageSize must be provided',
        (tester) async {
      expect(
        OnboardingLogo.new,
        throwsAssertionError,
      );
    });

    // Thêm test case cho semanticLabel tùy chỉnh
    testWidgets('applies custom semantics label when provided', (tester) async {
      const customLabel = 'Custom Logo Label';

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
              semanticLabel: customLabel,
            ),
          ),
        ),
      );

      // Find Semantics with the custom label
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics && widget.properties.label == customLabel,
      );
      expect(semanticsFinder, findsOneWidget);
    });

    // Thêm test case cho testId tùy chỉnh
    testWidgets('uses custom testId for container when provided',
        (tester) async {
      const customKey = Key('custom_logo_container');

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
              testId: customKey,
            ),
          ),
        ),
      );

      // Verify custom key is used and default key is not
      expect(find.byKey(customKey), findsOneWidget);
      expect(find.byKey(const Key('onboarding_logo_container')), findsNothing);
    });

    // Thêm test case cho imageTestId tùy chỉnh
    testWidgets('uses custom imageTestId when provided', (tester) async {
      const customImageKey = Key('custom_logo_image');

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => buildTestApp(
            const OnboardingLogo(
              containerSize: 56,
              imageSize: 32,
              imageTestId: customImageKey,
            ),
          ),
        ),
      );

      // Verify custom image key is used and default image key is not
      expect(find.byKey(customImageKey), findsOneWidget);
      expect(find.byKey(const Key('onboarding_logo_image')), findsNothing);
    });
  });
}
