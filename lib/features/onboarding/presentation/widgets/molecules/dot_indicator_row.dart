import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/dot_indicator_atom.dart';

/// Widget that displays a row of dot indicators for page position
class DotIndicatorRow extends StatelessWidget {
  /// Constructor
  const DotIndicatorRow({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => DotIndicatorAtom(
          isActive: index == currentIndex,
        ),
      ),
    );
  }
}
