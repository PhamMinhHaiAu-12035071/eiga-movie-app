import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Widget for the next button or completion button in onboarding
class OnboardingNextButton extends StatelessWidget {
  /// Constructor
  const OnboardingNextButton({
    required this.onPressed,
    required this.text,
    this.isLastPage = false,
    super.key,
  });

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Text displayed on the button
  final String text;

  /// Whether this is the last page button
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyle.heading(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
