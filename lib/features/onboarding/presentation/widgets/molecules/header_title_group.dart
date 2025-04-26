import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_subtitle.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_title.dart';

/// A widget that groups the title and subtitle for the onboarding header
class HeaderTitleGroup extends StatelessWidget {
  /// Creates a HeaderTitleGroup with the specified title and subtitle
  const HeaderTitleGroup({
    required this.title,
    required this.subtitle,
    this.spacing = 3.29,
    super.key,
  });

  /// The title text to display
  final String title;

  /// The subtitle text to display
  final String subtitle;

  /// The spacing between the title and subtitle
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTitle(
          text: title,
        ),
        Gap(spacing.h),
        HeaderSubtitle(
          text: subtitle,
        ),
      ],
    );
  }
}
