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
    final activeSize = this.activeSize ?? context.sizes.h16;
    final inactiveSize = this.inactiveSize ?? context.sizes.h8;
    final margin =
        this.margin ?? EdgeInsets.symmetric(horizontal: context.sizes.h8);
    final borderRadius = this.borderRadius ?? context.sizes.r8;
    final duration = this.duration ?? context.durations.medium;
    final curve = this.curve ?? Curves.easeInOut;
    final baseColor = activeColor ?? context.colors.onboardingBlue;
    final inactiveOpacity = this.inactiveOpacity ?? 0.4;

    return Semantics(
      container: true,
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
