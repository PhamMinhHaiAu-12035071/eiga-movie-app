import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/domain/models/onboarding_info.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_dot_indicator.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_next_button.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_page_view.dart';

/// Widget that displays the onboarding content in portrait orientation
class OnboardingPortraitView extends StatelessWidget {
  /// Constructor
  const OnboardingPortraitView({
    required this.pageController,
    required this.slides,
    required this.currentPage,
    required this.isLastPage,
    required this.onPageChanged,
    required this.onNextPressed,
    required this.onSkipPressed,
    super.key,
  });

  /// Controller for PageView
  final PageController pageController;

  /// List of slide information
  final List<OnboardingInfo> slides;

  /// Current page index
  final int currentPage;

  /// Flag indicating if this is the last page
  final bool isLastPage;

  /// Callback for page changes
  final ValueChanged<int> onPageChanged;

  /// Callback for next button press
  final VoidCallback onNextPressed;

  /// Callback for skip button press
  final VoidCallback onSkipPressed;

  /// Access app sizes
  AppSizes get _sizes => GetIt.I<AppSizes>();
  AppTextStyles get _textStyles => GetIt.I<AppTextStyles>();
  AppColors get _colors => GetIt.I<AppColors>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _colors.onboardingBackground,
      ),
      padding: EdgeInsets.symmetric(horizontal: _sizes.h24),
      child: Column(
        children: [
          Gap(_sizes.v48),

          // Header with logo and app name
          OnboardingHeader(),

          // PageView to display onboarding pages
          OnboardingPageView(
            controller: pageController,
            slides: slides,
            onPageChanged: onPageChanged,
          ),

          // Dot indicators
          OnboardingDotIndicator(
            pageCount: slides.length,
            currentIndex: currentPage,
          ),

          Gap(_sizes.v40),

          // Next or Get Started button
          OnboardingNextButton(
            text: isLastPage ? 'Get Started' : 'Next',
            isLastPage: isLastPage,
            onPressed: onNextPressed,
          ),

          Gap(_sizes.v32),

          // Skip button
          TextButton(
            onPressed: onSkipPressed,
            child: Text(
              'Skip',
              style: _textStyles.heading(
                color: _colors.skipButtonColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Gap(_sizes.v40),
        ],
      ),
    );
  }
}
