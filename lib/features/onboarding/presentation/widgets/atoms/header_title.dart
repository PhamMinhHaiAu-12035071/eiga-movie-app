import 'package:flutter/material.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/base_header_text.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Title widget used in the onboarding header
class HeaderTitle extends BaseHeaderText {
  /// Creates a HeaderTitle with the specified text
  ///
  /// [text] văn bản hiển thị, yêu cầu không được rỗng
  /// [textStyle] style tùy chỉnh, nếu null sẽ dùng headingXl
  /// [color] màu của text, mặc định là slateBlue nếu không chỉ định
  /// [fontWeight] độ đậm của font, mặc định là w900 nếu không chỉ định
  /// [maxLines] số dòng tối đa, mặc định là 1
  /// [textAlign] căn lề text, mặc định là start
  /// [overflow] xử lý text tràn, mặc định là ellipsis
  /// [semanticLabel] nhãn ngữ nghĩa cho accessibility, mặc định là text
  /// [testId] key cho widget test, nếu null sẽ dùng key mặc định
  const HeaderTitle({
    required super.text,
    super.key,
    super.textStyle,
    super.color,
    super.maxLines = 1,
    super.textAlign = TextAlign.start,
    super.overflow = TextOverflow.ellipsis,
    super.semanticLabel,
    super.testId,
    this.fontWeight = FontWeight.w900,
  });

  /// Độ đậm của font (font weight)
  final FontWeight fontWeight;

  @override
  bool get isHeader => true;

  @override
  Key get textKey => const Key('onboarding_header_title');

  @override
  TextStyle buildTextStyle(BuildContext context) {
    final effectiveColor = color ?? context.colors.slateBlue;

    return (textStyle ??
            context.textStyles.headingXl(
              fontWeight: fontWeight,
            ))
        .copyWith(color: effectiveColor);
  }
}
