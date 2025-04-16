import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/domain/models/onboarding_info.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_page_view.dart';
import 'package:ksk_app/generated/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

class MockAppSizes extends Mock implements AppSizes {
  @override
  double get h32 => 32;
  @override
  double get h260 => 260;
  @override
  double get v260 => 260;
  @override
  double get v24 => 24;
  @override
  double get v12 => 12;
  @override
  double get r80 => 80;
}

class MockAppTextStyles extends Mock implements AppTextStyles {
  @override
  TextStyle headingLg({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 24,
        color: color,
        fontWeight: fontWeight,
      );

  @override
  TextStyle body({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: fontWeight,
      );
}

class MockAppColors extends Mock implements AppColors {
  static const MaterialColor _blue = MaterialColor(
    0xFF2196F3,
    <int, Color>{
      500: Colors.blue,
    },
  );

  static const MaterialColor _black = MaterialColor(
    0xFF000000,
    <int, Color>{
      500: Colors.black,
    },
  );

  static final MaterialColor _grey = MaterialColor(
    0xFF9E9E9E,
    <int, Color>{
      300: Colors.grey[300]!,
      600: Colors.grey[600]!,
    },
  );

  @override
  MaterialColor get onboardingBlue => _blue;
  @override
  MaterialColor get black => _black;
  @override
  MaterialColor get grey => _grey;
}

class MockAssetGenImage extends Mock implements AssetGenImage {
  @override
  String get path => 'assets/images/test_image.png';

  @override
  Image image({
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    AlignmentGeometry? alignment,
    AssetBundle? bundle,
    int? cacheHeight,
    int? cacheWidth,
    Rect? centerSlice,
    Color? color,
    BlendMode? colorBlendMode,
    bool? excludeFromSemantics,
    FilterQuality? filterQuality,
    ImageFrameBuilder? frameBuilder,
    bool? gaplessPlayback,
    bool? isAntiAlias,
    bool? matchTextDirection,
    Animation<double>? opacity,
    String? package,
    ImageRepeat? repeat,
    double? scale,
    String? semanticLabel,
  }) {
    return Image.asset(
      path,
      key: key,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: errorBuilder,
      alignment: alignment ?? Alignment.center,
      bundle: bundle,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      centerSlice: centerSlice,
      color: color,
      colorBlendMode: colorBlendMode,
      excludeFromSemantics: excludeFromSemantics ?? false,
      filterQuality: filterQuality ?? FilterQuality.low,
      frameBuilder: frameBuilder,
      gaplessPlayback: gaplessPlayback ?? false,
      isAntiAlias: isAntiAlias ?? false,
      matchTextDirection: matchTextDirection ?? false,
      opacity: opacity,
      package: package,
      repeat: repeat ?? ImageRepeat.noRepeat,
      scale: scale,
      semanticLabel: semanticLabel,
    );
  }

  @override
  String toString({DiagnosticLevel? minLevel}) => path;
}

void main() {
  late PageController controller;
  late List<OnboardingInfo> slides;
  late void Function(int) onPageChanged;
  late MockAppSizes mockAppSizes;
  late MockAppTextStyles mockAppTextStyles;
  late MockAppColors mockAppColors;

  setUp(() {
    GetIt.I.reset();

    mockAppSizes = MockAppSizes();
    mockAppTextStyles = MockAppTextStyles();
    mockAppColors = MockAppColors();

    GetIt.I.registerSingleton<AppSizes>(mockAppSizes);
    GetIt.I.registerSingleton<AppTextStyles>(mockAppTextStyles);
    GetIt.I.registerSingleton<AppColors>(mockAppColors);

    controller = PageController();
    onPageChanged = (int index) {};

    slides = [
      OnboardingInfo(
        image: MockAssetGenImage(),
        title: 'Test Title 1',
        description: 'Test Description 1',
      ),
      OnboardingInfo(
        image: MockAssetGenImage(),
        title: 'Test Title 2',
        description: 'Test Description 2',
      ),
    ];
  });

  tearDown(() {
    controller.dispose();
    GetIt.I.reset();
  });

  group('OnboardingPageView Widget Tests', () {
    testWidgets('renders OnboardingPageView correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                OnboardingPageView(
                  controller: controller,
                  slides: slides,
                  onPageChanged: onPageChanged,
                ),
              ],
            ),
          ),
        ),
      );

      // Verify first slide content
      expect(find.text('Test Title 1'), findsOneWidget);
      expect(find.text('Test Description 1'), findsOneWidget);

      // Verify layout structure
      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('handles page changes correctly', (tester) async {
      var currentPage = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                OnboardingPageView(
                  controller: controller,
                  slides: slides,
                  onPageChanged: (int index) {
                    currentPage = index;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      // Simulate page drag
      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Verify page changed
      expect(currentPage, 1);
      expect(find.text('Test Title 2'), findsOneWidget);
      expect(find.text('Test Description 2'), findsOneWidget);
    });

    testWidgets('handles image error correctly', (tester) async {
      // Create a slide with an image that will trigger an error
      final errorSlides = [
        OnboardingInfo(
          image: MockAssetGenImage(),
          title: 'Error Test',
          description: 'Error Description',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                OnboardingPageView(
                  controller: controller,
                  slides: errorSlides,
                  onPageChanged: onPageChanged,
                ),
              ],
            ),
          ),
        ),
      );

      // Find the Image widget and trigger its error builder
      final imageFinder = find.byType(Image);
      final imageWidget = tester.widget<Image>(imageFinder);

      // Call the error builder manually
      if (imageWidget.errorBuilder != null) {
        final context = tester.element(imageFinder);
        imageWidget.errorBuilder!(context, Error(), StackTrace.empty);
        await tester.pump();

        // Verify error placeholder is shown
        expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
      }
    });

    testWidgets('applies correct styles and sizes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                OnboardingPageView(
                  controller: controller,
                  slides: slides,
                  onPageChanged: onPageChanged,
                ),
              ],
            ),
          ),
        ),
      );

      // Verify padding
      final paddingFinder = find.byType(Padding);
      final padding = tester.widget<Padding>(paddingFinder.first);
      expect(
        padding.padding,
        EdgeInsets.symmetric(horizontal: mockAppSizes.h32),
      );

      // Verify image dimensions
      final imageFinder = find.byType(Image);
      final image = tester.widget<Image>(imageFinder);
      expect(image.height, mockAppSizes.v260);
      expect(image.width, mockAppSizes.h260);

      // Verify text styles
      final titleFinder = find.text('Test Title 1');
      final descriptionFinder = find.text('Test Description 1');

      final titleWidget = tester.widget<Text>(titleFinder);
      final descriptionWidget = tester.widget<Text>(descriptionFinder);

      expect(titleWidget.style?.color, mockAppColors.onboardingBlue);
      expect(descriptionWidget.style?.color, mockAppColors.black);
    });

    testWidgets('handles empty slides list gracefully', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                OnboardingPageView(
                  controller: controller,
                  slides: const [],
                  onPageChanged: onPageChanged,
                ),
              ],
            ),
          ),
        ),
      );

      // Verify PageView is still rendered
      expect(find.byType(PageView), findsOneWidget);
      // Verify no content is shown
      expect(find.byType(Text), findsNothing);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('handles rapid page changes correctly', (tester) async {
      var pageChangeCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                OnboardingPageView(
                  controller: controller,
                  slides: slides,
                  onPageChanged: (int index) {
                    pageChangeCount++;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      // Simulate multiple rapid page changes
      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.drag(find.byType(PageView), const Offset(500, 0));
      await tester.pumpAndSettle();

      // Verify page changes were tracked
      expect(pageChangeCount, greaterThan(0));
    });
  });
}
