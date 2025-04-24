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
    when(() => mockColors.skipButtonColor)
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
    testWidgets('renders Text widget with correct text and key',
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
      final customTextStyles = MockAppTextStyles();
      final customColors = MockAppColors();

      when(() => customColors.skipButtonColor).thenReturn(Colors.red);
      when(
        () => customTextStyles.headingXl(
          fontWeight: any(named: 'fontWeight'),
          color: any(named: 'color'),
        ),
      ).thenReturn(
        const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderTitle(
              text: 'Injected Style',
              textStyles: customTextStyles,
              colors: customColors,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Injected Style'));
      expect(textWidget.style?.fontSize, 30);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.color, Colors.red);

      // Verify the mocks were called
      verify(() => customColors.skipButtonColor).called(1);
      verify(
        () => customTextStyles.headingXl(
          fontWeight: FontWeight.w900,
          color: Colors.red,
        ),
      ).called(1);
    });
  });
}
