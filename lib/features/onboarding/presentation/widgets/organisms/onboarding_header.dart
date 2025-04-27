import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/onboarding_logo.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/header_title_group.dart';
import 'package:ksk_app/utils/context_x.dart';

/// A header widget for the onboarding screens that displays the app's branding.
///
/// This widget combines the [OnboardingLogo] with a [HeaderTitleGroup] in a row layout,
/// creating a consistent branding element across onboarding screens.
///
/// The header consists of:
/// - An [OnboardingLogo] on the left with customizable size
/// - A horizontal spacing gap (customizable via [spacing])
/// - A [HeaderTitleGroup] on the right displaying [title] and [subtitle]
///
/// Example usage:
/// ```dart
/// OnboardingHeader(
///   title: 'EIGA',
///   subtitle: 'CINEMA UI KIT.',
///   spacing: 20.0,
/// )
/// ```
class OnboardingHeader extends StatelessWidget {
  /// Creates an onboarding header with logo and title/subtitle.
  ///
  /// The [title] defaults to 'EIGA' if not specified.
  /// The [subtitle] defaults to 'CINEMA UI KIT.' if not specified.
  /// The [spacing] between logo and text is optional and defaults to [AppSizes.h14].
  const OnboardingHeader({
    super.key,
    this.title = 'EIGA',
    this.subtitle = 'CINEMA UI KIT.',
    this.spacing,
  });

  /// The title text displayed in the header.
  ///
  /// Typically the app or brand name. Defaults to 'EIGA'.
  final String title;

  /// The subtitle text displayed in the header.
  ///
  /// Usually a tagline or short description. Defaults to 'CINEMA UI KIT.'.
  final String subtitle;

  /// The horizontal space between the logo and title group.
  ///
  /// If null, defaults to the standard horizontal spacing from [AppSizes.h14].
  /// Use this to customize the layout spacing when needed.
  final double? spacing;

  /// The ratio used to calculate image size based on container size.
  ///
  /// The logo image size is set to 63% of the container size to maintain
  /// proper visual proportions across different screen sizes.
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
