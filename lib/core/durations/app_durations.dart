import 'package:flutter/material.dart';

/// Defines standard duration constants for animations, transitions, and delays
/// across the application for consistent timing experiences.
@immutable
class AppDurations {
  const AppDurations._();

  /// Very short duration - 100ms
  /// Use for small micro-interactions and subtle feedback
  static const Duration veryShort = Duration(milliseconds: 100);

  /// Short duration - 200ms
  /// Use for quick transitions and responsive feedback
  static const Duration short = Duration(milliseconds: 200);

  /// Medium duration - 300ms
  /// Use for standard animations and transitions
  static const Duration medium = Duration(milliseconds: 300);

  /// Long duration - 500ms
  /// Use for more elaborate animations
  static const Duration long = Duration(milliseconds: 500);

  /// Extra long duration - 800ms
  /// Use for complex or entrance animations
  static const Duration extraLong = Duration(milliseconds: 800);

  /// Full second duration - 1000ms
  /// Use for major transitions or loading states
  static const Duration oneSecond = Duration(seconds: 1);
}
