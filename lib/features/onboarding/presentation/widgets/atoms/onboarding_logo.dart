import 'package:flutter/material.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Logo widget used in the onboarding screen
class OnboardingLogo extends StatelessWidget {
  /// Creates an OnboardingLogo with optional custom size
  ///
  /// [containerSize] kích thước của container (width = height),
  /// nếu null sẽ dùng context.sizes.h56
  /// [imageSize] kích thước của hình ảnh (width = height),
  /// nếu null sẽ dùng context.sizes.h32
  /// [borderRadius] bo góc của container,
  /// nếu null sẽ dùng context.sizes.r12
  /// [containerColor] màu nền của container,
  /// nếu null sẽ dùng Theme.of(context).colorScheme.surface
  /// [semanticLabel] nhãn accessibility cho logo,
  /// nếu null sẽ dùng 'App logo - EIGA'
  /// [testId] key cho container,
  /// nếu null sẽ dùng Key('onboarding_logo_container')
  /// [imageTestId] key cho hình ảnh,
  /// nếu null sẽ dùng Key('onboarding_logo_image')
  const OnboardingLogo({
    this.containerSize,
    this.imageSize,
    this.borderRadius,
    this.containerColor,
    this.semanticLabel,
    this.testId,
    this.imageTestId,
    super.key,
  });

  /// The size of the container (width = height)
  final double? containerSize;

  /// The size of the image (width = height)
  final double? imageSize;

  /// The border radius of the container
  final double? borderRadius;

  /// The background color of the container
  final Color? containerColor;

  /// The custom semantic label for the logo
  final String? semanticLabel;

  /// The custom test key for the container
  final Key? testId;

  /// The custom test key for the image
  final Key? imageTestId;

  /// The default label for the logo
  static const _defaultLabel = 'App logo - EIGA';

  /// The default key for the logo container
  static const _logoContainerKey = Key('onboarding_logo_container');

  /// The default key for the image
  static const _logoImageKey = Key('onboarding_logo_image');

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
      label: semanticLabel ?? _defaultLabel,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: Container(
          key: testId ?? _logoContainerKey,
          width: effectiveContainerSize,
          height: effectiveContainerSize,
          color: effectiveColor,
          child: Center(
            child: SizedBox(
              key: _logoImageContainerKey,
              width: effectiveImageSize,
              height: effectiveImageSize,
              child: AppImage.of(context).onboarding.logo.image(
                    key: imageTestId ?? _logoImageKey,
                    fit: BoxFit.contain,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
