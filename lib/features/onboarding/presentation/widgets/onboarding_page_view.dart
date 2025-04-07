import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration image
          slide.image.image(
            height: 260.h,
            width: 260.w,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // Display placeholder if image is not found
              return Container(
                height: 260.h,
                width: 260.w,
                color: Colors.grey[300],
                child: Icon(
                  Icons.image_not_supported,
                  size: 80.sp,
                  color: Colors.grey[600],
                ),
              );
            },
          ),
          SizedBox(height: 40.h),

          // Title
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 16.h),

          // Description
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
