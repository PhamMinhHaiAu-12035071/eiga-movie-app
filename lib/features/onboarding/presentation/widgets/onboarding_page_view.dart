import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
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

  /// Access app sizes
  AppSizes get _sizes => GetIt.I<AppSizes>();
  AppTextStyles get _textStyles => GetIt.I<AppTextStyles>();
  AppColors get _colors => GetIt.I<AppColors>();

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
      padding: EdgeInsets.symmetric(horizontal: _sizes.h32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 3,
            child: slide.image.image(
              height: _sizes.v260,
              width: _sizes.h260,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Display placeholder if image is not found
                return Container(
                  height: _sizes.v260,
                  width: _sizes.h260,
                  color: _colors.grey[300],
                  child: Icon(
                    Icons.image_not_supported,
                    size: _sizes.r80,
                    color: _colors.grey[600],
                  ),
                );
              },
            ),
          ),
          Gap(_sizes.v24),
          Flexible(
            child: Text(
              slide.title,
              style: _textStyles.headingLg(
                color: _colors.onboardingBlue,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Gap(_sizes.v12),
          Flexible(
            flex: 2,
            child: Text(
              slide.description,
              textAlign: TextAlign.center,
              style: _textStyles.body(
                color: _colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
