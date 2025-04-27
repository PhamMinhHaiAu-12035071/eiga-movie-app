import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/onboarding_logo.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/header_title_group.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Widget that displays the header for the onboarding screen
/// Contains the logo and app name
class OnboardingHeader extends StatelessWidget {
  /// Constructor
  const OnboardingHeader({
    super.key,
    this.title = 'EIGA',
    this.subtitle = 'CINEMA UI KIT.',
    this.spacing,
  });

  /// The title text to display
  final String title;

  /// The subtitle text to display
  final String subtitle;

  /// Custom gap width between logo and text
  final double? spacing;

  /// Image size ratio relative to container size (63%)
  static const double _kImageSizeRatio = 0.63;

  @override
  Widget build(BuildContext context) {
    final containerSize = context.sizes.v56;
    final imageSize = containerSize * _kImageSizeRatio;
    final effectiveSpacing = spacing ?? context.sizes.h14;

    return Row(
      children: [
        OnboardingLogo(
          key: const Key('onboarding_header_logo'),
          containerSize: containerSize,
          imageSize: imageSize,
        ),
        Gap(effectiveSpacing),
        HeaderTitleGroup(
          title: title,
          subtitle: subtitle,
        ),
      ],
    );
  }
}
