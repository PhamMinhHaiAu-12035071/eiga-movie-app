import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:ksk_app/core/asset/app_image.dart' show AppImage;
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';

/// Widget that displays the header for the onboarding screen
/// Contains the logo and app name
class OnboardingHeader extends StatelessWidget {
  /// Constructor
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Row(
        children: [
          SizedBox(
            height: 60.h,
            child: AppImage.of(context).onboarding.logo.image(
                  fit: BoxFit.contain,
                ),
          ),
          Gap(14.w),
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
