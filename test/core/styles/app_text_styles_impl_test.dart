import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/styles/app_text_styles_impl.dart';

void main() {
  late AppTextStylesImpl textStyles;

  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  testWidgets('AppTextStylesImpl returns correct styles for all methods',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScreenUtilInit(
          minTextAdapt: true,
          builder: (_, __) => const Scaffold(body: SizedBox.shrink()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    textStyles = const AppTextStylesImpl();

    // Test all style methods with default params
    expect(textStyles.heading3Xl(), isA<TextStyle>());
    expect(textStyles.heading2Xl(), isA<TextStyle>());
    expect(textStyles.headingXl(), isA<TextStyle>());
    expect(textStyles.headingLg(), isA<TextStyle>());
    expect(textStyles.heading(), isA<TextStyle>());
    expect(textStyles.headingSm(), isA<TextStyle>());
    expect(textStyles.headingXs(), isA<TextStyle>());
    expect(textStyles.bodyLg(), isA<TextStyle>());
    expect(textStyles.body(), isA<TextStyle>());
    expect(textStyles.bodySm(), isA<TextStyle>());

    // Test color and fontWeight propagation
    const testColor = Colors.red;
    const testWeight = FontWeight.w200;
    final style =
        textStyles.heading3Xl(color: testColor, fontWeight: testWeight);
    expect(style.color, testColor);
    expect(style.fontWeight, testWeight);
  });
}
