import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Widget that displays a single dot indicator for onboarding
class DotIndicatorAtom extends StatelessWidget {
  /// Constructor
  const DotIndicatorAtom({
    required this.isActive,
    super.key,
  });

  /// Whether this dot is the active one
  final bool isActive;

  /// Access app sizes
  AppSizes get _sizes => GetIt.I<AppSizes>();

  /// Access app colors
  AppColors get _colors => GetIt.I<AppColors>();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: GetIt.I<AppDurations>().medium,
      margin: EdgeInsets.symmetric(horizontal: _sizes.h4),
      height: _sizes.v8,
      width: isActive ? _sizes.h16 : _sizes.h8,
      decoration: BoxDecoration(
        color: isActive
            ? _colors.onboardingBlue
            : _colors.onboardingBlue.withAlpha(102),
        borderRadius: BorderRadius.circular(_sizes.r4),
      ),
    );
  }
}
