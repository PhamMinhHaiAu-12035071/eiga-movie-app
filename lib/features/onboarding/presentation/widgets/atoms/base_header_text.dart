import 'package:flutter/material.dart';

/// Base abstract class for header text widgets used in onboarding
abstract class BaseHeaderText extends StatelessWidget {
  /// Creates a base header text widget
  const BaseHeaderText({
    required this.text,
    super.key,
    this.textStyle,
    this.color,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  })  : assert(text != '', 'Header text must not be empty'),
        assert(maxLines > 0, 'maxLines must be positive');

  /// The text to display
  final String text;

  /// The text style
  final TextStyle? textStyle;

  /// The color for the text
  final Color? color;

  /// The maximum number of lines
  final int maxLines;

  /// The text alignment
  final TextAlign textAlign;

  /// The overflow behavior for the text
  final TextOverflow overflow;

  /// Whether this text is a header (for accessibility)
  bool get isHeader;

  /// Default semantic label
  String get semanticLabel => text;

  /// Widget key
  Key get textKey;

  /// Builds the effective text style for this header text
  TextStyle buildTextStyle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // Runtime check for whitespace-only text
    assert(
      text.trim().isNotEmpty,
      'Header text must not contain only whitespace',
    );

    return Semantics(
      header: isHeader,
      label: semanticLabel,
      child: Text(
        text,
        key: textKey,
        style: buildTextStyle(context),
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
      ),
    );
  }
}
