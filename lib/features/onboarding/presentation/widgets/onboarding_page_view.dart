import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:ksk_app/core/sizes/app_dimension.dart' show AppDimension;
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/domain/models/onboarding_info.dart';

/// Widget that displays a page in the onboarding flow
class OnboardingPageView extends StatelessWidget {
  /// Constructor
  const OnboardingPageView({
    required this.controller,
    required this.slides,
    required this.onPageChanged,
    super.key,
  });

  /// Controller for PageView
  final PageController controller;

  /// List of slide information
  final List<OnboardingInfo> slides;

  /// Callback when page changes
  final void Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        onPageChanged: onPageChanged,
        itemCount: slides.length,
        itemBuilder: (context, index) {
          final slide = slides[index];
          return _buildPage(context, slide);
        },
      ),
    );
  }

  /// Builds content for an onboarding page
  Widget _buildPage(BuildContext context, OnboardingInfo slide) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimension.h32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration image
          slide.image.image(
            height: AppDimension.v260,
            width: AppDimension.h260,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Display placeholder if image is not found
              return Container(
                height: AppDimension.v260,
                width: AppDimension.h260,
                color: AppColors.grey[300],
                child: Icon(
                  Icons.image_not_supported,
                  size: AppDimension.r80,
                  color: AppColors.grey[600],
                ),
              );
            },
          ),
          Gap(AppDimension.v24),
          // Title
          Text(
            slide.title,
            style: AppTextStyle.headingLg(
              color: AppColors.onboardingBlue,
              fontWeight: FontWeight.w900,
            ),
          ),
          Gap(AppDimension.v12),
          // Description
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: AppTextStyle.body(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
