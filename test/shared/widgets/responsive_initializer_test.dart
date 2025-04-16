import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/shared/widgets/responsive_initializer.dart';

void main() {
  testWidgets('ResponsiveInitializer initializes ScreenUtil correctly',
      (WidgetTester tester) async {
    // Arrange
    // Wrap the actual app content in the builder
    const testApp = MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Test Child'),
        ),
      ),
    );

    await tester.pumpWidget(
      ResponsiveInitializer(
        builder: (context) => testApp,
      ),
    );

    // Act
    // Pumping the ResponsiveInitializer handles the initialization
    // No separate pump needed unless testing dynamic changes

    // Assert
    // Check if ScreenUtilInit is implicitly used (we can't find it directly
    //if builder is used)
    // Instead, verify the child is rendered and ScreenUtil works
    expect(find.text('Test Child'), findsOneWidget);

    // Check if ScreenUtil is initialized by accessing a property
    // This requires a valid context, we get it from the child
    tester.element(find.text('Test Child'));
    expect(
      ScreenUtil().scaleWidth,
      isNotNull,
    ); // Check if ScreenUtil provides values

    // Re-verify the child is the one we passed
    expect(find.byWidget(testApp), findsOneWidget);

    // Note: Directly verifying ScreenUtilInit
    //properties like designSize is harder
    // when using the builder pattern as ScreenUtilInit
    //is internal to ResponsiveInitializer.
    // We infer correctness from ScreenUtil working and the child rendering.
  });
}
