import 'package:flutter/material.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Widget that displays a single dot indicator for onboarding
class DotIndicator extends StatelessWidget {
  /// Constructor
  ///
  /// [isActive] trạng thái dot hiện tại (active/inactive)
  /// [activeSize] kích thước dot khi active, mặc định là 16
  /// [inactiveSize] kích thước dot khi inactive, mặc định là 8
  /// [margin] khoảng cách xung quanh dot, mặc định 8px horizontal
  /// [borderRadius] bo góc dot, mặc định là 8
  /// [duration] thời gian animation, mặc định là duration medium
  /// [curve] kiểu animation, mặc định là easeInOut
  /// [activeColor] màu dot khi active, mặc định là onboardingBlue
  /// [inactiveOpacity] độ trong suốt khi inactive (0.0-1.0), mặc định là 0.4
  /// [border] viền chung cho dot, ưu tiên thấp hơn activeBorder và
  /// [activeBorder] viền riêng cho dot khi active
  /// [inactiveBorder] viền riêng cho dot khi inactive
  /// [testId] key cho test UI, nếu null sẽ tạo key tự động dựa trên trạng thái
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
    this.border,
    this.activeBorder,
    this.inactiveBorder,
    this.testId,
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

  /// Border for both active and inactive dots (override by active/inactive specific borders)
  final BoxBorder? border;

  /// Border specifically for active dot
  final BoxBorder? activeBorder;

  /// Border specifically for inactive dot
  final BoxBorder? inactiveBorder;

  /// Test ID key for dot
  final Key? testId;

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

    // Xác định border hiệu quả dựa trên trạng thái
    final effectiveBorder =
        isActive ? activeBorder ?? border : inactiveBorder ?? border;

    // Tạo key tự động nếu không có testId
    final effectiveKey =
        testId ?? Key('dot_indicator_${isActive ? 'active' : 'inactive'}');

    return Semantics(
      container: true,
      label: 'Onboarding step ${isActive ? 'active' : 'inactive'}',
      child: AnimatedContainer(
        key: effectiveKey,
        duration: effectiveDuration,
        curve: effectiveCurve,
        margin: effectiveMargin,
        height: effectiveInactiveSize,
        width: isActive ? effectiveActiveSize : effectiveInactiveSize,
        decoration: BoxDecoration(
          color: isActive ? base : effInactiveColor,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          border: effectiveBorder,
        ),
      ),
    );
  }
}
