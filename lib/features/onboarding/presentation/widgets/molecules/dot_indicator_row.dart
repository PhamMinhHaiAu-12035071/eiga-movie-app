import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:ksk_app/core/sizes/app_sizes.dart' show AppSizes;
import 'package:ksk_app/features/onboarding/presentation/widgets/atoms/dot_indicator.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Widget hiển thị một hàng các chỉ báo chấm tròn, thường được sử dụng để
/// chỉ ra trang hiện tại trong một chuỗi trang.
///
/// Widget này có hai thuộc tính bắt buộc:
/// - [pageCount]: Tổng số trang (xác định số lượng chỉ báo chấm được hiển thị)
/// - [currentIndex]: Chỉ số của trang hiện tại (xác định chỉ báo chấm nào được
///   đánh dấu là hoạt động)
///
/// Và một thuộc tính tùy chọn:
/// - [spacing]: Khoảng cách giữa các chỉ báo chấm (mặc định là [AppSizes.h8])
///
/// Sử dụng:
/// ```dart
/// DotIndicatorRow(
///   pageCount: 3,
///   currentIndex: 1,
///   spacing: 16.0,
/// )
/// ```
///
/// Widget này chấp nhận các parameters:
/// - [pageCount]: Tổng số trang - phải > 0
/// - [currentIndex]: Chỉ số trang hiện tại, nằm trong khoảng [0, pageCount)
/// - [spacing]: Khoảng cách giữa các chấm, sử dụng [AppSizes.h8] nếu không
///   được thiết lập
class DotIndicatorRow extends StatelessWidget {
  /// Khởi tạo một hàng chỉ báo chấm với các thuộc tính đã cho
  ///
  /// [pageCount] và [currentIndex] là các tham số bắt buộc.
  /// [currentIndex] phải nằm trong khoảng [0, pageCount).
  const DotIndicatorRow({
    required this.pageCount,
    required this.currentIndex,
    super.key,
    this.spacing,
  })  : assert(pageCount > 0, 'pageCount phải > 0'),
        assert(
          currentIndex >= 0 && currentIndex < pageCount,
          'currentIndex ngoài phạm vi [0, pageCount)',
        );

  /// Tổng số trang cần hiển thị
  final int pageCount;

  /// Chỉ số trang hiện tại được chọn (zero-based)
  final int currentIndex;

  /// Khoảng cách giữa các chấm (mặc định là [AppSizes.h8])
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _dotList(context),
    );
  }

  /// Tạo ra danh sách các widget chỉ báo chấm với chỉ báo chấm hiện tại được
  /// đánh dấu khác biệt.
  Widget _dotList(BuildContext context) {
    final effectiveSpacing = spacing ?? context.sizes.h8;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < pageCount; i++) ...[
          if (i > 0) Gap(effectiveSpacing),
          _buildDot(context, i),
        ],
      ],
    );
  }

  /// Tạo một chấm đơn lẻ với ngữ cảnh accessibility phù hợp
  Widget _buildDot(BuildContext ctx, int index) => Semantics(
        selected: index == currentIndex,
        label: 'Trang ${index + 1} trên $pageCount',
        child: DotIndicator(isActive: index == currentIndex),
      );
}
