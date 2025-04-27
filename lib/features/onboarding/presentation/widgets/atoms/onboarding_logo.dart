import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Logo widget used in the onboarding screen
class OnboardingLogo extends StatelessWidget {
  /// Creates an OnboardingLogo with optional custom size
  const OnboardingLogo({
    this.containerSize,
    this.imageSize,
    this.borderRadius,
    this.containerColor,
    super.key,
  })  : assert(
          containerSize != null || imageSize != null,
          'Either containerSize or imageSize must be provided',
        ),
        assert(
          imageSize != null &&
              containerSize != null &&
              imageSize <= containerSize,
          'imageSize must not exceed containerSize',
        );

  /// The size of the container (width = height)
  final double? containerSize;

  /// The size of the image (width = height)
  final double? imageSize;

  /// The border radius of the container
  final double? borderRadius;

  /// The background color of the container
  final Color? containerColor;

  /// The label for the logo
  static const _label = 'App logo - EIGA';

  /// The key for the logo container
  static const _logoContainerKey = Key('onboarding_logo_container');

  /// The key for the logo image container
  static const _logoImageContainerKey = Key('onboarding_logo_image_container');

  @override
  Widget build(BuildContext context) {
    final colors = GetIt.I<AppColors>();
    final boxSize = containerSize ?? context.sizes.h56;
    final imageSize = this.imageSize ?? context.sizes.h32;
    final borderRadius = this.borderRadius ?? context.sizes.r12;
    final containerColor = this.containerColor ?? colors.white;

    return Semantics(
      label: _label,
      child: Container(
        key: _logoContainerKey,
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: containerColor,
        ),
        child: Center(
          child: SizedBox(
            key: _logoImageContainerKey,
            width: imageSize,
            height: imageSize,
            child: AppImage.of(context).onboarding.logo.image(
                  key: const Key('onboarding_logo_image'),
                  fit: BoxFit.contain,
                ),
          ),
        ),
      ),
    );
  }
}
