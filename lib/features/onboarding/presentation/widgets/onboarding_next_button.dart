import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
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

  /// Access app sizes
  AppSizes get _sizes => GetIt.I<AppSizes>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _sizes.h40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_sizes.borderRadiusMd),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.onboardingGradientStart,
              AppColors.onboardingGradientEnd,
            ],
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.transparent,
            shadowColor: AppColors.transparent,
            minimumSize: Size(double.infinity, _sizes.v56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_sizes.borderRadiusMd),
            ),
          ),
          child: Text(
            text,
            style: AppTextStyle.heading(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
