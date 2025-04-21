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
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_dot_indicator.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_next_button.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_page_view.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_portrait_view.dart';
import 'package:mocktail/mocktail.dart';

class MockAppSizes extends Mock implements AppSizes {}

class MockAppTextStyles extends Mock implements AppTextStyles {}

class TestAppColors implements AppColors {
  @override
  MaterialColor get black => const MaterialColor(0xFF000000, <int, Color>{
        50: Color(0xFF000000),
        100: Color(0xFF000000),
        200: Color(0xFF000000),
        300: Color(0xFF000000),
        400: Color(0xFF000000),
        500: Color(0xFF000000),
        600: Color(0xFF000000),
        700: Color(0xFF000000),
        800: Color(0xFF000000),
        900: Color(0xFF000000),
      });

  @override
  MaterialColor get grey => Colors.grey;

  @override
  MaterialColor get onboardingBlue => Colors.blue;

  @override
  MaterialColor get primary => Colors.blue;

  @override
  MaterialColor get secondary => Colors.blue;

  @override
  MaterialColor get white => const MaterialColor(0xFFFFFFFF, <int, Color>{
        50: Color(0xFFFFFFFF),
        100: Color(0xFFFFFFFF),
        200: Color(0xFFFFFFFF),
        300: Color(0xFFFFFFFF),
        400: Color(0xFFFFFFFF),
        500: Color(0xFFFFFFFF),
        600: Color(0xFFFFFFFF),
        700: Color(0xFFFFFFFF),
        800: Color(0xFFFFFFFF),
        900: Color(0xFFFFFFFF),
      });

  @override
  Color get accent => Colors.blue;

  @override
  Color get accentDark => Colors.blue;

  @override
  Color get bgMain => Colors.white;

  @override
  Color get bgMainDark => Colors.black;

  @override
  Color get onboardingBackground => const Color(0xFFFFFFFF);

  @override
  Color get onboardingGradientEnd => const Color(0xFF2196F3);

  @override
  Color get onboardingGradientStart => const Color(0xFF2196F3);

  @override
  Color get primaryDark => Colors.blue;

  @override
  Color get secondaryDark => Colors.blue;

  @override
  Color get skipButtonColor => const Color(0xFF2196F3);

  @override
  Color get textPrimary => Colors.black;

  @override
  Color get textPrimaryDark => Colors.white;

  @override
  Color get textSecondary => Colors.grey;

  @override
  Color get textSecondaryDark => Colors.grey;

  @override
  Color get transparent => const Color(0x00000000);
}

class MockAppDurations extends Mock implements AppDurations {}

class MockAppImage extends Mock implements AppImage {}

void main() {
  late MockAppSizes mockSizes;
  late MockAppTextStyles mockTextStyles;
  late TestAppColors mockColors;
  late MockAppDurations mockDurations;
  late PageController pageController;
  late List<OnboardingInfo> slides;
  late VoidCallback onNextPressed;
  late VoidCallback onSkipPressed;
  late ValueChanged<int> onPageChanged;

  setUp(() {
    mockSizes = MockAppSizes();
    mockTextStyles = MockAppTextStyles();
    mockColors = TestAppColors();
    mockDurations = MockAppDurations();
    pageController = PageController();
    onNextPressed = () {};
    onSkipPressed = () {};
    onPageChanged = (_) {};

    // Mock sizes
    when(() => mockSizes.h4).thenReturn(4);
    when(() => mockSizes.h8).thenReturn(8);
    when(() => mockSizes.h12).thenReturn(12);
    when(() => mockSizes.h16).thenReturn(16);
    when(() => mockSizes.h24).thenReturn(24);
    when(() => mockSizes.h32).thenReturn(32);
    when(() => mockSizes.h40).thenReturn(40);
    when(() => mockSizes.h56).thenReturn(56);
    when(() => mockSizes.h80).thenReturn(80);
    when(() => mockSizes.h260).thenReturn(260);
    when(() => mockSizes.v8).thenReturn(8);
    when(() => mockSizes.v12).thenReturn(12);
    when(() => mockSizes.v16).thenReturn(16);
    when(() => mockSizes.v24).thenReturn(24);
    when(() => mockSizes.v32).thenReturn(32);
    when(() => mockSizes.v40).thenReturn(40);
    when(() => mockSizes.v48).thenReturn(48);
    when(() => mockSizes.v56).thenReturn(56);
    when(() => mockSizes.v260).thenReturn(260);
    when(() => mockSizes.r4).thenReturn(4);
    when(() => mockSizes.r16).thenReturn(16);
    when(() => mockSizes.r64).thenReturn(64);
    when(() => mockSizes.r80).thenReturn(80);
    when(() => mockSizes.borderRadiusMd).thenReturn(8);

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
    ).thenReturn(const TextStyle());
    when(
      () => mockTextStyles.headingSm(
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
    ).thenReturn(const TextStyle());
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
    ).thenReturn(const TextStyle());
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
          body: OnboardingPortraitView(
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

  group('OnboardingPortraitView', () {
    testWidgets('renders correctly in non-last page state', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Verify container background color
      expect(find.byType(Container), findsWidgets);

      // Verify header exists
      expect(find.byType(OnboardingHeader), findsOneWidget);

      // Verify PageView exists
      expect(find.byType(OnboardingPageView), findsOneWidget);

      // Verify dot indicator exists
      expect(find.byType(OnboardingDotIndicator), findsOneWidget);

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

      // Find and tap next button
      final nextButton = find.byType(OnboardingNextButton);
      expect(nextButton, findsOneWidget);
      await tester.tap(nextButton);
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

    testWidgets('displays correct page count in dot indicator', (tester) async {
      // Create a list with multiple slides
      slides = [
        OnboardingInfo(
          title: 'Test Title 1',
          description: 'Test Description 1',
          image: AppImage.of(MockBuildContext()).onboarding.logo,
        ),
        OnboardingInfo(
          title: 'Test Title 2',
          description: 'Test Description 2',
          image: AppImage.of(MockBuildContext()).onboarding.logo,
        ),
      ];

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Verify the dot indicator is showing the correct page count
      final dotIndicator = find.byType(OnboardingDotIndicator);
      expect(dotIndicator, findsOneWidget);

      // Verify the OnboardingDotIndicator was created with correct parameters
      final dotIndicatorWidget =
          tester.widget<OnboardingDotIndicator>(dotIndicator);
      expect(dotIndicatorWidget.pageCount, 2);
      expect(dotIndicatorWidget.currentIndex, 0);
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
