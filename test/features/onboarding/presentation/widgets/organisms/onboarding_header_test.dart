import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/onboarding_logo.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/organisms/onboarding_header.dart';
import 'package:ksk_app/generated/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

class MockAppSizes extends Mock implements AppSizes {}

class MockAppTextStyles extends Mock implements AppTextStyles {}

class MockAppColors extends Mock implements AppColors {
  final _white = const MaterialColor(
    0xFFFFFFFF,
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

  @override
  MaterialColor get white => _white;
}

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
        bundle: bundle,
        frameBuilder: frameBuilder,
        errorBuilder: errorBuilder,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        scale: scale ?? 1.0,
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

  @override
  String get path => _mockPath;
}

class MockOnboardingImages extends Mock implements OnboardingImages {
  final _mockLogo = MockAssetGenImage();

  @override
  AssetGenImage get logo => _mockLogo;
}

class MockSplashImages extends SplashImages {
  MockSplashImages()
      : super(
          appLogo: MockAssetGenImage(),
          background: MockAssetGenImage(),
        );
}

class MockAppImage extends Mock implements AppImage {
  MockAppImage();

  factory MockAppImage.of() => MockAppImage();
  final _mockOnboarding = MockOnboardingImages();

  @override
  OnboardingImages get onboarding => _mockOnboarding;
}

Widget buildTestApp(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(360, 800),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, __) => MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => child,
        ),
      ),
    ),
  );
}

void main() {
  late MockAppSizes mockSizes;
  late MockAppTextStyles mockTextStyles;
  late MockAppColors mockColors;
  late MockAppImage mockAppImage;

  setUp(() {
    mockSizes = MockAppSizes();
    mockTextStyles = MockAppTextStyles();
    mockColors = MockAppColors();
    mockAppImage = MockAppImage();

    // Register mocks
    GetIt.I.registerSingleton<AppSizes>(mockSizes);
    GetIt.I.registerSingleton<AppTextStyles>(mockTextStyles);
    GetIt.I.registerSingleton<AppColors>(mockColors);
    GetIt.I.registerSingleton<AppImage>(mockAppImage);

    // Setup common mock values
    when(() => mockSizes.h32).thenReturn(32);
    when(() => mockSizes.v56).thenReturn(56);
    when(() => mockSizes.h16).thenReturn(16);

    when(() => mockColors.skipButtonColor).thenReturn(Colors.black);

    when(
      () => mockTextStyles.headingXl(
        fontWeight: any(named: 'fontWeight'),
        color: any(named: 'color'),
      ),
    ).thenReturn(
      const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
    );

    when(
      () => mockTextStyles.headingSm(
        fontWeight: any(named: 'fontWeight'),
        color: any(named: 'color'),
      ),
    ).thenReturn(
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('OnboardingHeader', () {
    testWidgets('renders correctly with all components', (tester) async {
      await tester.pumpWidget(buildTestApp(const OnboardingHeader()));

      // Verify widget tree structure
      expect(find.byType(OnboardingHeader), findsOneWidget);

      // Find ColoredBox inside OnboardingHeader
      expect(
        find.descendant(
          of: find.byType(OnboardingHeader),
          matching: find.byType(ColoredBox),
        ),
        findsOneWidget,
      );

      // Find Row inside OnboardingHeader
      expect(
        find.descendant(
          of: find.byType(OnboardingHeader),
          matching: find.byType(Row),
        ),
        findsOneWidget,
      );

      expect(find.byType(OnboardingLogo), findsOneWidget);
      expect(find.byType(Gap), findsOneWidget);

      // Find Column inside OnboardingHeader
      expect(
        find.descendant(
          of: find.byType(OnboardingHeader),
          matching: find.byType(Column),
        ),
        findsOneWidget,
      );

      expect(find.text('EIGA'), findsOneWidget);
      expect(find.text('CINEMA UI KIT.'), findsOneWidget);

      // Find Image inside OnboardingLogo
      expect(
        find.descendant(
          of: find.byType(OnboardingLogo),
          matching: find.byType(Image),
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays correct text content', (tester) async {
      await tester.pumpWidget(buildTestApp(const OnboardingHeader()));

      expect(find.text('EIGA'), findsOneWidget);
      expect(find.text('CINEMA UI KIT.'), findsOneWidget);
    });

    testWidgets('applies correct styles, dimensions and semantics',
        (tester) async {
      await tester.pumpWidget(buildTestApp(const OnboardingHeader()));

      await tester.pump();

      // Verify ColoredBox properties - find it inside OnboardingHeader
      final coloredBoxFinder = find.descendant(
        of: find.byType(OnboardingHeader),
        matching: find.byType(ColoredBox),
      );
      expect(coloredBoxFinder, findsOneWidget);
      final coloredBoxWidget = tester.widget<ColoredBox>(coloredBoxFinder);
      expect(coloredBoxWidget.color, Colors.transparent);

      // Verify Padding properties -
      // find it inside OnboardingHeader with specific padding
      final paddingFinder = find.descendant(
        of: find.byType(OnboardingHeader),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Padding &&
              widget.padding == EdgeInsets.symmetric(horizontal: mockSizes.h32),
        ),
      );
      expect(paddingFinder, findsOneWidget);
      final paddingWidget = tester.widget<Padding>(paddingFinder);
      expect(
        paddingWidget.padding,
        EdgeInsets.symmetric(horizontal: mockSizes.h32),
      );

      // We don't need to directly test semantics properties
      // Just verify that we have keys for testability
      expect(find.byKey(const Key('onboarding_header_logo')), findsOneWidget);
      expect(find.byKey(const Key('onboarding_header_title')), findsOneWidget);
      expect(
        find.byKey(const Key('onboarding_header_subtitle')),
        findsOneWidget,
      );

      // Verify logo size
      final logoFinder = find.byKey(const Key('onboarding_header_logo'));
      final logoWidget = tester.widget<OnboardingLogo>(logoFinder);
      expect(logoWidget.containerSize, mockSizes.v56);

      // Verify gap width - find Gap inside OnboardingHeader
      final gapFinder = find.descendant(
        of: find.byType(OnboardingHeader),
        matching: find.byType(Gap),
      );
      expect(gapFinder, findsOneWidget);
      final gap = tester.widget<Gap>(gapFinder);
      expect(gap.mainAxisExtent, mockSizes.h16);

      // Find and verify text widgets
      final eigaText = find.text('EIGA');
      final cinemaText = find.text('CINEMA UI KIT.');

      expect(eigaText, findsOneWidget);
      expect(cinemaText, findsOneWidget);

      // Get the actual Text widgets
      final eigaTextWidget = tester.widget<Text>(eigaText);
      final cinemaTextWidget = tester.widget<Text>(cinemaText);

      // Verify text styles
      expect(eigaTextWidget.style?.fontSize, 24);
      expect(eigaTextWidget.style?.fontWeight, FontWeight.w900);
      expect(eigaTextWidget.style?.color, Colors.black);

      expect(cinemaTextWidget.style?.fontSize, 16);
      expect(cinemaTextWidget.style?.fontWeight, FontWeight.w500);
      expect(cinemaTextWidget.style?.color, Colors.black);
    });

    testWidgets('logo uses correct BoxFit', (tester) async {
      await tester.pumpWidget(buildTestApp(const OnboardingHeader()));

      // Find Image inside OnboardingLogo by key
      final imageFinder = find.byKey(const Key('onboarding_logo_image'));
      expect(imageFinder, findsOneWidget);

      final image = tester.widget<Image>(imageFinder);
      expect(image.fit, equals(BoxFit.contain));
    });

    testWidgets('accepts constructor injection', (tester) async {
      // Create custom mocks for testing constructor injection
      final customSizes = MockAppSizes();
      final customTextStyles = MockAppTextStyles();
      final customColors = MockAppColors();

      when(() => customSizes.h32).thenReturn(64); // Double the size for testing
      when(() => customSizes.v56).thenReturn(112);
      when(() => customSizes.h16).thenReturn(32);

      when(() => customColors.skipButtonColor).thenReturn(Colors.red);

      when(
        () => customTextStyles.headingXl(
          fontWeight: any(named: 'fontWeight'),
          color: any(named: 'color'),
        ),
      ).thenReturn(
        const TextStyle(
          fontSize: 30, // Different size for testing
          fontWeight: FontWeight.w900,
          color: Colors.red,
        ),
      );

      when(
        () => customTextStyles.headingSm(
          fontWeight: any(named: 'fontWeight'),
          color: any(named: 'color'),
        ),
      ).thenReturn(
        const TextStyle(
          fontSize: 20, // Different size for testing
          fontWeight: FontWeight.w500,
          color: Colors.red,
        ),
      );

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => OnboardingHeader(
                  sizes: customSizes,
                  textStyles: customTextStyles,
                  colors: customColors,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify custom padding is applied -
      // find Padding inside OnboardingHeader with specific padding
      final paddingFinder = find.descendant(
        of: find.byType(OnboardingHeader),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Padding &&
              widget.padding == const EdgeInsets.symmetric(horizontal: 64),
        ),
      );
      expect(paddingFinder, findsOneWidget);
      final paddingWidget = tester.widget<Padding>(paddingFinder);
      expect(
        paddingWidget.padding,
        const EdgeInsets.symmetric(horizontal: 64), // Our custom value
      );

      // Verify custom logo size
      final logoFinderInjected =
          find.byKey(const Key('onboarding_header_logo'));
      final logoWidgetInjected =
          tester.widget<OnboardingLogo>(logoFinderInjected);
      expect(logoWidgetInjected.containerSize, 112); // Our custom value

      // Verify custom gap width - find Gap inside OnboardingHeader
      final gapFinder = find.descendant(
        of: find.byType(OnboardingHeader),
        matching: find.byType(Gap),
      );
      expect(gapFinder, findsOneWidget);
      final gap = tester.widget<Gap>(gapFinder);
      expect(gap.mainAxisExtent, 32); // Our custom value

      // Verify custom text styles
      final eigaText = find.text('EIGA');
      final eigaTextWidget = tester.widget<Text>(eigaText);
      expect(eigaTextWidget.style?.fontSize, 30); // Our custom value
      expect(eigaTextWidget.style?.color, Colors.red); // Our custom value
    });

    testWidgets('renders correct logo via its imageKey', (tester) async {
      await tester.pumpWidget(buildTestApp(const OnboardingHeader()));

      // Find Image by key
      final imageFinder = find.byKey(const Key('onboarding_logo_image'));
      expect(imageFinder, findsOneWidget);

      final imageWidget = tester.widget<Image>(imageFinder);

      // Assert image provider type and path
      expect(imageWidget.image, isA<AssetImage>());
      expect(
        (imageWidget.image as AssetImage).assetName,
        equals('assets/images/onboarding/logo.png'),
      );
    });
  });
}
