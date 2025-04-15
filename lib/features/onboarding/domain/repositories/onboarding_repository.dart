/// Interface defining operations related to Onboarding
abstract class OnboardingRepository {
  /// Checks if the user has seen the onboarding
  ///
  /// Returns true if seen, false if not seen
  Future<bool> checkIfOnboardingSeen();

  /// Marks that the user has seen the onboarding
  ///
  /// Writes true value to local storage
  Future<void> markOnboardingAsSeen();
}
