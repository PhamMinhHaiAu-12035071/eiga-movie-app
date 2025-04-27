import 'package:flutter/material.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Title widget used in the onboarding header
class HeaderTitle extends StatelessWidget {
  /// Creates a HeaderTitle with the specified text
  const HeaderTitle({
    required this.text,
    super.key,
    this.textStyle,
    this.color,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  })  : assert(text != '', 'Header title must not be empty'),
        assert(maxLines > 0, 'maxLines must be positive');

  /// The text to display as the title
  final String text;

  /// The text style for the title
  final TextStyle? textStyle;

  /// The color for the title
  final Color? color;

  /// The maximum number of lines for the title
  final int maxLines;

  /// The text alignment for the title
  final TextAlign textAlign;

  /// The overflow behavior for the text
  final TextOverflow overflow;

  /// Builds the effective text style for the header
  TextStyle _buildHeaderStyle(BuildContext context) {
    final effectiveColor = color ?? context.colors.slateBlue;

    return (textStyle ??
            context.textStyles.headingXl(
              fontWeight: FontWeight.w900,
            ))
        .copyWith(color: effectiveColor);
  }

  @override
  Widget build(BuildContext context) {
    // Additional runtime check for whitespace-only text
    assert(
      text.trim().isNotEmpty,
      'Header title must not contain only whitespace',
    );

    return Semantics(
      header: true,
      label: text,
      child: Text(
        text,
        key: const Key('onboarding_header_title'),
        style: _buildHeaderStyle(context),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
