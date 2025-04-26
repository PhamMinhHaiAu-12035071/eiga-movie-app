import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:ksk_app/core/styles/app_text_styles.dart' show AppTextStyles;
import 'package:ksk_app/core/styles/colors/app_colors.dart' show AppColors;
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_subtitle.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for HeaderSubtitle
WidgetbookComponent getHeaderSubtitleComponent() {
  return WidgetbookComponent(
    name: 'HeaderSubtitle',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          // Add knobs for customizing the subtitle
          final text = context.knobs.string(
            label: 'Subtitle Text',
            description: 'Text to display as the subtitle',
            initialValue: 'CINEMA UI KIT.',
          );

          // Create mocks for the component
          final appTextStyles = GetIt.I<AppTextStyles>();
          final appColors = GetIt.I<AppColors>();

          // Create the text style directly for the HeaderSubtitle
          final textStyle = appTextStyles.headingSm(
            fontWeight: FontWeight.w500,
          );

          final textColor = context.knobs.color(
            label: 'Text Color',
            description: 'Color of the subtitle text',
            initialValue: appColors.slateBlue,
          );

          return Scaffold(
            backgroundColor: appColors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Use the header subtitle with updated parameter names
                    HeaderSubtitle(
                      text: text,
                      textStyle: textStyle,
                      color: textColor,
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
