import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart' show AppImage;
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Widget that displays the header for the onboarding screen
/// Contains the logo and app name
class OnboardingHeader extends StatelessWidget {
  /// Constructor
  OnboardingHeader({
    super.key,
    AppSizes? sizes,
    AppTextStyles? textStyles,
    AppColors? colors,
    this.title = 'EIGA',
    this.subtitle = 'CINEMA UI KIT.',
    this.gapWidth,
  })  : sizes = sizes ?? GetIt.I<AppSizes>(),
        textStyles = textStyles ?? GetIt.I<AppTextStyles>(),
        colors = colors ?? GetIt.I<AppColors>();

  /// The app sizes for dimensions
  final AppSizes sizes;

  /// The app text styles
  final AppTextStyles textStyles;

  /// The app colors
  final AppColors colors;

  /// The title text to display
  final String title;

  /// The subtitle text to display
  final String subtitle;

  /// Custom gap width between logo and text
  final double? gapWidth;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizes.h32),
        child: Row(
          children: [
            Semantics(
              label: 'App logo - $title',
              child: SizedBox(
                key: const Key('onboarding_header_logo'),
                height: sizes.v56,
                child: AppImage.of(context).onboarding.logo.image(
                      fit: BoxFit.contain,
                    ),
              ),
            ),
            Gap(gapWidth ?? sizes.h16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  key: const Key('onboarding_header_title'),
                  style: textStyles.headingXl(
                    fontWeight: FontWeight.w900,
                    color: colors.skipButtonColor,
                  ),
                ),
                Text(
                  subtitle,
                  key: const Key('onboarding_header_subtitle'),
                  style: textStyles.headingSm(
                    fontWeight: FontWeight.w500,
                    color: colors.skipButtonColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
