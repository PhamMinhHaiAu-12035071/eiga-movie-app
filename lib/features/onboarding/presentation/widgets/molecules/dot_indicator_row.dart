import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/dot_indicator.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Widget that displays a row of dot indicators for page position
class DotIndicatorRow extends StatelessWidget {
  /// Constructor
  const DotIndicatorRow({
    required this.pageCount,
    required this.currentIndex,
    super.key,
    this.spacing,
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
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _dotList(context),
    );
  }

  Widget _dotList(BuildContext context) {
    final effectiveSpacing = spacing ?? context.sizes.h8;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < pageCount; i++) ...[
          if (i > 0) Gap(effectiveSpacing),
          Semantics(
            selected: i == currentIndex,
            label: 'Trang ${i + 1} trên $pageCount',
            child: DotIndicator(isActive: i == currentIndex),
          ),
        ],
      ],
    );
  }
}
