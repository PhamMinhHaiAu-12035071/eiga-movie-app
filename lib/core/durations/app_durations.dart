/// Defines standard duration constants for animations, transitions, and delays
/// across the application for consistent timing experiences.
abstract class AppDurations {
  /// Very short duration - 100ms
  /// Use for small micro-interactions and subtle feedback
  Duration get veryShort;

  /// Short duration - 200ms
  /// Use for quick transitions and responsive feedback
  Duration get short;

  /// Medium duration - 300ms
  /// Use for standard animations and transitions
  Duration get medium;

  /// Long duration - 500ms
  /// Use for more elaborate animations
  Duration get long;

  /// Extra long duration - 800ms
  /// Use for complex or entrance animations
  Duration get extraLong;

  /// Full second duration - 1000ms
  /// Use for major transitions or loading states
  Duration get oneSecond;
}
