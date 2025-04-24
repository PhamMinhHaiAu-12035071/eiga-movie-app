import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Title widget used in the onboarding header
class HeaderTitle extends StatelessWidget {
  /// Creates a HeaderTitle with the specified text
  const HeaderTitle({
    required this.text,
    super.key,
    this.textStyles,
    this.colors,
  });

  /// The text to display as the title
  final String text;

  /// The app text styles
  final AppTextStyles? textStyles;

  /// The app colors
  final AppColors? colors;

  @override
  Widget build(BuildContext context) {
    final textStyles = this.textStyles ?? GetIt.I<AppTextStyles>();
    final colors = this.colors ?? GetIt.I<AppColors>();

    return Text(
      text,
      key: const Key('onboarding_header_title'),
      style: textStyles.headingXl(
        fontWeight: FontWeight.w900,
        color: colors.skipButtonColor,
      ),
    );
  }
}
