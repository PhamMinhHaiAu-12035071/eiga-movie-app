import 'package:flutter/material.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Widget that displays a single dot indicator for onboarding
class DotIndicator extends StatelessWidget {
  /// Constructor
  const DotIndicator({
    required this.isActive,
    super.key,
    this.activeSize,
    this.inactiveSize,
    this.margin,
    this.borderRadius,
    this.duration,
    this.curve,
    this.activeColor,
    this.inactiveOpacity,
  }) : assert(
          inactiveOpacity == null ||
              (inactiveOpacity >= 0 && inactiveOpacity <= 1),
          'inactiveOpacity must be between 0.0 and 1.0',
        );

  /// Whether this dot is the active one
  final bool isActive;

  /// Width of the active dot
  final double? activeSize;

  /// Width and height of inactive dot
  final double? inactiveSize;

  /// Margin around the dot
  final EdgeInsets? margin;

  /// Border radius of the dot
  final double? borderRadius;

  /// Duration for the animation
  final Duration? duration;

  /// Animation curve
  final Curve? curve;

  /// Color for active dot (defaults to onboardingBlue if null)
  final Color? activeColor;

  /// Opacity for inactive dot (0.0 to 1.0)
  final double? inactiveOpacity;

  @override
  Widget build(BuildContext context) {
    final effectiveActiveSize = activeSize ?? context.sizes.h16;
    final effectiveInactiveSize = inactiveSize ?? context.sizes.h8;
    final effectiveMargin =
        margin ?? EdgeInsets.symmetric(horizontal: context.sizes.h8);
    final effectiveBorderRadius = borderRadius ?? context.sizes.r8;
    final effectiveDuration = duration ?? context.durations.medium;
    final effectiveCurve = curve ?? Curves.easeInOut;
    final base = activeColor ?? context.colors.onboardingBlue;
    final effInactiveOpacity = inactiveOpacity ?? .4;
    final effInactiveColor = base.withAlpha((effInactiveOpacity * 255).round());

    return Semantics(
      container: true,
      label: 'Onboarding step ${isActive ? 'active' : 'inactive'}',
      child: AnimatedContainer(
        duration: effectiveDuration,
        curve: effectiveCurve,
        margin: effectiveMargin,
        height: effectiveInactiveSize,
        width: isActive ? effectiveActiveSize : effectiveInactiveSize,
        decoration: BoxDecoration(
          color: isActive ? base : effInactiveColor,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
        ),
      ),
    );
  }
}
