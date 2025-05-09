import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/base_header_text.dart';

// Test implementation of BaseHeaderText
class TestHeaderText extends BaseHeaderText {
  const TestHeaderText({
    required super.text,
    super.key,
    super.textStyle,
    super.color,
    super.maxLines,
    super.textAlign,
    super.overflow,
    super.semanticLabel,
    super.testId,
    this.isHeaderValue = true,
  });

  final bool isHeaderValue;

  @override
  bool get isHeader => isHeaderValue;

  @override
  Key get textKey => const Key('test_header_text');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    return textStyle ?? const TextStyle(fontSize: 16, color: Colors.black);
  }
}

void main() {
  group('BaseHeaderText', () {
    testWidgets('should render Text with correct properties', (tester) async {
      const testText = 'Test Header';
      const testStyle = TextStyle(fontSize: 18, color: Colors.red);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestHeaderText(
              text: testText,
              textStyle: testStyle,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      );

      // Verify Text widget exists with correct text
      expect(find.text(testText), findsOneWidget);

      // Verify properties are correctly set
      final textWidget = tester.widget<Text>(find.text(testText));
      expect(textWidget.style, testStyle);
      expect(textWidget.maxLines, 2);
      expect(textWidget.textAlign, TextAlign.center);
      expect(textWidget.overflow, TextOverflow.fade);
    });

    testWidgets('should pass isHeader to Semantics', (tester) async {
      // First test with header=true
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestHeaderText(
              text: 'Header Text',
            ),
          ),
        ),
      );

      final semanticsWidget = tester.widget<Semantics>(
        find.descendant(
          of: find.byType(TestHeaderText),
          matching: find.byType(Semantics),
        ),
      );
      expect(semanticsWidget.properties.header, isTrue);

      // Now test with header=false
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestHeaderText(
              text: 'Not Header Text',
              isHeaderValue: false,
            ),
          ),
        ),
      );

      final notHeaderSemantics = tester.widget<Semantics>(
        find.descendant(
          of: find.byType(TestHeaderText),
          matching: find.byType(Semantics),
        ),
      );
      expect(notHeaderSemantics.properties.header, isFalse);
    });

    testWidgets('should use custom semanticLabel when provided',
        (tester) async {
      const testText = 'Regular Text';
      const customLabel = 'Custom Accessibility Label';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestHeaderText(
              text: testText,
              semanticLabel: customLabel,
            ),
          ),
        ),
      );

      final semanticsWidget = tester.widget<Semantics>(
        find.descendant(
          of: find.byType(TestHeaderText),
          matching: find.byType(Semantics),
        ),
      );
      expect(semanticsWidget.properties.label, customLabel);
    });

    testWidgets('should use text as semanticLabel when not provided',
        (tester) async {
      const testText = 'Default Label Text';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestHeaderText(
              text: testText,
            ),
          ),
        ),
      );

      final semanticsWidget = tester.widget<Semantics>(
        find.descendant(
          of: find.byType(TestHeaderText),
          matching: find.byType(Semantics),
        ),
      );
      expect(semanticsWidget.properties.label, testText);
    });

    testWidgets('should use custom testId when provided', (tester) async {
      const customKey = Key('custom_test_key');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestHeaderText(
              text: 'With Custom Key',
              testId: customKey,
            ),
          ),
        ),
      );

      // Should use the custom key
      expect(find.byKey(customKey), findsOneWidget);
      expect(find.byKey(const Key('test_header_text')), findsNothing);
    });

    testWidgets('should use default textKey when testId not provided',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestHeaderText(
              text: 'With Default Key',
            ),
          ),
        ),
      );

      // Should use the default key
      expect(find.byKey(const Key('test_header_text')), findsOneWidget);
    });

    test('should throw assertion error for empty text', () {
      expect(
        () => TestHeaderText(text: ''),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            contains('Header text must not be empty'),
          ),
        ),
      );
    });

    test('should throw assertion error for invalid maxLines', () {
      expect(
        () => TestHeaderText(text: 'Valid', maxLines: 0),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            contains('maxLines must be positive'),
          ),
        ),
      );

      expect(
        () => TestHeaderText(text: 'Valid', maxLines: -1),
        throwsA(
          isA<AssertionError>().having(
            (e) => e.message,
            'message',
            contains('maxLines must be positive'),
          ),
        ),
      );
    });
  });
}
