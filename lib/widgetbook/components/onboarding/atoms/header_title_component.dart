import 'package:flutter/material.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_title.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for HeaderTitle
WidgetbookComponent getHeaderTitleComponent() {
  return WidgetbookComponent(
    name: 'HeaderTitle',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          // Add knobs for customizing the title
          final text = context.knobs.string(
            label: 'Title Text',
            description: 'Text to display as the title',
            initialValue: 'EIGA',
          );

          final textColor = context.knobs.color(
            label: 'Text Color',
            description: 'Color of the title text',
            initialValue: Colors.black,
          );

          // Using double.slider for maxLines with integer conversion
          final maxLinesDouble = context.knobs.double.slider(
            label: 'Max Lines',
            description: 'Maximum number of lines for the title',
            initialValue: 1,
            min: 1,
            max: 5,
            divisions: 4, // To get whole numbers: 1,2,3,4,5
          );

          // Convert to integer for the maxLines property
          final maxLines = maxLinesDouble.toInt();

          // Create mocks for the component
          final mockTextStyles = TextStylesMock();

          // Create the text style directly for the HeaderTitle
          final textStyle = mockTextStyles.headingXl(
            fontWeight: FontWeight.w900,
            color: textColor,
          );

          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Header Title Component:'),
                    const SizedBox(height: 20),
                    // Use the header title with updated parameter names
                    HeaderTitle(
                      text: text,
                      textStyle: textStyle,
                      color: textColor,
                      maxLines: maxLines,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}

/// Mock implementation of AppTextStyles for the component
class TextStylesMock implements AppTextStyles {
  @override
  TextStyle headingXl({FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? Colors.black,
    );
  }

  // Implement other required methods with defaults
  @override
  TextStyle heading({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 20, fontWeight: fontWeight, color: color);

  @override
  TextStyle headingSm({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 16, fontWeight: fontWeight, color: color);

  @override
  TextStyle body({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 14, fontWeight: fontWeight, color: color);

  TextStyle bodySmall({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 12, fontWeight: fontWeight, color: color);

  // Add missing methods
  @override
  TextStyle bodyLg({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 16, fontWeight: fontWeight, color: color);

  @override
  TextStyle bodySm({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 12, fontWeight: fontWeight, color: color);

  @override
  TextStyle heading2Xl({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 28, fontWeight: fontWeight, color: color);

  @override
  TextStyle heading3Xl({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 32, fontWeight: fontWeight, color: color);

  @override
  TextStyle headingLg({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 22, fontWeight: fontWeight, color: color);

  @override
  TextStyle headingXs({FontWeight? fontWeight, Color? color}) =>
      TextStyle(fontSize: 14, fontWeight: fontWeight, color: color);

  // Handle any other missing methods with noSuchMethod
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Mock implementation of AppColors for the component
class ColorsMock implements AppColors {
  /// Creates a mock with the specified color
  ColorsMock(this.textColor);

  /// The text color to use
  final Color textColor;

  @override
  Color get slateBlue => textColor;

  // Implement other required color properties
  @override
  Color get accent => Colors.blue;

  @override
  Color get accentDark => Colors.blue.shade700;

  @override
  Color get bgMain => Colors.white;

  @override
  Color get bgMainDark => Colors.grey.shade900;

  @override
  Color get onboardingBackground => Colors.white;

  // Additional properties would be implemented here for a complete mock
  // For widgetbook we just need enough to make it compile
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
