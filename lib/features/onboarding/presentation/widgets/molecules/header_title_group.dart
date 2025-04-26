import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_subtitle.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_title.dart';

/// A widget that groups the title and subtitle for the onboarding header
class HeaderTitleGroup extends StatelessWidget {
  /// Creates a HeaderTitleGroup with the specified title and subtitle
  const HeaderTitleGroup({
    required this.title,
    required this.subtitle,
    super.key,
  });

  /// The title text to display
  final String title;

  /// The subtitle text to display
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTitle(
          text: title,
        ),
        HeaderSubtitle(
          text: subtitle,
        ),
      ],
    );
  }
}
