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
        MaterialApp(
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
        MaterialApp(
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

    testWidgets('accepts custom text style and color', (tester) async {
      const customTextStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
      const customColor = Colors.orange;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(
              text: 'Injected Style',
              textStyle: customTextStyle,
              color: customColor,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Injected Style'));
      expect(textWidget.style?.fontSize, 18);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.color, customColor);
    });

    testWidgets('uses default maxLines value when not specified',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(text: 'Default MaxLines'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Default MaxLines'));
      expect(textWidget.maxLines, 1);
    });

    testWidgets('accepts custom maxLines value', (tester) async {
      const customMaxLines = 3;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(
              text: 'Custom MaxLines',
              maxLines: customMaxLines,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Custom MaxLines'));
      expect(textWidget.maxLines, customMaxLines);
    });

    testWidgets('uses default textAlign value when not specified',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(text: 'Default TextAlign'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Default TextAlign'));
      expect(textWidget.textAlign, TextAlign.start);
    });

    testWidgets('accepts custom textAlign value', (tester) async {
      const customTextAlign = TextAlign.center;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(
              text: 'Custom TextAlign',
              textAlign: customTextAlign,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Custom TextAlign'));
      expect(textWidget.textAlign, customTextAlign);
    });
  });
}
