import 'package:flutter/material.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Widget that displays a single dot indicator for onboarding
class DotIndicator extends StatelessWidget {
  /// Constructor
  const DotIndicator({
    required this.isActive,
    super.key,
    this.activeSize = 16,
    this.inactiveSize = 8,
    this.margin = const EdgeInsets.symmetric(horizontal: 4),
    this.borderRadius = 4,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.activeColor,
    this.inactiveOpacity = 0.4,
  });

  /// Whether this dot is the active one
  final bool isActive;

  /// Width of the active dot
  final double activeSize;

  /// Width and height of inactive dot
  final double inactiveSize;

  /// Margin around the dot
  final EdgeInsets margin;

  /// Border radius of the dot
  final double borderRadius;

  /// Duration for the animation
  final Duration duration;

  /// Animation curve
  final Curve curve;

  /// Color for active dot (defaults to onboardingBlue if null)
  final Color? activeColor;

  /// Opacity for inactive dot (0.0 to 1.0)
  final double inactiveOpacity;

  @override
  Widget build(BuildContext context) {
    final baseColor = activeColor ?? context.colors.onboardingBlue;

    return Semantics(
      label: isActive ? 'Active onboarding step' : 'Inactive onboarding step',
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        margin: margin,
        height: inactiveSize,
        width: isActive ? activeSize : inactiveSize,
        decoration: BoxDecoration(
          color: isActive
              ? baseColor
              : baseColor.withAlpha((inactiveOpacity * 255).round()),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
