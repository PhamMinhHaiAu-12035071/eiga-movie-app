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
    final dots = List.generate(pageCount, (i) {
      return Row(
        children: [
          if (i > 0) Gap(effectiveSpacing),
          _buildDot(context, i),
        ],
      );
    }).expand((w) => [w]).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }

  Widget _buildDot(BuildContext ctx, int index) => Semantics(
        selected: index == currentIndex,
        label: 'Trang ${index + 1} trên $pageCount',
        child: DotIndicator(isActive: index == currentIndex),
      );
}
