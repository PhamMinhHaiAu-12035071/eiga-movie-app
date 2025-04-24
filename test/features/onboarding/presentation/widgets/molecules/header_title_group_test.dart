import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_subtitle.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_title.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/header_title_group.dart';
import 'package:mocktail/mocktail.dart';

// Mocks (consider sharing)
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

    // Common style setup for default case
    when(() => mockColors.skipButtonColor).thenReturn(Colors.black);
    when(
      () => mockTextStyles.headingXl(
        fontWeight: any(named: 'fontWeight'),
        color: any(named: 'color'),
      ),
    ).thenReturn(const TextStyle(fontSize: 24));
    when(
      () => mockTextStyles.headingSm(
        fontWeight: any(named: 'fontWeight'),
        color: any(named: 'color'),
      ),
    ).thenReturn(const TextStyle(fontSize: 16));
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  group('HeaderTitleGroup Molecule', () {
    testWidgets('renders Column with HeaderTitle and HeaderSubtitle',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitleGroup(
              title: 'Main Title',
              subtitle: 'Sub Title',
            ),
          ),
        ),
      );

      // Verify Column exists and crossAxisAlignment
      final columnFinder = find.byType(Column);
      expect(columnFinder, findsOneWidget);
      final column = tester.widget<Column>(columnFinder);
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);

      // Verify children
      expect(find.byType(HeaderTitle), findsOneWidget);
      expect(find.byType(HeaderSubtitle), findsOneWidget);
      expect(find.text('Main Title'), findsOneWidget);
      expect(find.text('Sub Title'), findsOneWidget);
    });

    testWidgets('passes injected styles and colors down to children',
        (tester) async {
      final customTextStyles = MockAppTextStyles();
      final customColors = MockAppColors();

      // Setup specific return values for injected mocks
      when(() => customColors.skipButtonColor).thenReturn(Colors.purple);
      when(
        () => customTextStyles.headingXl(
          fontWeight: any(named: 'fontWeight'),
          color: Colors.purple,
        ),
      ).thenReturn(const TextStyle(fontSize: 30, color: Colors.purple));
      when(
        () => customTextStyles.headingSm(
          fontWeight: any(named: 'fontWeight'),
          color: Colors.purple,
        ),
      ).thenReturn(const TextStyle(fontSize: 20, color: Colors.purple));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderTitleGroup(
              title: 'Injected Title',
              subtitle: 'Injected Subtitle',
              textStyles: customTextStyles,
              colors: customColors,
            ),
          ),
        ),
      );

      // Verify HeaderTitle received injected styles
      final headerTitle = tester.widget<HeaderTitle>(find.byType(HeaderTitle));
      expect(headerTitle.textStyles, customTextStyles);
      expect(headerTitle.colors, customColors);
      // We can also check the rendered text style indirectly if needed
      final titleTextWidget = tester.widget<Text>(find.text('Injected Title'));
      expect(titleTextWidget.style?.fontSize, 30);
      expect(titleTextWidget.style?.color, Colors.purple);

      // Verify HeaderSubtitle received injected styles
      final headerSubtitle =
          tester.widget<HeaderSubtitle>(find.byType(HeaderSubtitle));
      expect(headerSubtitle.textStyles, customTextStyles);
      expect(headerSubtitle.colors, customColors);
      final subtitleTextWidget =
          tester.widget<Text>(find.text('Injected Subtitle'));
      expect(subtitleTextWidget.style?.fontSize, 20);
      expect(subtitleTextWidget.style?.color, Colors.purple);
    });

    testWidgets('children use default styles when none are injected',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitleGroup(
              title: 'Default Title',
              subtitle: 'Default Subtitle',
            ),
          ),
        ),
      );

      // Verify HeaderTitle used default styles
      final titleTextWidget = tester.widget<Text>(find.text('Default Title'));
      expect(titleTextWidget.style?.fontSize, 24);

      // Verify HeaderSubtitle used default styles
      final subtitleTextWidget =
          tester.widget<Text>(find.text('Default Subtitle'));
      expect(subtitleTextWidget.style?.fontSize, 16);
    });
  });
}
