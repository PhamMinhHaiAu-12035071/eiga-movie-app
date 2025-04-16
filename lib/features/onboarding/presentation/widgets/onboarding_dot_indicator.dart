import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/di/injection.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Widget that displays dot indicators for page position in onboarding
class OnboardingDotIndicator extends StatelessWidget {
  /// Constructor
  const OnboardingDotIndicator({
    required this.pageCount,
    required this.currentIndex,
    super.key,
  });

  /// Number of pages
  final int pageCount;

  /// Current page index
  final int currentIndex;

  /// Access app sizes
  AppSizes get _sizes => getIt<AppSizes>();

  /// Access app colors
  AppColors get _colors => GetIt.I<AppColors>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => _buildDot(context, index),
      ),
    );
  }

  /// Builds a single indicator dot
  Widget _buildDot(BuildContext context, int index) {
    final isActive = index == currentIndex;

    return AnimatedContainer(
      duration: getIt<AppDurations>().medium,
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
