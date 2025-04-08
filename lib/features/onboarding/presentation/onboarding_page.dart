import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:ksk_app/core/di/injection.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_cubit.dart';
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_state.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_dot_indicator.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_next_button.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_page_view.dart';

/// OnboardingPage displays the introductory content for the application.
@RoutePage()
class OnboardingPage extends StatefulWidget {
  /// Constructor
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  /// Page controller that manages swiping between pages
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.onboardingBackground,
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Gap(50.h),

                    // Header with logo and app name
                    const OnboardingHeader(),

                    // PageView to display onboarding pages
                    OnboardingPageView(
                      controller: _pageController,
                      slides: state.slides,
                      onPageChanged: (index) =>
                          context.read<OnboardingCubit>().updatePage(index),
                    ),

                    // Dot indicators
                    OnboardingDotIndicator(
                      pageCount: state.slides.length,
                      currentIndex: state.currentPage,
                    ),

                    Gap(40.h),

                    // Next or Get Started button
                    OnboardingNextButton(
                      text: state.isLastPage ? 'Get Started' : 'Next',
                      isLastPage: state.isLastPage,
                      onPressed: () {
                        if (state.isLastPage) {
                          _finishOnboarding(context);
                        } else {
                          _nextPage(context);
                        }
                      },
                    ),

                    Gap(30.h),

                    // Skip button
                    TextButton(
                      onPressed: () => _finishOnboarding(context),
                      child: Text(
                        'Skip',
                        style: AppTextStyle.heading(
                          color: AppColors.skipButtonColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Gap(40.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Navigates to the next page
  void _nextPage(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    cubit.nextPage();
  }

  /// Completes onboarding and navigates to the main screen
  Future<void> _finishOnboarding(BuildContext context) async {
    final cubit = context.read<OnboardingCubit>();
    await cubit.completeOnboarding();

    // Navigate to main screen (will be implemented later)
    // context.router.replace(const HomeRoute());
  }
}
