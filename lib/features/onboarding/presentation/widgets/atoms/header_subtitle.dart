import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Subtitle widget used in the onboarding header
class HeaderSubtitle extends StatelessWidget {
  /// Creates a HeaderSubtitle with the specified text
  const HeaderSubtitle({
    required this.text,
    super.key,
    this.textStyles,
    this.colors,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
  });

  /// The text to display as the subtitle
  final String text;

  /// The app text styles
  final AppTextStyles? textStyles;

  /// The app colors
  final AppColors? colors;

  /// The maximum number of lines for the subtitle
  final int? maxLines;

  /// The text alignment for the subtitle
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final textStyles = this.textStyles ?? GetIt.I<AppTextStyles>();
    final colors = this.colors ?? GetIt.I<AppColors>();

    return Text(
      text,
      key: const Key('onboarding_header_subtitle'),
      style: textStyles.headingSm(
        fontWeight: FontWeight.w500,
        color: colors.slateBlue,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
