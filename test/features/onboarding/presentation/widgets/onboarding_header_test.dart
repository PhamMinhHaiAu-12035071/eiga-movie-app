import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_header.dart';
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
      expect(find.byType(Container), findsOneWidget);
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

    testWidgets('applies correct styles and dimensions', (tester) async {
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

      // Verify container properties
      final containerFinder = find.byType(Container);
      final containerWidget = tester.widget<Container>(containerFinder);
      expect(
        containerWidget.padding,
        EdgeInsets.symmetric(horizontal: mockSizes.h32),
      );
      expect(containerWidget.color, Colors.transparent);

      // Verify logo size
      final logoContainer = find.byType(SizedBox);
      final sizedBox = tester.widget<SizedBox>(logoContainer);
      expect(sizedBox.height, mockSizes.v56);

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
  });
}
