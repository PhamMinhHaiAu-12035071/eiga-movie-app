import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/base_header_text.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Title widget used in the onboarding header
class HeaderTitle extends BaseHeaderText {
  /// Creates a HeaderTitle with the specified text
  const HeaderTitle({
    required super.text,
    super.key,
    super.textStyle,
    super.color,
    super.maxLines = 1,
    super.textAlign = TextAlign.start,
    super.overflow = TextOverflow.ellipsis,
  });

  @override
  bool get isHeader => true;

  @override
  Key get textKey => const Key('onboarding_header_title');

  @override
  String get semanticLabel => text;

  @override
  TextStyle buildTextStyle(BuildContext context) {
    final effectiveColor = color ?? context.colors.slateBlue;

    return (textStyle ??
            context.textStyles.headingXl(
              fontWeight: FontWeight.w900,
            ))
        .copyWith(color: effectiveColor);
  }
}
