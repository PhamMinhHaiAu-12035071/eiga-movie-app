import 'package:flutter/material.dart';
import 'package:ksk_app/core/asset/app_image.dart';

/// Logo widget used in the onboarding screen
class OnboardingLogo extends StatelessWidget {
  /// Creates an OnboardingLogo with specified height
  const OnboardingLogo({
    required this.height,
    super.key,
  });

  /// The height of the logo
  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'App logo - EIGA',
      child: SizedBox(
        key: const Key('onboarding_logo_image'),
        height: height,
        child: AppImage.of(context).onboarding.logo.image(
              key: const Key('onboarding_header_image'),
              fit: BoxFit.contain,
            ),
      ),
    );
  }
}
