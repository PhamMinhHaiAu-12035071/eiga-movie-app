import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/base_header_text.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Subtitle widget used in the onboarding header
class HeaderSubtitle extends BaseHeaderText {
  /// Creates a HeaderSubtitle with the specified text
  const HeaderSubtitle({
    required super.text,
    super.key,
    super.textStyle,
    super.color,
    super.maxLines = 1,
    super.textAlign = TextAlign.start,
    super.overflow = TextOverflow.ellipsis,
  });

  @override
  bool get isHeader => false;

  @override
  Key get textKey => const Key('onboarding_header_subtitle');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    final effectiveColor = color ?? context.colors.slateBlue;

    return (textStyle ??
            context.textStyles.headingSm(
              fontWeight: FontWeight.w500,
            ))
        .copyWith(color: effectiveColor);
  }
}
