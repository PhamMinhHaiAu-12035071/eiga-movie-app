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

  Widget buildTestWidget({required bool isActive}) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: DotIndicator(
            isActive: isActive,
          ),
        ),
      ),
    );
  }

  group('DotIndicator', () {
    testWidgets('should render active dot with correct properties',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(isActive: true));

      // Find the DotIndicator first
      final dotIndicator = find.byType(DotIndicator);
      expect(dotIndicator, findsOneWidget);

      // Then find Semantics within the DotIndicator
      final semantics = find.descendant(
        of: dotIndicator,
        matching: find.byType(Semantics),
      );
      expect(semantics, findsOneWidget);

      // Find the AnimatedContainer within that Semantics
      final container = find.descendant(
        of: semantics,
        matching: find.byType(AnimatedContainer),
      );
      expect(container, findsOneWidget);

      final containerWidget = tester.widget<AnimatedContainer>(container);
      final decoration = containerWidget.decoration! as BoxDecoration;

      // Verify the properties
      expect(containerWidget.constraints?.minWidth, equals(16.0));
      expect(decoration.color, equals(mockOnboardingBlue));
      expect(decoration.borderRadius, equals(BorderRadius.circular(4)));
    });

    testWidgets('should render inactive dot with correct properties',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(isActive: false));

      // Find the DotIndicator first
      final dotIndicator = find.byType(DotIndicator);

      // Then find Semantics within the DotIndicator
      final semantics = find.descendant(
        of: dotIndicator,
        matching: find.byType(Semantics),
      );

      // Find the AnimatedContainer within that Semantics
      final container = find.descendant(
        of: semantics,
        matching: find.byType(AnimatedContainer),
      );

      final containerWidget = tester.widget<AnimatedContainer>(container);
      final decoration = containerWidget.decoration! as BoxDecoration;

      // Verify the properties
      expect(containerWidget.constraints?.minWidth, equals(8.0));
      expect(
        decoration.color,
        equals(mockOnboardingBlue.withAlpha(102)), // 0.4 * 255 = 102
      );
      expect(
        decoration.borderRadius,
        equals(BorderRadius.circular(4)),
      );
    });

    testWidgets('should have correct animation duration', (tester) async {
      await tester.pumpWidget(buildTestWidget(isActive: false));

      // Find the DotIndicator first
      final dotIndicator = find.byType(DotIndicator);

      // Then find Semantics within the DotIndicator
      final semantics = find.descendant(
        of: dotIndicator,
        matching: find.byType(Semantics),
      );

      // Find the AnimatedContainer within that Semantics
      final container = find.descendant(
        of: semantics,
        matching: find.byType(AnimatedContainer),
      );

      final containerWidget = tester.widget<AnimatedContainer>(container);

      // Verify the duration
      expect(
        containerWidget.duration,
        equals(const Duration(milliseconds: 300)),
      );
    });

    testWidgets('should have correct layout properties', (tester) async {
      await tester.pumpWidget(buildTestWidget(isActive: false));

      // Find the DotIndicator first
      final dotIndicator = find.byType(DotIndicator);

      // Then find Semantics within the DotIndicator
      final semantics = find.descendant(
        of: dotIndicator,
        matching: find.byType(Semantics),
      );

      // Find the AnimatedContainer within that Semantics
      final container = find.descendant(
        of: semantics,
        matching: find.byType(AnimatedContainer),
      );

      final containerWidget = tester.widget<AnimatedContainer>(container);

      // Verify the properties
      expect(
        containerWidget.margin,
        equals(const EdgeInsets.symmetric(horizontal: 4)),
      );
      expect(containerWidget.constraints?.minHeight, equals(8));
    });

    testWidgets('should have correct semantics label', (tester) async {
      await tester.pumpWidget(buildTestWidget(isActive: true));

      // Find the DotIndicator first
      final dotIndicator = find.byType(DotIndicator);

      // Then find the Semantics within the DotIndicator
      final semanticsWidget = find.descendant(
        of: dotIndicator,
        matching: find.byType(Semantics),
      );

      final semantics = tester.widget<Semantics>(semanticsWidget);
      expect(semantics.properties.label, equals('Active onboarding step'));

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
        equals('Inactive onboarding step'),
      );
    });
  });
}
