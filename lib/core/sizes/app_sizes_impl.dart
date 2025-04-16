import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';

/// Implementation of application sizes
/// that can be injected and mocked for testing
@LazySingleton(as: AppSizes)
class AppSizesImpl implements AppSizes {
  const AppSizesImpl();

  // 2 pixel variations
  @override
  double get r2 => 2.r;
  @override
  double get v2 => 2.h;
  @override
  double get h2 => 2.w;

  // 4 pixel variations
  @override
  double get r4 => 4.r;
  @override
  double get v4 => 4.h;
  @override
  double get h4 => 4.w;

  // 8 pixel variations
  @override
  double get r8 => 8.r;
  @override
  double get v8 => 8.h;
  @override
  double get h8 => 8.w;

  // 12 pixel variations
  @override
  double get r12 => 12.r;
  @override
  double get v12 => 12.h;
  @override
  double get h12 => 12.w;

  // 16 pixel variations
  @override
  double get r16 => 16.r;
  @override
  double get v16 => 16.h;
  @override
  double get h16 => 16.w;

  // 20 pixel variations
  @override
  double get r20 => 20.r;
  @override
  double get v20 => 20.h;
  @override
  double get h20 => 20.w;

  // 24 pixel variations
  @override
  double get r24 => 24.r;
  @override
  double get v24 => 24.h;
  @override
  double get h24 => 24.w;

  // 32 pixel variations
  @override
  double get r32 => 32.r;
  @override
  double get v32 => 32.h;
  @override
  double get h32 => 32.w;

  // 40 pixel variations
  @override
  double get r40 => 40.r;
  @override
  double get v40 => 40.h;
  @override
  double get h40 => 40.w;

  // 48 pixel variations
  @override
  double get r48 => 48.r;
  @override
  double get v48 => 48.h;
  @override
  double get h48 => 48.w;

  // 56 pixel variations
  @override
  double get r56 => 56.r;
  @override
  double get v56 => 56.h;
  @override
  double get h56 => 56.w;

  // 64 pixel variations
  @override
  double get r64 => 64.r;
  @override
  double get v64 => 64.h;
  @override
  double get h64 => 64.w;

  // 80 pixel variations
  @override
  double get r80 => 80.r;
  @override
  double get v80 => 80.h;
  @override
  double get h80 => 80.w;

  // 128 pixel variations
  @override
  double get r128 => 128.r;
  @override
  double get v128 => 128.h;
  @override
  double get h128 => 128.w;

  // 192 pixel variations
  @override
  double get r192 => 192.r;
  @override
  double get v192 => 192.h;
  @override
  double get h192 => 192.w;

  // 256 pixel variations
  @override
  double get r256 => 256.r;
  @override
  double get v256 => 256.h;
  @override
  double get h256 => 256.w;

  // 260 pixel variations (specific for onboarding image size)
  @override
  double get r260 => 260.r;
  @override
  double get v260 => 260.h;
  @override
  double get h260 => 260.w;

  // Border radius dimensions
  @override
  double get borderRadiusXs => 6.r;
  @override
  double get borderRadiusSm => 8.r;
  @override
  double get borderRadiusMd => 12.r;
  @override
  double get borderRadiusLg => 16.r;
}
