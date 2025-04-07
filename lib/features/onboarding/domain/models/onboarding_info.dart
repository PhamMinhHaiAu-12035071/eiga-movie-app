import 'package:equatable/equatable.dart';
import 'package:ksk_app/generated/assets.gen.dart';

/// Model that stores information for each onboarding slide
class OnboardingInfo extends Equatable {
  /// Creates an OnboardingInfo instance with required information
  const OnboardingInfo({
    required this.image,
    required this.title,
    required this.description,
  });

  /// Image asset for the slide
  final AssetGenImage image;

  /// Title of the slide
  final String title;

  /// Detailed description of the slide
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
