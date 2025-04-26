import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Subtitle widget used in the onboarding header
class HeaderSubtitle extends StatelessWidget {
  /// Creates a HeaderSubtitle with the specified text
  HeaderSubtitle({
    required this.text,
    super.key,
    this.textStyle,
    this.color,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
  }) : assert(text.trim().isNotEmpty, 'Header subtitle must not be empty');

  /// The text to display as the subtitle
  final String text;

  /// The text style for the subtitle
  final TextStyle? textStyle;

  /// The color for the subtitle
  final Color? color;

  /// The maximum number of lines for the subtitle
  final int? maxLines;

  /// The text alignment for the subtitle
  final TextAlign? textAlign;

  /// Builds the effective text style for the header subtitle
  TextStyle _buildHeaderStyle() {
    final appTextStyles = GetIt.I<AppTextStyles>();
    final appColors = GetIt.I<AppColors>();

    final effectiveColor = color ?? appColors.slateBlue;

    return (textStyle ??
            appTextStyles.headingSm(
              fontWeight: FontWeight.w500,
            ))
        .copyWith(color: effectiveColor);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: const Key('onboarding_header_subtitle'),
      style: _buildHeaderStyle(),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
