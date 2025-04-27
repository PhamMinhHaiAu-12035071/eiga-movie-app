import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/sizes/app_sizes_impl.dart';

void main() {
  late AppSizes appSizes;

  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  // Test all size values
  testWidgets('AppSizesImpl initializes and returns correct values',
      (tester) async {
    // Setup the widget with ScreenUtilInit
    await tester.pumpWidget(
      MaterialApp(
        home: ScreenUtilInit(
          minTextAdapt: true,
          builder: (_, __) => const Scaffold(body: SizedBox.shrink()),
        ),
      ),
    );

    // Wait for widget to build
    await tester.pumpAndSettle();

    // Initialize our implementation
    appSizes = const AppSizesImpl();

    // Responsive sizes (r)
    expect(appSizes.r2, equals(2.r));
    expect(appSizes.r4, equals(4.r));
    expect(appSizes.r8, equals(8.r));
    expect(appSizes.r12, equals(12.r));
    expect(appSizes.r14, equals(14.r));
    expect(appSizes.r16, equals(16.r));
    expect(appSizes.r20, equals(20.r));
    expect(appSizes.r24, equals(24.r));
    expect(appSizes.r32, equals(32.r));
    expect(appSizes.r40, equals(40.r));
    expect(appSizes.r48, equals(48.r));
    expect(appSizes.r56, equals(56.r));
    expect(appSizes.r64, equals(64.r));
    expect(appSizes.r80, equals(80.r));
    expect(appSizes.r128, equals(128.r));
    expect(appSizes.r192, equals(192.r));
    expect(appSizes.r256, equals(256.r));
    expect(appSizes.r260, equals(260.r));

    // Height sizes (v)
    expect(appSizes.v2, equals(2.h));
    expect(appSizes.v4, equals(4.h));
    expect(appSizes.v8, equals(8.h));
    expect(appSizes.v12, equals(12.h));
    expect(appSizes.v14, equals(14.h));
    expect(appSizes.v16, equals(16.h));
    expect(appSizes.v20, equals(20.h));
    expect(appSizes.v24, equals(24.h));
    expect(appSizes.v32, equals(32.h));
    expect(appSizes.v40, equals(40.h));
    expect(appSizes.v48, equals(48.h));
    expect(appSizes.v56, equals(56.h));
    expect(appSizes.v64, equals(64.h));
    expect(appSizes.v80, equals(80.h));
    expect(appSizes.v128, equals(128.h));
    expect(appSizes.v192, equals(192.h));
    expect(appSizes.v256, equals(256.h));
    expect(appSizes.v260, equals(260.h));

    // Width sizes (h)
    expect(appSizes.h2, equals(2.w));
    expect(appSizes.h4, equals(4.w));
    expect(appSizes.h8, equals(8.w));
    expect(appSizes.h12, equals(12.w));
    expect(appSizes.h14, equals(14.w));
    expect(appSizes.h16, equals(16.w));
    expect(appSizes.h20, equals(20.w));
    expect(appSizes.h24, equals(24.w));
    expect(appSizes.h32, equals(32.w));
    expect(appSizes.h40, equals(40.w));
    expect(appSizes.h48, equals(48.w));
    expect(appSizes.h56, equals(56.w));
    expect(appSizes.h64, equals(64.w));
    expect(appSizes.h80, equals(80.w));
    expect(appSizes.h128, equals(128.w));
    expect(appSizes.h192, equals(192.w));
    expect(appSizes.h256, equals(256.w));
    expect(appSizes.h260, equals(260.w));

    // Border radius
    expect(appSizes.borderRadiusXs, equals(6.r));
    expect(appSizes.borderRadiusSm, equals(8.r));
    expect(appSizes.borderRadiusMd, equals(12.r));
    expect(appSizes.borderRadiusLg, equals(16.r));
  });
}
