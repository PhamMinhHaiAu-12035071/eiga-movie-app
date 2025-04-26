import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart' show GetIt;
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
          // Create mocks for the component
          final appTextStyles = GetIt.I<AppTextStyles>();

          // Create the text style directly for the HeaderTitle
          final textStyle = appTextStyles.headingXl(
            fontWeight: FontWeight.w900,
          );

          final appColors = GetIt.I<AppColors>();
          // Add knobs for customizing the title
          final text = context.knobs.string(
            label: 'Title Text',
            description: 'Text to display as the title',
            initialValue: 'EIGA',
          );

          final textColor = context.knobs.color(
            label: 'Text Color',
            description: 'Color of the title text',
            initialValue: appColors.slateBlue,
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

          return Scaffold(
            backgroundColor: appColors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
