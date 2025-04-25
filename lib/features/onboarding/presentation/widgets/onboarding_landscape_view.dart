import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/domain/models/onboarding_info.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_dot_indicator.dart';

/// Widget that displays the onboarding content in landscape orientation
class OnboardingLandscapeView extends StatelessWidget {
  /// Constructor
  const OnboardingLandscapeView({
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
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: _colors.onboardingBackground,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: _sizes.h8,
            vertical: _sizes.v8,
          ),
          child: Column(
            children: [
              // Logo and app name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _sizes.h16),
                child: Row(
                  children: [
                    SizedBox(
                      height: _sizes.v32,
                      child: AppImage.of(context).onboarding.logo.image(
                            fit: BoxFit.contain,
                          ),
                    ),
                    Gap(_sizes.h12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EIGA',
                          style: _textStyles.headingLg(
                            fontWeight: FontWeight.w900,
                            color: _colors.slateBlue,
                          ),
                        ),
                        Text(
                          'CINEMA UI KIT.',
                          style: _textStyles.headingXs(
                            fontWeight: FontWeight.w500,
                            color: _colors.slateBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Gap(_sizes.v8),

              // PageView with landscape layout
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    final slide = slides[index];
                    return _buildPageContent(context, slide);
                  },
                ),
              ),

              // Dot indicators and action buttons
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _sizes.h16,
                  vertical: _sizes.v8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dot indicators
                    Flexible(
                      flex: 370,
                      child: OnboardingDotIndicator(
                        pageCount: slides.length,
                        currentIndex: currentPage,
                      ),
                    ),

                    // Buttons row
                    Flexible(
                      flex: 630,
                      child: Row(
                        children: [
                          Gap(_sizes.h32),
                          // Next or Get Started button
                          _buildActionButton(
                            text: isLastPage ? 'Get Started' : 'Next',
                            onPressed: onNextPressed,
                          ),

                          Gap(_sizes.h12),

                          // Skip button
                          TextButton(
                            onPressed: onSkipPressed,
                            style: TextButton.styleFrom(
                              minimumSize: const Size(170, 60),
                              padding:
                                  EdgeInsets.symmetric(horizontal: _sizes.h12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  _sizes.borderRadiusMd,
                                ),
                              ),
                            ),
                            child: Text(
                              'Skip',
                              style: _textStyles.heading(
                                color: _colors.slateBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a custom action button (Next or Get Started)
  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: _sizes.v40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_sizes.borderRadiusMd),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _colors.onboardingGradientStart,
            _colors.onboardingGradientEnd,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: _colors.white,
          backgroundColor: _colors.transparent,
          shadowColor: _colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: _sizes.h16),
          minimumSize: const Size(170, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_sizes.borderRadiusMd),
          ),
        ),
        child: Text(
          text,
          style: _textStyles.heading(
            color: _colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Builds the content for each page in landscape orientation
  Widget _buildPageContent(BuildContext context, OnboardingInfo slide) {
    return Row(
      children: [
        // Image section
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _sizes.h16),
            child: slide.image.image(
              fit: BoxFit.contain,
            ),
          ),
        ),

        // Text content section
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _sizes.h16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slide.title,
                  style: _textStyles.headingXl(
                    fontWeight: FontWeight.w700,
                    color: _colors.onboardingBlue,
                  ),
                ),
                Gap(_sizes.v8),
                Text(
                  slide.description,
                  style: _textStyles.bodyLg(
                    color: _colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
