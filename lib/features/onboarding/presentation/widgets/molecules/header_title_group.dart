import 'package:flutter/material.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_subtitle.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_title.dart';

/// A widget that groups the title and subtitle for the onboarding header
class HeaderTitleGroup extends StatelessWidget {
  /// Creates a HeaderTitleGroup with the specified title and subtitle
  const HeaderTitleGroup({
    required this.title,
    required this.subtitle,
    super.key,
    this.textStyles,
    this.colors,
  });

  /// The title text to display
  final String title;

  /// The subtitle text to display
  final String subtitle;

  /// The app text styles
  final AppTextStyles? textStyles;

  /// The app colors
  final AppColors? colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTitle(
          text: title,
          textStyles: textStyles,
          colors: colors,
        ),
        HeaderSubtitle(
          text: subtitle,
          textStyles: textStyles,
          colors: colors,
        ),
      ],
    );
  }
}
