import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/dot_indicator.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/dot_indicator_row.dart';
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
    required int pageCount,
    required int currentIndex,
    double? spacing,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: DotIndicatorRow(
          pageCount: pageCount,
          currentIndex: currentIndex,
          spacing: spacing,
        ),
      ),
    );
  }

  group('DotIndicatorRow', () {
    testWidgets('should render correct number of dots', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 0));

      final dotFinder = find.byType(DotIndicator);
      expect(dotFinder, findsNWidgets(3));
    });

    testWidgets('should pass correct isActive property to dots',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 1));

      final dots =
          tester.widgetList<DotIndicator>(find.byType(DotIndicator)).toList();

      expect(dots[0].isActive, isFalse);
      expect(dots[1].isActive, isTrue);
      expect(dots[2].isActive, isFalse);
    });

    testWidgets('should have correct layout properties', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 0));

      // Kiểm tra có Center wrap _dotList trong DotIndicatorRow
      expect(find.byType(Center), findsOneWidget);

      // Đảm bảo Center là parent của Row
      final center = tester.widget<Center>(find.byType(Center));
      expect(center.child, isA<Row>());
    });

    testWidgets('should handle edge cases - large page count', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 10, currentIndex: 5));

      final dotFinder = find.byType(DotIndicator);
      expect(dotFinder, findsNWidgets(10));

      final dots =
          tester.widgetList<DotIndicator>(find.byType(DotIndicator)).toList();
      expect(dots[5].isActive, isTrue);
    });

    testWidgets('should apply correct spacing between dots', (tester) async {
      const testSpacing = 20.0;
      await tester.pumpWidget(
        buildTestWidget(
          pageCount: 3,
          currentIndex: 0,
          spacing: testSpacing,
        ),
      );

      // Find Gap widgets (our spacers)
      final spacers = tester.widgetList<Gap>(find.byType(Gap)).toList();

      // There should be 2 spacers for 3 dots
      expect(spacers.length, equals(2));

      // All spacers should have the specified width
      for (final spacer in spacers) {
        expect(spacer.mainAxisExtent, equals(testSpacing));
      }
    });

    testWidgets('should use default spacing from context when spacing is null',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          pageCount: 3,
          currentIndex: 0,
        ),
      );

      // Find Gap widgets and verify they exist
      final spacers = find.byType(Gap);
      expect(spacers, findsWidgets);

      // Kiểm tra sử dụng kích thước mặc định h8 từ context
      final spacerWidgets = tester.widgetList<Gap>(spacers).toList();
      for (final spacer in spacerWidgets) {
        expect(spacer.mainAxisExtent, equals(8));
      }
    });

    testWidgets('should wrap dots with semantic information', (tester) async {
      await tester.pumpWidget(buildTestWidget(pageCount: 3, currentIndex: 1));

      // Verify DotIndicator widgets are wrapped with Semantics
      final dotIndicators = find.byType(DotIndicator);
      expect(dotIndicators, findsNWidgets(3));

      // Verify Semantics are present in the widget tree
      final semanticsWithLabel = find.byWidgetPredicate((widget) {
        return widget is Semantics && widget.properties.label != null;
      });
      expect(semanticsWithLabel, findsWidgets);

      // Tìm semantics cụ thể cho DotIndicator (không phải semantics của atoms/dot_indicator.dart)
      final dotSemantics = find.byWidgetPredicate((widget) {
        return widget is Semantics &&
            widget.properties.label != null &&
            widget.properties.label!.contains('Trang');
      });

      expect(dotSemantics, findsNWidgets(3));

      // Kiểm tra nội dung label có phù hợp
      final semantics = tester.widgetList<Semantics>(dotSemantics).toList();
      expect(semantics[0].properties.label, equals('Trang 1 trên 3'));
      expect(semantics[1].properties.label, equals('Trang 2 trên 3'));
      expect(semantics[2].properties.label, equals('Trang 3 trên 3'));
    });
  });
}
