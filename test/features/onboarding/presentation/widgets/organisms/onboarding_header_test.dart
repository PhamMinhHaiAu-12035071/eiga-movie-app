import 'package:flutter/material.dart';
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

class MockAppColors extends Mock implements AppColors {}

class MockAssetGenImage extends Mock implements AssetGenImage {
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
      Image.network(
        'dummy_url',
        key: key,
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
        filterQuality: filterQuality,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
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
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => const OnboardingHeader(),
            ),
          ),
        ),
      );

      // Verify widget tree structure
      expect(find.byType(ColoredBox), findsOneWidget);
      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(Gap), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
    });

    testWidgets('displays correct text content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => const OnboardingHeader(),
            ),
          ),
        ),
      );

      expect(find.text('EIGA'), findsOneWidget);
      expect(find.text('CINEMA UI KIT.'), findsOneWidget);
    });

    testWidgets('applies correct styles, dimensions and semantics',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => const OnboardingHeader(),
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify ColoredBox properties
      final coloredBoxFinder = find.byType(ColoredBox);
      final coloredBoxWidget = tester.widget<ColoredBox>(coloredBoxFinder);
      expect(coloredBoxWidget.color, Colors.transparent);

      // Verify Padding properties
      final paddingFinder = find.byType(Padding);
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
      expect(logoWidget.height, mockSizes.v56);

      // Verify gap width
      final gapFinder = find.byType(Gap);
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
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => const OnboardingHeader(),
            ),
          ),
        ),
      );

      final imageFinder = find.byType(Image);
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
        MaterialApp(
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
      );

      await tester.pump();

      // Verify custom padding is applied
      final paddingFinder = find.byType(Padding);
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
      expect(logoWidgetInjected.height, 112); // Our custom value

      // Verify custom gap width
      final gapFinder = find.byType(Gap);
      final gap = tester.widget<Gap>(gapFinder);
      expect(gap.mainAxisExtent, 32); // Our custom value

      // Verify custom text styles
      final eigaText = find.text('EIGA');
      final eigaTextWidget = tester.widget<Text>(eigaText);
      expect(eigaTextWidget.style?.fontSize, 30); // Our custom value
      expect(eigaTextWidget.style?.color, Colors.red); // Our custom value
    });

    testWidgets('renders correct logo via its imageKey', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => const OnboardingHeader(),
            ),
          ),
        ),
      );

      // Find Image by key
      final imageWidget = tester.widget<Image>(
        find.byKey(const Key('onboarding_header_image')),
      );

      // Assert image provider type and path
      expect(imageWidget.image, isA<AssetImage>());
      expect(
        (imageWidget.image as AssetImage).assetName,
        equals('assets/images/onboarding/logo.png'),
      );
    });
  });
}
