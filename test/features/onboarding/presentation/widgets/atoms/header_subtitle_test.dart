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

      // Check that semantics properties are set correctly
      final semanticsWidget = tester.widget<Semantics>(
        find.descendant(
          of: find.byType(HeaderSubtitle),
          matching: find.byType(Semantics),
        ),
      );
      expect(semanticsWidget.properties.header, isFalse); // Not a header
      expect(semanticsWidget.properties.label, testText);
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

    testWidgets('accepts custom text style and color', (tester) async {
      const customTextStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
      const customColor = Colors.orange;

      await tester.pumpWidget(
        const MaterialApp(
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
        const MaterialApp(
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
        const MaterialApp(
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
        const MaterialApp(
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
        const MaterialApp(
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

    testWidgets('uses default overflow value when not specified',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(text: 'Default Overflow'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Default Overflow'));
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('accepts custom overflow value', (tester) async {
      const customOverflow = TextOverflow.fade;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(
              text: 'Custom Overflow',
              overflow: customOverflow,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Custom Overflow'));
      expect(textWidget.overflow, customOverflow);
    });

    testWidgets('throws assertion error when text is empty', (tester) async {
      expect(
        () => HeaderSubtitle(text: ''),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            contains('Header text must not be empty'),
          ),
        ),
      );
    });

    testWidgets('throws assertion error when maxLines is <= 0', (tester) async {
      expect(
        () => HeaderSubtitle(text: 'Valid Text', maxLines: 0),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            contains('maxLines must be positive'),
          ),
        ),
      );

      expect(
        () => HeaderSubtitle(text: 'Valid Text', maxLines: -1),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            contains('maxLines must be positive'),
          ),
        ),
      );
    });

    // Additional test for isHeader getter
    test('should have isHeader = false', () {
      const widget = HeaderSubtitle(text: 'Test');
      expect(widget.isHeader, isFalse);
    });

    // Additional test for textKey getter
    test('should have correct textKey', () {
      const widget = HeaderSubtitle(text: 'Test');
      expect(widget.textKey, const Key('onboarding_header_subtitle'));
    });

    // New test for custom fontWeight
    testWidgets('should use custom fontWeight when provided', (tester) async {
      const customFontWeight = FontWeight.w600;

      // Set up specific mock for this test
      when(
        () => mockTextStyles.headingSm(
          fontWeight: customFontWeight,
          color: any(named: 'color'),
        ),
      ).thenReturn(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.green,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(
              text: 'Custom Weight',
              fontWeight: customFontWeight,
            ),
          ),
        ),
      );

      // Verify the method was called with expected fontWeight
      verify(
        () => mockTextStyles.headingSm(
          fontWeight: customFontWeight,
          color: any(named: 'color'),
        ),
      ).called(1);
    });

    // New test for custom semanticLabel
    testWidgets('should use custom semanticLabel when provided',
        (tester) async {
      const customLabel = 'Custom Accessibility Label';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(
              text: 'Subtitle Text',
              semanticLabel: customLabel,
            ),
          ),
        ),
      );

      final semanticsWidget = tester.widget<Semantics>(
        find.descendant(
          of: find.byType(HeaderSubtitle),
          matching: find.byType(Semantics),
        ),
      );
      expect(semanticsWidget.properties.label, customLabel);
    });

    // New test for custom testId
    testWidgets('should use custom testId when provided', (tester) async {
      const customKey = Key('custom_header_subtitle_key');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderSubtitle(
              text: 'With Custom Key',
              testId: customKey,
            ),
          ),
        ),
      );

      expect(find.byKey(customKey), findsOneWidget);
      expect(find.byKey(const Key('onboarding_header_subtitle')), findsNothing);
    });
  });
}
