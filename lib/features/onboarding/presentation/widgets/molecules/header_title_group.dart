import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:ksk_app/core/sizes/app_sizes.dart' show AppSizes;
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_subtitle.dart';
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/header_title.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Widget nhóm tiêu đề và phụ đề cho phần header onboarding
///
/// Widget này kết hợp [HeaderTitle] và [HeaderSubtitle] trong một layout
/// dọc với khoảng cách có thể tùy chỉnh giữa chúng. Được thiết kế để tạo
/// thành phần tiêu đề thống nhất trên màn hình onboarding.
///
/// Sử dụng:
/// ```dart
/// HeaderTitleGroup(
///   title: 'EIGA',
///   subtitle: 'CINEMA UI KIT.',
///   verticalSpacing: 8.0,
/// )
/// ```
///
/// Widget này có hai thuộc tính bắt buộc:
/// - [title]: Văn bản hiển thị làm tiêu đề chính
/// - [subtitle]: Văn bản hiển thị làm phụ đề
///
/// Và một thuộc tính tùy chọn:
/// - [verticalSpacing]: Khoảng cách giữa tiêu đề và phụ đề
///   (mặc định là [AppSizes.h4])
class HeaderTitleGroup extends StatelessWidget {
  /// Tạo một HeaderTitleGroup với tiêu đề và phụ đề được chỉ định
  ///
  /// Widget này sẽ hiển thị tiêu đề và phụ đề theo bố cục dọc với
  /// khoảng cách được chỉ định.
  const HeaderTitleGroup({
    required this.title,
    required this.subtitle,
    super.key,
    this.verticalSpacing,
  });

  /// Văn bản tiêu đề để hiển thị
  ///
  /// Thường được hiển thị với phông chữ lớn hơn và đậm hơn.
  final String title;

  /// Văn bản phụ đề để hiển thị
  ///
  /// Thường được hiển thị ngay bên dưới [title] với kiểu chữ khác biệt.
  final String subtitle;

  /// Khoảng cách dọc giữa tiêu đề và phụ đề
  ///
  /// Nếu không được thiết lập, sẽ mặc định sử dụng [AppSizes.h4].
  final double? verticalSpacing;

  @override
  Widget build(BuildContext context) {
    final effectiveVerticalSpacing = verticalSpacing ?? context.sizes.h4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTitle(text: title),
        Gap(effectiveVerticalSpacing),
        HeaderSubtitle(text: subtitle),
      ],
    );
  }
}
