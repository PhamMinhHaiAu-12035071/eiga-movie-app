import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Title widget used in the onboarding header
class HeaderTitle extends StatelessWidget {
  /// Creates a HeaderTitle with the specified text
  HeaderTitle({
    required this.text,
    super.key,
    this.textStyle,
    this.color,
  }) : assert(text.trim().isNotEmpty, 'Header title must not be empty');

  /// The text to display as the title
  final String text;

  /// The text style for the title
  final TextStyle? textStyle;

  /// The color for the title
  final Color? color;

  /// Builds the effective text style for the header
  TextStyle _buildHeaderStyle() {
    final appTextStyles = GetIt.I<AppTextStyles>();
    final appColors = GetIt.I<AppColors>();

    final effectiveColor = color ?? appColors.slateBlue;

    return (textStyle ??
            appTextStyles.headingXl(
              fontWeight: FontWeight.w900,
            ))
        .copyWith(color: effectiveColor);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: const Key('onboarding_header_title'),
      style: _buildHeaderStyle(),
    );
  }
}
