import 'package:flutter/material.dart';

/// Base abstract class for header text widgets used in onboarding
abstract class BaseHeaderText extends StatelessWidget {
  /// Creates a base header text widget
  ///
  /// [text] là nội dung hiển thị, không được rỗng.
  /// [textStyle] là style tuỳ chỉnh, nếu null sẽ dùng style mặc định
  /// của subclass.
  /// [color] là màu chữ, nếu null sẽ dùng màu mặc định của subclass.
  /// [maxLines] số dòng tối đa, mặc định là 1.
  /// [textAlign] căn lề chữ, mặc định là start.
  /// [overflow] xử lý tràn chữ, mặc định là ellipsis.
  /// [semanticLabel] label cho accessibility, nếu null sẽ lấy text.
  /// [testId] cho phép truyền key test tự động, nếu null sẽ dùng key mặc định
  /// của subclass.
  const BaseHeaderText({
    required this.text,
    super.key,
    this.textStyle,
    this.color,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.semanticLabel,
    this.testId,
  })  : assert(text != '', 'Header text must not be empty'),
        assert(maxLines > 0, 'maxLines must be positive');

  /// The text to display (không được rỗng hoặc chỉ chứa khoảng trắng)
  final String text;

  /// The text style (style tuỳ chỉnh, nếu null sẽ dùng style mặc định
  /// của subclass)
  final TextStyle? textStyle;

  /// The color for the text (màu chữ, nếu null sẽ dùng màu mặc định
  /// của subclass)
  final Color? color;

  /// The maximum number of lines (số dòng tối đa, mặc định là 1)
  final int maxLines;

  /// The text alignment (căn lề chữ, mặc định là start)
  final TextAlign textAlign;

  /// The overflow behavior for the text (xử lý tràn chữ, mặc định là ellipsis)
  final TextOverflow overflow;

  /// Custom semantic label for accessibility
  /// (label cho screen reader, nếu null sẽ lấy text)
  final String? semanticLabel;

  /// Optional testId for widget key
  /// (cho phép truyền key test tự động,
  /// nếu null sẽ dùng key mặc định của subclass)
  final Key? testId;

  /// Whether this text is a header (for accessibility)
  bool get isHeader;

  /// Widget key (nên override ở subclass nếu cần key riêng)
  Key get textKey;

  /// Builds the effective text style for this header text
  TextStyle buildTextStyle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // Kiểm tra runtime xem text có chỉ chứa khoảng trắng không
    assert(
      text.trim().isNotEmpty,
      'Header text must not contain only whitespace',
    );

    return Semantics(
      header: isHeader,
      label: semanticLabel ?? text,
      child: Text(
        text,
        key: testId ?? textKey,
        style: buildTextStyle(context),
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
      ),
    );
  }
}
