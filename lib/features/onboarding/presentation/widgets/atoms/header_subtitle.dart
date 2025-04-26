import 'package:flutter/material.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Subtitle widget used in the onboarding header
class HeaderSubtitle extends StatelessWidget {
  /// Creates a HeaderSubtitle with the specified text
  HeaderSubtitle({
    required this.text,
    super.key,
    this.textStyle,
    this.color,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  })  : assert(text.trim().isNotEmpty, 'Header subtitle must not be empty'),
        assert(maxLines > 0, 'maxLines must be positive');

  /// The text to display as the subtitle
  final String text;

  /// The text style for the subtitle
  final TextStyle? textStyle;

  /// The color for the subtitle
  final Color? color;

  /// The maximum number of lines for the subtitle
  final int maxLines;

  /// The text alignment for the subtitle
  final TextAlign textAlign;

  /// The overflow behavior for the text
  final TextOverflow overflow;

  /// Builds the effective text style for the header subtitle
  TextStyle _buildHeaderStyle(BuildContext context) {
    final effectiveColor = color ?? context.colors.slateBlue;

    return (textStyle ??
            context.textStyles.headingSm(
              fontWeight: FontWeight.w500,
            ))
        .copyWith(color: effectiveColor);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      child: Text(
        text,
        key: const Key('onboarding_header_subtitle'),
        style: _buildHeaderStyle(context),
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
      ),
    );
  }
}
