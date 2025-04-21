import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/domain/models/onboarding_info.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_landscape_view.dart';
import 'package:mocktail/mocktail.dart';

class MockAppSizes extends Mock implements AppSizes {}

class MockAppTextStyles extends Mock implements AppTextStyles {}

class MockAppColors extends Mock implements AppColors {}

class MockAppImage extends Mock implements AppImage {}

class MockAppDurations extends Mock implements AppDurations {}

void main() {
  late MockAppSizes mockSizes;
  late MockAppTextStyles mockTextStyles;
  late MockAppColors mockColors;
  late MockAppDurations mockDurations;
  late PageController pageController;
  late List<OnboardingInfo> slides;
  late VoidCallback onNextPressed;
  late VoidCallback onSkipPressed;
  late ValueChanged<int> onPageChanged;

  setUp(() {
    mockSizes = MockAppSizes();
    mockTextStyles = MockAppTextStyles();
    mockColors = MockAppColors();
    mockDurations = MockAppDurations();
    pageController = PageController();
    onNextPressed = () {};
    onSkipPressed = () {};
    onPageChanged = (_) {};

    // Mock sizes
    when(() => mockSizes.h8).thenReturn(8);
    when(() => mockSizes.h12).thenReturn(12);
    when(() => mockSizes.h16).thenReturn(16);
    when(() => mockSizes.h32).thenReturn(32);
    when(() => mockSizes.h4).thenReturn(4);
    when(() => mockSizes.v8).thenReturn(8);
    when(() => mockSizes.v32).thenReturn(32);
    when(() => mockSizes.v40).thenReturn(40);
    when(() => mockSizes.v192).thenReturn(192);
    when(() => mockSizes.h192).thenReturn(192);
    when(() => mockSizes.r64).thenReturn(64);
    when(() => mockSizes.r4).thenReturn(4);
    when(() => mockSizes.borderRadiusMd).thenReturn(8);

    // Mock colors
    when(() => mockColors.onboardingBackground)
        .thenReturn(const Color(0xFFFFFFFF));
    when(() => mockColors.skipButtonColor).thenReturn(const Color(0xFF2196F3));
    when(() => mockColors.onboardingBlue).thenReturn(Colors.blue);
    when(() => mockColors.black).thenReturn(Colors.grey);
    when(() => mockColors.white).thenReturn(Colors.grey);
    when(() => mockColors.transparent).thenReturn(const Color(0x00000000));
    when(() => mockColors.onboardingGradientStart)
        .thenReturn(const Color(0xFF2196F3));
    when(() => mockColors.onboardingGradientEnd)
        .thenReturn(const Color(0xFF2196F3));
    when(() => mockColors.grey).thenReturn(Colors.grey);

    // Mock text styles
    when(
      () => mockTextStyles.headingLg(
        color: any(named: 'color'),
        fontWeight: any(named: 'fontWeight'),
      ),
    ).thenReturn(
      const TextStyle(),
    );
    when(
      () => mockTextStyles.headingXs(
        color: any(named: 'color'),
        fontWeight: any(named: 'fontWeight'),
      ),
    ).thenReturn(
      const TextStyle(),
    );
    when(
      () => mockTextStyles.heading(
        color: any(named: 'color'),
        fontWeight: any(named: 'fontWeight'),
      ),
    ).thenReturn(
      const TextStyle(),
    );
    when(
      () => mockTextStyles.body(
        color: any(named: 'color'),
        fontWeight: any(named: 'fontWeight'),
      ),
    ).thenReturn(
      const TextStyle(),
    );
    when(
      () => mockTextStyles.headingXl(
        color: any(named: 'color'),
        fontWeight: any(named: 'fontWeight'),
      ),
    ).thenReturn(
      const TextStyle(),
    );
    when(
      () => mockTextStyles.bodyLg(
        color: any(named: 'color'),
      ),
    ).thenReturn(
      const TextStyle(),
    );

    // Mock durations
    when(() => mockDurations.medium)
        .thenReturn(const Duration(milliseconds: 300));

    // Register mocks
    GetIt.I.registerSingleton<AppSizes>(mockSizes);
    GetIt.I.registerSingleton<AppTextStyles>(mockTextStyles);
    GetIt.I.registerSingleton<AppColors>(mockColors);
    GetIt.I.registerSingleton<AppDurations>(mockDurations);

    // Setup test slides
    slides = [
      OnboardingInfo(
        title: 'Test Title',
        description: 'Test Description',
        image: AppImage.of(MockBuildContext()).onboarding.logo,
      ),
    ];
  });

  tearDown(() {
    GetIt.I.reset();
    pageController.dispose();
  });

  Widget buildTestWidget({
    bool isLastPage = false,
    int currentPage = 0,
    VoidCallback? nextPressed,
    VoidCallback? skipPressed,
  }) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: OnboardingLandscapeView(
            pageController: pageController,
            slides: slides,
            currentPage: currentPage,
            isLastPage: isLastPage,
            onPageChanged: onPageChanged,
            onNextPressed: nextPressed ?? onNextPressed,
            onSkipPressed: skipPressed ?? onSkipPressed,
          ),
        ),
      ),
    );
  }

  group('OnboardingLandscapeView', () {
    testWidgets('renders correctly in non-last page state', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Verify container background color
      expect(find.byType(Container), findsWidgets);

      // Verify PageView exists
      expect(find.byType(PageView), findsOneWidget);

      // Verify Next button text
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
    });

    testWidgets('renders correctly in last page state', (tester) async {
      await tester.pumpWidget(buildTestWidget(isLastPage: true));
      await tester.pumpAndSettle();

      // Verify Get Started button text
      expect(find.text('Get Started'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
    });

    testWidgets('calls onNextPressed when Next/Get Started is tapped',
        (tester) async {
      var nextPressed = false;
      await tester.pumpWidget(
        buildTestWidget(
          nextPressed: () => nextPressed = true,
        ),
      );

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(nextPressed, true);
    });

    testWidgets('calls onSkipPressed when Skip is tapped', (tester) async {
      var skipPressed = false;
      await tester.pumpWidget(
        buildTestWidget(
          skipPressed: () => skipPressed = true,
        ),
      );

      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(skipPressed, true);
    });

    testWidgets('displays slide content correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
