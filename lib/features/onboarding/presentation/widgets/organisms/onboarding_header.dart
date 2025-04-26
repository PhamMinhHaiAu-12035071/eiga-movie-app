import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/onboarding_logo.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/header_title_group.dart';

/// Widget that displays the header for the onboarding screen
/// Contains the logo and app name
class OnboardingHeader extends StatelessWidget {
  /// Constructor
  const OnboardingHeader({
    super.key,
    this.title = 'EIGA',
    this.subtitle = 'CINEMA UI KIT.',
    this.gapWidth,
    this.sizes,
  });

  /// The title text to display
  final String title;

  /// The subtitle text to display
  final String subtitle;

  /// Custom gap width between logo and text
  final double? gapWidth;

  /// The app sizes for dimensions
  final AppSizes? sizes;

  @override
  Widget build(BuildContext context) {
    final sizes = this.sizes ?? GetIt.I<AppSizes>();

    return ColoredBox(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizes.h32),
        child: Row(
          children: [
            OnboardingLogo(
              key: const Key('onboarding_header_logo'),
              containerSize: sizes.v56,
              imageSize:
                  sizes.v56 * 0.6, // Make image size 60% of container size
            ),
            Gap(gapWidth ?? sizes.h16),
            HeaderTitleGroup(
              title: title,
              subtitle: subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
