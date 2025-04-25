import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_subtitle.dart';
import 'package:mocktail/mocktail.dart';

// Mocks (consider sharing these)
class MockAppTextStyles extends Mock implements AppTextStyles {}

class MockAppColors extends Mock implements AppColors {}

void main() {
  late MockAppTextStyles mockTextStyles;
  late MockAppColors mockColors;

  setUpAll(() {
    // Register mocks once
    mockTextStyles = MockAppTextStyles();
    mockColors = MockAppColors();
    GetIt.I.registerSingleton<AppTextStyles>(mockTextStyles);
    GetIt.I.registerSingleton<AppColors>(mockColors);

    // Common style setup
    when(() => mockColors.slateBlue)
        .thenReturn(Colors.green); // Use a distinct color
    when(
      () => mockTextStyles.headingSm(
        fontWeight: any(named: 'fontWeight'),
        color: any(named: 'color'),
      ),
    ).thenReturn(
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.green,
      ),
    );
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  group('HeaderSubtitle Atom', () {
    testWidgets('renders Text widget with correct text and key',
        (tester) async {
      const testText = 'Test Subtitle';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(text: testText),
          ),
        ),
      );

      final textFinder = find.text(testText);
      expect(textFinder, findsOneWidget);
      expect(
        find.byKey(const Key('onboarding_header_subtitle')),
        findsOneWidget,
      );
    });

    testWidgets('uses styles from GetIt by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(text: 'Default Style'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Default Style'));
      expect(textWidget.style?.fontSize, 16);
      expect(textWidget.style?.fontWeight, FontWeight.w500);
      expect(textWidget.style?.color, Colors.green);
    });

    testWidgets('accepts constructor injection for styles and colors',
        (tester) async {
      final customTextStyles = MockAppTextStyles();
      final customColors = MockAppColors();

      when(() => customColors.slateBlue).thenReturn(Colors.orange);
      when(
        () => customTextStyles.headingSm(
          fontWeight: any(named: 'fontWeight'),
          color: any(named: 'color'),
        ),
      ).thenReturn(
        const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(
              text: 'Injected Style',
              textStyles: customTextStyles,
              colors: customColors,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Injected Style'));
      expect(textWidget.style?.fontSize, 18);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.color, Colors.orange);

      // Verify the mocks were called
      verify(() => customColors.slateBlue).called(1);
      verify(
        () => customTextStyles.headingSm(
          fontWeight: FontWeight.w500,
          color: Colors.orange,
        ),
      ).called(1);
    });
  });
}
