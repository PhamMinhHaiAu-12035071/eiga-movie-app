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
    when(() => mockColors.slateBlue).thenReturn(Colors.black);
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

    testWidgets('correctly passes title and subtitle to children',
        (tester) async {
      const testTitle = 'Injected Title';
      const testSubtitle = 'Injected Subtitle';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderTitleGroup(
              title: testTitle,
              subtitle: testSubtitle,
            ),
          ),
        ),
      );

      // Verify the correct texts are displayed
      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testSubtitle), findsOneWidget);

      // Verify HeaderTitle and HeaderSubtitle widgets exist
      final titleFinder = find.byType(HeaderTitle);
      final subtitleFinder = find.byType(HeaderSubtitle);
      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);

      // Verify the props were correctly passed
      final headerTitle = tester.widget<HeaderTitle>(titleFinder);
      final headerSubtitle = tester.widget<HeaderSubtitle>(subtitleFinder);
      expect(headerTitle.text, testTitle);
      expect(headerSubtitle.text, testSubtitle);
    });
  });
}
