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
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/header_title_group.dart';
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

    when(() => mockColors.slateBlue).thenReturn(Colors.black);

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

      // Find Row which is now directly in OnboardingHeader
      expect(
        find.descendant(
          of: find.byType(OnboardingHeader),
          matching: find.byType(Row),
        ),
        findsOneWidget,
      );

      expect(find.byType(OnboardingLogo), findsOneWidget);

      // Find the Gap with default spacing value
      final rowFinder = find.byType(Row);

      final gapInRow = find.descendant(
        of: rowFinder,
        matching: find.byWidgetPredicate(
          (widget) => widget is Gap && widget.mainAxisExtent == 14.0.w,
        ),
      );
      expect(gapInRow, findsOneWidget);

      // Find HeaderTitleGroup
      expect(find.byType(HeaderTitleGroup), findsOneWidget);

      // Verify text content
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

    testWidgets('applies correct dimensions and logo properties',
        (tester) async {
      await tester.pumpWidget(buildTestApp(const OnboardingHeader()));

      await tester.pump();

      // Verify logo size and position
      final logoFinder = find.byKey(const Key('onboarding_header_logo'));
      expect(logoFinder, findsOneWidget);
      final logoWidget = tester.widget<OnboardingLogo>(logoFinder);
      expect(logoWidget.containerSize, 56); // From default AppSizes.v56

      // Verify image size (should be 63% of container size)
      expect(logoWidget.imageSize, 56 * 0.63);

      // Find the Row inside OnboardingHeader
      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      // Find Gap and verify default spacing
      final gapFinderInRow = find.descendant(
        of: rowFinder,
        matching: find.byWidgetPredicate(
          (widget) => widget is Gap && widget.mainAxisExtent == 14.0.w,
        ),
      );
      expect(gapFinderInRow, findsOneWidget);
      final gap = tester.widget<Gap>(gapFinderInRow);
      expect(gap.mainAxisExtent, 14.0.w);

      // Verify HeaderTitleGroup displays title and subtitle correctly
      expect(find.text('EIGA'), findsOneWidget);
      expect(find.text('CINEMA UI KIT.'), findsOneWidget);
    });

    testWidgets('logo uses correct BoxFit', (tester) async {
      await tester.pumpWidget(buildTestApp(const OnboardingHeader()));

      // Find Image inside OnboardingLogo by key
      final imageFinder = find.byKey(const Key('onboarding_logo_image'));
      expect(imageFinder, findsOneWidget);

      final image = tester.widget<Image>(imageFinder);
      expect(image.fit, equals(BoxFit.contain));
    });

    testWidgets('accepts custom spacing via constructor', (tester) async {
      const customSpacing = 28.0;

      await tester.pumpWidget(
        buildTestApp(
          const OnboardingHeader(
            spacing: customSpacing,
          ),
        ),
      );

      await tester.pump();

      // Find Row
      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      // Find Gap with custom spacing
      final gapFinderInRow = find.descendant(
        of: rowFinder,
        matching: find.byWidgetPredicate(
          (widget) => widget is Gap && widget.mainAxisExtent == customSpacing.w,
        ),
      );
      expect(gapFinderInRow, findsOneWidget);
      final gap = tester.widget<Gap>(gapFinderInRow);
      expect(gap.mainAxisExtent, customSpacing.w);
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

    testWidgets('accepts custom title and subtitle', (tester) async {
      const customTitle = 'CUSTOM TITLE';
      const customSubtitle = 'CUSTOM SUBTITLE';

      await tester.pumpWidget(
        buildTestApp(
          const OnboardingHeader(
            title: customTitle,
            subtitle: customSubtitle,
          ),
        ),
      );

      expect(find.text(customTitle), findsOneWidget);
      expect(find.text(customSubtitle), findsOneWidget);

      // Verify the HeaderTitleGroup receives the custom values
      final headerTitleGroupFinder = find.byType(HeaderTitleGroup);
      expect(headerTitleGroupFinder, findsOneWidget);

      final headerTitleGroup =
          tester.widget<HeaderTitleGroup>(headerTitleGroupFinder);
      expect(headerTitleGroup.title, equals(customTitle));
      expect(headerTitleGroup.subtitle, equals(customSubtitle));
    });
  });
}
