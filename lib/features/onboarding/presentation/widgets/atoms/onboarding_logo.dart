import 'package:flutter/material.dart';
import 'package:ksk_app/core/asset/app_image.dart';
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
          imageSize == null ||
              containerSize == null ||
              imageSize <= containerSize,
          'When both provided, imageSize must ≤ containerSize',
        ),
        assert(
          containerSize != null || imageSize != null,
          'Either containerSize or imageSize must be provided',
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
    final effectiveContainerSize = containerSize ?? context.sizes.h56;
    final effectiveImageSize = imageSize ?? context.sizes.h32;
    final effectiveBorderRadius = borderRadius ?? context.sizes.r12;
    final effectiveColor =
        containerColor ?? Theme.of(context).colorScheme.surface;

    return Semantics(
      header: false,
      button: false,
      label: _label,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: Container(
          key: _logoContainerKey,
          width: effectiveContainerSize,
          height: effectiveContainerSize,
          color: effectiveColor,
          child: Center(
            child: SizedBox(
              key: _logoImageContainerKey,
              width: effectiveImageSize,
              height: effectiveImageSize,
              child: AppImage.of(context).onboarding.logo.image(
                    key: const Key('onboarding_logo_image'),
                    fit: BoxFit.contain,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
