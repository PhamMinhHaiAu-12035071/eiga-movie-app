import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_title.dart';
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
        .thenReturn(Colors.blue); // Use a distinct color
    when(
      () => mockTextStyles.headingXl(
        fontWeight: any(named: 'fontWeight'),
        color: any(named: 'color'),
      ),
    ).thenReturn(
      const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: Colors.blue,
      ),
    );
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  group('HeaderTitle Atom', () {
    testWidgets('renders Text widget with correct text, key, and semantics',
        (tester) async {
      const testText = 'Test Title';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitle(text: testText),
          ),
        ),
      );

      final textFinder = find.text(testText);
      expect(textFinder, findsOneWidget);
      expect(find.byKey(const Key('onboarding_header_title')), findsOneWidget);

      // Check that semantics properties are set correctly
      final semanticsWidget = tester.widget<Semantics>(
        find.descendant(
          of: find.byType(HeaderTitle),
          matching: find.byType(Semantics),
        ),
      );
      expect(semanticsWidget.properties.header, isTrue);
      expect(semanticsWidget.properties.label, testText);
    });

    testWidgets('uses styles from GetIt by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitle(text: 'Default Style'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Default Style'));
      expect(textWidget.style?.fontSize, 24);
      expect(textWidget.style?.fontWeight, FontWeight.w900);
      expect(textWidget.style?.color, Colors.blue);
    });

    testWidgets('accepts constructor injection for styles and colors',
        (tester) async {
      // Create the text style that will be passed to HeaderTitle
      const customTextStyle = TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitle(
              text: 'Injected Style',
              textStyle: customTextStyle,
              color: Colors.red,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Injected Style'));
      expect(textWidget.style?.fontSize, 30);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.color, Colors.red);
    });

    testWidgets('applies default maxLines of 1 and TextOverflow.ellipsis',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitle(text: 'Default MaxLines'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Default MaxLines'));
      expect(textWidget.maxLines, 1);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('accepts custom maxLines value', (tester) async {
      const customMaxLines = 2;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitle(
              text: 'Custom MaxLines',
              maxLines: customMaxLines,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Custom MaxLines'));
      expect(textWidget.maxLines, customMaxLines);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('applies default textAlign of TextAlign.start', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitle(text: 'Default TextAlign'),
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
            body: HeaderTitle(
              text: 'Custom TextAlign',
              textAlign: customTextAlign,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Custom TextAlign'));
      expect(textWidget.textAlign, customTextAlign);
    });

    testWidgets('accepts custom overflow value', (tester) async {
      const customOverflow = TextOverflow.fade;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitle(
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
        () => HeaderTitle(text: ''),
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
        () => HeaderTitle(text: 'Valid Text', maxLines: 0),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            contains('maxLines must be positive'),
          ),
        ),
      );

      expect(
        () => HeaderTitle(text: 'Valid Text', maxLines: -1),
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
    test('should have isHeader = true', () {
      const widget = HeaderTitle(text: 'Test');
      expect(widget.isHeader, isTrue);
    });

    // Additional test for textKey getter
    test('should have correct textKey', () {
      const widget = HeaderTitle(text: 'Test');
      expect(widget.textKey, const Key('onboarding_header_title'));
    });

    // Additional test for semanticLabel getter
    test('should have semanticLabel equal to text', () {
      const widget = HeaderTitle(text: 'Test Label');
      expect(widget.semanticLabel, 'Test Label');
    });
  });
}
