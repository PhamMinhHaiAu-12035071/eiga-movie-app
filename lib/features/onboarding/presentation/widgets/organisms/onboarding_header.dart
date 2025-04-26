import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    this.spacing = 14.0,
  });

  /// The title text to display
  final String title;

  /// The subtitle text to display
  final String subtitle;

  /// Custom gap width between logo and text
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final sizes = GetIt.I<AppSizes>();
    final imageSize = sizes.v56 * 0.63; // 63% of container size

    return Row(
      children: [
        OnboardingLogo(
          key: const Key('onboarding_header_logo'),
          containerSize: sizes.v56,
          imageSize: imageSize,
        ),
        Gap(spacing.w),
        HeaderTitleGroup(
          title: title,
          subtitle: subtitle,
        ),
      ],
    );
  }
}
