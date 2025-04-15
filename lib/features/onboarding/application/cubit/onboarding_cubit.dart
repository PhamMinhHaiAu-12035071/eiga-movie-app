import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/features/onboarding/application/cubit/onboarding_state.dart';
import 'package:ksk_app/features/onboarding/domain/models/onboarding_info.dart';
import 'package:ksk_app/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Manages the state and logic of the onboarding feature
@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  /// Constructor with dependency injection
  OnboardingCubit(this._repository)
      : super(
          OnboardingState(
            slides: [
              OnboardingInfo(
                image: OnboardingImages().screen1,
                title: 'ONBOARDING',
                description: 'Choose movies, watch trailers, take tickets',
              ),
              OnboardingInfo(
                image: OnboardingImages().screen2,
                title: 'Find Your Favorite Movies',
                description:
                    'Explore new and popular movies from around the world',
              ),
              OnboardingInfo(
                image: OnboardingImages().screen3,
                title: 'Book Tickets Quickly',
                description:
                    'Book movie tickets anytime, anywhere with just a few taps',
              ),
            ],
          ),
        );

  /// Repository that handles onboarding state persistence
  final OnboardingRepository _repository;

  /// Updates the current page when user swipes or taps buttons
  void updatePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  /// Navigates to the next page
  void nextPage() {
    if (!state.isLastPage) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  /// Marks onboarding as seen and navigates to the main screen
  Future<void> completeOnboarding() async {
    await _repository.markOnboardingAsSeen();
  }

  /// Checks if onboarding has been seen
  Future<bool> checkIfOnboardingSeen() async {
    return _repository.checkIfOnboardingSeen();
  }
}
