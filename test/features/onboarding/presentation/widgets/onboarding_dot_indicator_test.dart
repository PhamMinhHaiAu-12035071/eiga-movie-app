import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_dot_indicator.dart';
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

  Widget buildTestWidget({
    required int pageCount,
    required int currentIndex,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: OnboardingDotIndicator(
          pageCount: pageCount,
          currentIndex: currentIndex,
        ),
      ),
    );
  }

  group('OnboardingDotIndicator', () {
    testWidgets('should render correct number of dots', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 0));

      final dotFinder = find.byType(AnimatedContainer);
      expect(dotFinder, findsNWidgets(3));
    });

    testWidgets('should render active dot with correct properties',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 1));

      final containers = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();

      // Check active dot (index 1)
      final activeDot = containers[1];
      final activeDecoration = activeDot.decoration! as BoxDecoration;

      expect(activeDot.constraints!.maxWidth, equals(16.0));
      expect(activeDecoration.color, equals(mockOnboardingBlue));
      expect(activeDecoration.borderRadius, equals(BorderRadius.circular(4)));
    });

    testWidgets('should render inactive dots with correct properties',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 1));

      final containers = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();

      // Check inactive dots (index 0 and 2)
      for (final i in [0, 2]) {
        final inactiveDot = containers[i];
        final inactiveDecoration = inactiveDot.decoration! as BoxDecoration;

        expect(inactiveDot.constraints!.maxWidth, equals(8.0));
        expect(
          inactiveDecoration.color,
          equals(mockOnboardingBlue.withAlpha(102)),
        );
        expect(
          inactiveDecoration.borderRadius,
          equals(BorderRadius.circular(4)),
        );
      }
    });

    testWidgets('should have correct animation duration', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 0));

      final container = tester
          .widget<AnimatedContainer>(find.byType(AnimatedContainer).first);
      expect(container.duration, equals(const Duration(milliseconds: 300)));
    });

    testWidgets('should have correct layout properties', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 0));

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, equals(MainAxisAlignment.center));

      final container = tester
          .widget<AnimatedContainer>(find.byType(AnimatedContainer).first);
      expect(
        container.margin,
        equals(const EdgeInsets.symmetric(horizontal: 4)),
      );
      expect(container.constraints!.maxHeight, equals(8));
    });

    testWidgets('should handle edge cases - single dot', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 1, currentIndex: 0));

      final dotFinder = find.byType(AnimatedContainer);
      expect(dotFinder, findsOneWidget);

      final container = tester.widget<AnimatedContainer>(dotFinder);
      final decoration = container.decoration! as BoxDecoration;
      expect(container.constraints!.maxWidth, equals(16.0));
      expect(decoration.color, equals(mockOnboardingBlue));
    });

    testWidgets('should handle edge cases - last index', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 2));

      final containers = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();
      final lastDot = containers.last;
      final lastDotDecoration = lastDot.decoration! as BoxDecoration;

      expect(lastDot.constraints!.maxWidth, equals(16.0));
      expect(lastDotDecoration.color, equals(mockOnboardingBlue));
    });

    testWidgets('should handle edge cases - zero page count', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 0, currentIndex: 0));

      final dotFinder = find.byType(AnimatedContainer);
      expect(dotFinder, findsNothing);
    });

    testWidgets('should handle edge cases - negative current index',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: -1));

      final containers = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();

      // All dots should be inactive
      for (final dot in containers) {
        final decoration = dot.decoration! as BoxDecoration;
        expect(dot.constraints!.maxWidth, equals(8.0));
        expect(decoration.color, equals(mockOnboardingBlue.withAlpha(102)));
      }
    });

    testWidgets(
        'should handle edge cases - current index greater than page count',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 5));

      final containers = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();

      // All dots should be inactive
      for (final dot in containers) {
        final decoration = dot.decoration! as BoxDecoration;
        expect(dot.constraints!.maxWidth, equals(8.0));
        expect(decoration.color, equals(mockOnboardingBlue.withAlpha(102)));
      }
    });
  });
}
