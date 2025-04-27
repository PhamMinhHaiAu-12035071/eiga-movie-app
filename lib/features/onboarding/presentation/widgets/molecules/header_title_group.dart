import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_subtitle.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_title.dart';
import 'package:ksk_app/utils/context_x.dart';

/// A widget that groups the title and subtitle for the onboarding header
class HeaderTitleGroup extends StatelessWidget {
  /// Creates a HeaderTitleGroup with the specified title and subtitle
  const HeaderTitleGroup({
    required this.title,
    required this.subtitle,
    super.key,
    this.verticalSpacing = _kDefaultVerticalSpacing,
  });
  static const double _kDefaultVerticalSpacing = 3.29;

  /// The title text to display
  final String title;

  /// The subtitle text to display
  final String subtitle;

  /// The spacing between the title and subtitle
  final double? verticalSpacing;

  @override
  Widget build(BuildContext context) {
    final effectiveVerticalSpacing = verticalSpacing ?? context.sizes.h4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTitle(text: title),
        Gap(effectiveVerticalSpacing),
        HeaderSubtitle(text: subtitle),
      ],
    );
  }
}
