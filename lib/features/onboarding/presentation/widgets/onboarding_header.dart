import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/asset/app_image.dart' show AppImage;
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Widget that displays the header for the onboarding screen
/// Contains the logo and app name
class OnboardingHeader extends StatelessWidget {
  /// Constructor
  const OnboardingHeader({super.key});

  /// Access app sizes
  AppSizes get _sizes => GetIt.I<AppSizes>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _sizes.h32),
      child: Row(
        children: [
          SizedBox(
            height: _sizes.v56,
            child: AppImage.of(context).onboarding.logo.image(
                  fit: BoxFit.contain,
                ),
          ),
          Gap(_sizes.h16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EIGA',
                style: AppTextStyle.headingXl(
                  fontWeight: FontWeight.w900,
                  color: AppColors.skipButtonColor,
                ),
              ),
              Text(
                'CINEMA UI KIT.',
                style: AppTextStyle.headingSm(
                  fontWeight: FontWeight.w500,
                  color: AppColors.skipButtonColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
