import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ksk_app/core/di/injection.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/router/app_router.gr.dart' show LoginRoute;
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_cubit.dart';
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_state.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_landscape_view.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/onboarding_portrait_view.dart';

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
          // Get current orientation
          final orientation = MediaQuery.of(context).orientation;

          return Scaffold(
            body: SafeArea(
              child: orientation == Orientation.portrait
                  ? OnboardingPortraitView(
                      pageController: _pageController,
                      slides: state.slides,
                      currentPage: state.currentPage,
                      isLastPage: state.isLastPage,
                      onPageChanged: (index) =>
                          context.read<OnboardingCubit>().updatePage(index),
                      onNextPressed: () {
                        if (state.isLastPage) {
                          _finishOnboarding(context);
                        } else {
                          _nextPage(context);
                        }
                      },
                      onSkipPressed: () => _finishOnboarding(context),
                    )
                  : OnboardingLandscapeView(
                      pageController: _pageController,
                      slides: state.slides,
                      currentPage: state.currentPage,
                      isLastPage: state.isLastPage,
                      onPageChanged: (index) =>
                          context.read<OnboardingCubit>().updatePage(index),
                      onNextPressed: () {
                        if (state.isLastPage) {
                          _finishOnboarding(context);
                        } else {
                          _nextPage(context);
                        }
                      },
                      onSkipPressed: () => _finishOnboarding(context),
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
      duration: getIt<AppDurations>().medium,
      curve: Curves.easeInOut,
    );

    cubit.nextPage();
  }

  /// Completes onboarding and navigates to the main screen
  Future<void> _finishOnboarding(BuildContext context) async {
    final cubit = context.read<OnboardingCubit>();
    await cubit.completeOnboarding();

    // Navigate to login screen
    if (context.mounted) {
      await context.router.replace(const LoginRoute());
    }
  }
}
