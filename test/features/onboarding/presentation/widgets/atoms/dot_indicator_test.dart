import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/dot_indicator.dart';
import 'package:mocktail/mocktail.dart';

class MockAppSizes extends Mock implements AppSizes {}

class MockAppColors extends Mock implements AppColors {}

class MockAppDurations extends Mock implements AppDurations {}

void main() {
  late MockAppSizes mockSizes;
  late MockAppColors mockColors;
  late MockAppDurations mockAppDurations;
  late MaterialColor mockOnboardingBlue;

  setUp(() {
    mockSizes = MockAppSizes();
    mockColors = MockAppColors();
    mockAppDurations = MockAppDurations();

    // Create a MaterialColor for onboardingBlue
    mockOnboardingBlue = const MaterialColor(0xFF7384A2, {
      50: Color(0xFFF0F2F6),
      100: Color(0xFFD9DEE7),
      200: Color(0xFFBFC8D8),
      300: Color(0xFFA5B2C9),
      400: Color(0xFF8A9BB8),
      500: Color(0xFF7384A2),
      600: Color(0xFF607395),
      700: Color(0xFF4C5C78),
      800: Color(0xFF3B475C),
      900: Color(0xFF2A3240),
    });

    // Setup size mocks
    when(() => mockSizes.h4).thenReturn(4);
    when(() => mockSizes.h8).thenReturn(8);
    when(() => mockSizes.h16).thenReturn(16);
    when(() => mockSizes.v8).thenReturn(8);
    when(() => mockSizes.r4).thenReturn(4);
    when(() => mockSizes.r8).thenReturn(8);

    // Setup color mocks
    when(() => mockColors.onboardingBlue).thenReturn(mockOnboardingBlue);

    // Setup duration mocks
    when(() => mockAppDurations.medium)
        .thenReturn(const Duration(milliseconds: 300));

    // Register mocks with GetIt
    GetIt.I.registerSingleton<AppSizes>(mockSizes);
    GetIt.I.registerSingleton<AppColors>(mockColors);
    GetIt.I.registerSingleton<AppDurations>(mockAppDurations);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  Widget buildTestWidget({
    required bool isActive,
    double? activeSize,
    double? inactiveSize,
    EdgeInsets? margin,
    double? borderRadius,
    Duration? duration,
    Curve? curve,
    Color? activeColor,
    double? inactiveOpacity,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: DotIndicator(
            isActive: isActive,
            activeSize: activeSize,
            inactiveSize: inactiveSize,
            margin: margin,
            borderRadius: borderRadius,
            duration: duration,
            curve: curve,
            activeColor: activeColor,
            inactiveOpacity: inactiveOpacity,
          ),
        ),
      ),
    );
  }

  group('DotIndicator', () {
    testWidgets('should render active dot with correct decoration',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(isActive: true));

      // Find the AnimatedContainer element in the widget tree
      final animatedContainer = find.descendant(
        of: find.byType(DotIndicator),
        matching: find.byType(AnimatedContainer),
      );

      // Get the raw AnimatedContainer widget
      final container = tester.widget<AnimatedContainer>(animatedContainer);

      // Verify decoration properties
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, equals(mockOnboardingBlue));
      expect(decoration.borderRadius, equals(BorderRadius.circular(8)));

      // Verify margins and duration
      expect(
        container.margin,
        equals(const EdgeInsets.symmetric(horizontal: 8)),
      );
      expect(container.duration, equals(const Duration(milliseconds: 300)));
      expect(container.curve, equals(Curves.easeInOut));

      // Verify the widget is rendered properly
      final renderBox = tester.renderObject<RenderBox>(animatedContainer);
      expect(renderBox, isNotNull);
    });

    testWidgets('should render inactive dot with correct color',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(isActive: false));

      // Find the AnimatedContainer
      final animatedContainer = find.descendant(
        of: find.byType(DotIndicator),
        matching: find.byType(AnimatedContainer),
      );

      // Get the container widget
      final container = tester.widget<AnimatedContainer>(animatedContainer);

      // Check decoration properties
      final decoration = container.decoration! as BoxDecoration;
      expect(
        decoration.color,
        equals(mockOnboardingBlue.withAlpha(102)), // 0.4 * 255 = 102
      );
      expect(
        decoration.borderRadius,
        equals(BorderRadius.circular(8)),
      );

      // Verify the widget is rendered properly
      final renderBox = tester.renderObject<RenderBox>(animatedContainer);
      expect(renderBox, isNotNull);
    });

    testWidgets('should have correct animation duration and curve',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(isActive: false));

      // Find and check the AnimatedContainer
      final animatedContainer = find.descendant(
        of: find.byType(DotIndicator),
        matching: find.byType(AnimatedContainer),
      );

      final container = tester.widget<AnimatedContainer>(animatedContainer);
      expect(
        container.duration,
        equals(const Duration(milliseconds: 300)),
      );
      expect(container.curve, equals(Curves.easeInOut));
    });

    testWidgets('should have correct margin', (tester) async {
      await tester.pumpWidget(buildTestWidget(isActive: false));

      // Find and check the AnimatedContainer
      final animatedContainer = find.descendant(
        of: find.byType(DotIndicator),
        matching: find.byType(AnimatedContainer),
      );

      final container = tester.widget<AnimatedContainer>(animatedContainer);
      expect(
        container.margin,
        equals(const EdgeInsets.symmetric(horizontal: 8)),
      );
    });

    testWidgets('should have correct semantics label', (tester) async {
      // Test active state
      await tester.pumpWidget(buildTestWidget(isActive: true));

      final semantics = tester.widget<Semantics>(
        find.descendant(
          of: find.byType(DotIndicator),
          matching: find.byType(Semantics),
        ),
      );
      expect(semantics.properties.label, equals('Onboarding step active'));

      // Test inactive state
      await tester.pumpWidget(buildTestWidget(isActive: false));

      final inactiveSemantics = tester.widget<Semantics>(
        find.descendant(
          of: find.byType(DotIndicator),
          matching: find.byType(Semantics),
        ),
      );
      expect(
        inactiveSemantics.properties.label,
        equals('Onboarding step inactive'),
      );
    });

    testWidgets('should render with custom margin', (tester) async {
      const customMargin = EdgeInsets.symmetric(horizontal: 16);

      await tester.pumpWidget(
        buildTestWidget(
          isActive: true,
          margin: customMargin,
        ),
      );

      // Find and check the AnimatedContainer
      final container = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byType(DotIndicator),
          matching: find.byType(AnimatedContainer),
        ),
      );

      expect(container.margin, equals(customMargin));
    });

    testWidgets('should render with custom border radius', (tester) async {
      const customBorderRadius = 16.0;

      await tester.pumpWidget(
        buildTestWidget(
          isActive: true,
          borderRadius: customBorderRadius,
        ),
      );

      // Find and check the AnimatedContainer
      final container = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byType(DotIndicator),
          matching: find.byType(AnimatedContainer),
        ),
      );

      final decoration = container.decoration! as BoxDecoration;
      expect(
        decoration.borderRadius,
        equals(BorderRadius.circular(customBorderRadius)),
      );
    });

    testWidgets('should render with custom duration and curve', (tester) async {
      const customDuration = Duration(milliseconds: 500);
      const customCurve = Curves.bounceIn;

      await tester.pumpWidget(
        buildTestWidget(
          isActive: true,
          duration: customDuration,
          curve: customCurve,
        ),
      );

      // Find and check the AnimatedContainer
      final container = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byType(DotIndicator),
          matching: find.byType(AnimatedContainer),
        ),
      );

      expect(container.duration, equals(customDuration));
      expect(container.curve, equals(customCurve));
    });

    testWidgets('should render with custom active color', (tester) async {
      const customColor = Colors.purple;

      await tester.pumpWidget(
        buildTestWidget(
          isActive: true,
          activeColor: customColor,
        ),
      );

      // Find and check the AnimatedContainer
      final container = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byType(DotIndicator),
          matching: find.byType(AnimatedContainer),
        ),
      );

      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, equals(customColor));
    });

    testWidgets('should render inactive dot with custom opacity',
        (tester) async {
      const customOpacity = 0.8;
      await tester.pumpWidget(
        buildTestWidget(isActive: false, inactiveOpacity: customOpacity),
      );

      // Find and check the AnimatedContainer
      final container = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byType(DotIndicator),
          matching: find.byType(AnimatedContainer),
        ),
      );

      final decoration = container.decoration! as BoxDecoration;

      // Verify the color with custom opacity (0.8 * 255 = 204)
      expect(
        decoration.color,
        equals(mockOnboardingBlue.withAlpha(204)),
      );
    });

    testWidgets('should accept boundary values for inactiveOpacity',
        (tester) async {
      // Test with minimum value 0.0
      await tester.pumpWidget(
        buildTestWidget(isActive: false, inactiveOpacity: 0),
      );
      expect(find.byType(DotIndicator), findsOneWidget);

      // Test with maximum value 1.0
      await tester.pumpWidget(
        buildTestWidget(isActive: false, inactiveOpacity: 1),
      );
      expect(find.byType(DotIndicator), findsOneWidget);
    });

    test('should throw assertion error for invalid inactiveOpacity', () {
      expect(
        () => DotIndicator(
          isActive: false,
          inactiveOpacity: -0.1, // Negative value
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => DotIndicator(
          isActive: false,
          inactiveOpacity: 1.1, // Greater than 1.0
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
