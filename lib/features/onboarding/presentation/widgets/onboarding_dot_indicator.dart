import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/molecules/dot_indicator_row.dart';

/// Widget that displays dot indicators for page position in onboarding
class OnboardingDotIndicator extends StatelessWidget {
  /// Constructor
  const OnboardingDotIndicator({
    required this.pageCount,
    required this.currentIndex,
    super.key,
  });

  /// Number of pages
  final int pageCount;

  /// Current page index
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return DotIndicatorRow(
      pageCount: pageCount,
      currentIndex: currentIndex,
    );
  }
}
