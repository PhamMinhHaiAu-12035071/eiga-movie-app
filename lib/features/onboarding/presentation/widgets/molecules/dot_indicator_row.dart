import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/dot_indicator.dart';

/// Widget that displays a row of dot indicators for page position
class DotIndicatorRow extends StatelessWidget {
  /// Constructor
  const DotIndicatorRow({
    required this.pageCount,
    required this.currentIndex,
    this.spacing = 8.0,
    super.key,
  })  : assert(pageCount > 0, 'pageCount phải > 0'),
        assert(
          currentIndex >= 0 && currentIndex < pageCount,
          'currentIndex ngoài phạm vi [0, pageCount)',
        );

  /// Number of pages
  final int pageCount;

  /// Current page index
  final int currentIndex;

  /// Spacing between dots
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount * 2 - 1, (i) {
        if (i.isOdd) return SizedBox(width: spacing);
        final idx = i ~/ 2;
        final active = idx == currentIndex;
        return Semantics(
          selected: active,
          label: 'Page ${idx + 1} of $pageCount',
          child: DotIndicator(isActive: active),
        );
      }),
    );
  }
}
