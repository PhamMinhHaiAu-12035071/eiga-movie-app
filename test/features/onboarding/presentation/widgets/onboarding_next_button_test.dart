import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_next_button.dart';
import 'package:mocktail/mocktail.dart';

class MockAppSizes extends Mock implements AppSizes {
  @override
  double get h40 => 40;
  @override
  double get v56 => 56;
  @override
  double get borderRadiusMd => 8;
}

class MockAppTextStyles extends Mock implements AppTextStyles {
  @override
  TextStyle heading({Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: 16,
    );
  }
}

class MockAppColors extends Mock implements AppColors {
  @override
  MaterialColor get white => const MaterialColor(
        0xFFFFFFFF,
        <int, Color>{
          50: Color(0xFFFFFFFF),
          100: Color(0xFFFFFFFF),
          200: Color(0xFFFFFFFF),
          300: Color(0xFFFFFFFF),
          400: Color(0xFFFFFFFF),
          500: Color(0xFFFFFFFF),
          600: Color(0xFFF7F7F7),
          700: Color(0xFFE6E6E6),
          800: Color(0xFFD6D6D6),
          900: Color(0xFFC4C4C4),
        },
      );
  @override
  Color get transparent => Colors.transparent;
  @override
  Color get onboardingGradientStart => const Color(0xFF00B3C6);
  @override
  Color get onboardingGradientEnd => const Color(0xFF5D84B4);
}

// Mock the BuildContext for extension methods
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockAppSizes mockAppSizes;
  late MockAppTextStyles mockAppTextStyles;
  late MockAppColors mockAppColors;

  setUp(() {
    mockAppSizes = MockAppSizes();
    mockAppTextStyles = MockAppTextStyles();
    mockAppColors = MockAppColors();

    // Register the dependencies with GetIt
    GetIt.I.registerSingleton<AppSizes>(mockAppSizes);
    GetIt.I.registerSingleton<AppTextStyles>(mockAppTextStyles);
    GetIt.I.registerSingleton<AppColors>(mockAppColors);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  Widget buildTestWidget({
    required VoidCallback onPressed,
    required String text,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: OnboardingNextButton(
          onPressed: onPressed,
          text: text,
        ),
      ),
    );
  }

  group('OnboardingNextButton', () {
    testWidgets('renders correctly with minimum required props',
        (WidgetTester tester) async {
      var buttonPressed = false;
      await tester.pumpWidget(
        buildTestWidget(
          onPressed: () => buttonPressed = true,
          text: 'Next',
        ),
      );

      expect(find.byType(OnboardingNextButton), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
      expect(buttonPressed, isFalse);
    });

    testWidgets('handles onPressed callback correctly',
        (WidgetTester tester) async {
      var buttonPressed = false;
      await tester.pumpWidget(
        buildTestWidget(
          onPressed: () => buttonPressed = true,
          text: 'Next',
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      expect(buttonPressed, isTrue);
    });

    testWidgets('displays correct text', (WidgetTester tester) async {
      const testText = 'Test Button';
      await tester.pumpWidget(
        buildTestWidget(
          onPressed: () {},
          text: testText,
        ),
      );

      expect(find.text(testText), findsOneWidget);
    });

    testWidgets('applies correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          onPressed: () {},
          text: 'Next',
        ),
      );

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration! as BoxDecoration;

      expect(decoration.gradient, isNotNull);
      expect(
        (decoration.gradient! as LinearGradient).colors,
        [
          mockAppColors.onboardingGradientStart,
          mockAppColors.onboardingGradientEnd,
        ],
      );

      // Verify box shadow is correctly applied
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.length, 1);
      expect(decoration.boxShadow![0].blurRadius, 15);
      expect(decoration.boxShadow![0].offset, const Offset(0, 8));

      final buttonFinder = find.byType(ElevatedButton);
      final button = tester.widget<ElevatedButton>(buttonFinder);

      expect(
        button.style?.backgroundColor?.resolve({}),
        mockAppColors.transparent,
      );
      expect(button.style?.foregroundColor?.resolve({}), mockAppColors.white);
    });

    testWidgets('has correct padding and dimensions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          onPressed: () {},
          text: 'Next',
        ),
      );

      final paddingFinder = find
          .descendant(
            of: find.byType(OnboardingNextButton),
            matching: find.byType(Padding),
          )
          .first;
      final padding = tester.widget<Padding>(paddingFinder);

      expect(
        padding.padding,
        EdgeInsets.symmetric(horizontal: mockAppSizes.h40),
      );

      final buttonFinder = find.byType(ElevatedButton);
      final button = tester.widget<ElevatedButton>(buttonFinder);

      expect(
        button.style?.minimumSize?.resolve({}),
        Size(double.infinity, mockAppSizes.v56),
      );
    });

    testWidgets('has correct text style', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          onPressed: () {},
          text: 'Next',
        ),
      );

      final textFinder = find.byType(Text);
      final text = tester.widget<Text>(textFinder);

      expect(text.style?.color, mockAppColors.white);
      expect(text.style?.fontWeight, FontWeight.w500);
    });
  });
}
