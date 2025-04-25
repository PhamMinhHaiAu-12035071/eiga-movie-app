import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Logo widget used in the onboarding screen
class OnboardingLogo extends StatelessWidget {
  /// Creates an OnboardingLogo with optional custom size
  const OnboardingLogo({
    this.containerSize,
    this.imageSize,
    this.borderRadius,
    this.containerColor,
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

  @override
  Widget build(BuildContext context) {
    final colors = GetIt.I<AppColors>();
    final boxSize = containerSize ?? 59.sp;
    final imageSize = this.imageSize ?? 37.sp;
    final borderRadius = this.borderRadius ?? 12.r;
    final containerColor = this.containerColor ?? colors.white;

    return Semantics(
      label: 'App logo - EIGA',
      child: Container(
        key: const Key('onboarding_logo_container'),
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: containerColor,
        ),
        child: Center(
          child: SizedBox(
            key: const Key('onboarding_logo_image_container'),
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
