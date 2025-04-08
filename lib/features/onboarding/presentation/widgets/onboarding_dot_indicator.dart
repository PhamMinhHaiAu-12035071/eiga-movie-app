import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 7.h,
      width: isActive ? 14.w : 7.w,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.onboardingBlue
            : AppColors.onboardingBlue.withAlpha(102),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
