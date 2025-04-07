import 'package:flutter/material.dart';
import 'package:ksk_app/core/asset/app_image.dart';

/// Mở rộng theme với các asset
@immutable
class AppAssetExtension extends ThemeExtension<AppAssetExtension> {
  const AppAssetExtension({required this.appImage});

  /// Factory để tạo instance cho dark theme
  factory AppAssetExtension.dark() {
    return AppAssetExtension(
      appImage: AppImage.dark(),
    );
  }

  /// Factory để tạo instance cho light theme
  factory AppAssetExtension.light() {
    return AppAssetExtension(
      appImage: AppImage.light(),
    );
  }
  final AppImage appImage;

  @override
  ThemeExtension<AppAssetExtension> copyWith({
    AppImage? appImage,
  }) {
    return AppAssetExtension(
      appImage: appImage ?? this.appImage,
    );
  }

  @override
  ThemeExtension<AppAssetExtension> lerp(
    covariant ThemeExtension<AppAssetExtension>? other,
    double t,
  ) {
    if (other is! AppAssetExtension) {
      return this;
    }

    return this;
  }
}
