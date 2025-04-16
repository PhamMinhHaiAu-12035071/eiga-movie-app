import 'package:equatable/equatable.dart';
import 'package:ksk_app/features/onboarding/domain/models/onboarding_info.dart';

/// State of the OnboardingCubit
class OnboardingState extends Equatable {
  /// Constructor
  const OnboardingState({
    required this.slides,
    this.currentPage = 0,
    this.error,
  });

  /// List of onboarding information slides
  final List<OnboardingInfo> slides;

  /// Current page being displayed
  final int currentPage;

  /// Error message, if any
  final String? error;

  /// Check if this is the last page
  bool get isLastPage => currentPage == slides.length - 1;

  /// Creates a copy of the state with optional changed properties
  OnboardingState copyWith({
    List<OnboardingInfo>? slides,
    int? currentPage,
    String? error,
  }) {
    return OnboardingState(
      slides: slides ?? this.slides,
      currentPage: currentPage ?? this.currentPage,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [slides, currentPage, error];
}
