import 'package:equatable/equatable.dart';

/// Model that stores information for each onboarding slide
class OnboardingInfo extends Equatable {
  /// Creates an OnboardingInfo instance with required information
  const OnboardingInfo({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  /// Path to the slide image
  final String imagePath;

  /// Title of the slide
  final String title;

  /// Detailed description of the slide
  final String description;

  @override
  List<Object?> get props => [imagePath, title, description];
}
