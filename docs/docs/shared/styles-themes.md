---
sidebar_position: 3
title: Styles & Themes
description: Quản lý styles và themes trong KSK App
---

# Styles & Themes

Dự án KSK App sử dụng cách tiếp cận có cấu trúc để quản lý styles và themes, tách biệt các thành phần UI cơ bản (colors, text styles) với các cấu hình theme.

## Cấu trúc thư mục

```
lib/core/
├── styles/                  # Định nghĩa styles cơ bản
│   ├── colors/             # Định nghĩa và quản lý màu sắc
│   │   ├── app_colors.dart  # Các màu sắc cơ bản
│   │   └── colors.dart      # File export
│   ├── app_text_styles.dart # Định nghĩa các kiểu text
│   └── styles.dart          # File export
└── themes/                  # Quản lý themes
    ├── extensions/         # Các extension cho theme
    │   ├── app_asset_extension.dart  # Quản lý assets theo theme
    │   └── app_color_extension.dart  # Quản lý màu sắc theo theme
    ├── app_theme.dart      # Cấu hình chính cho theme
    └── themes.dart         # File export
```

## Styles

### Colors

Các màu sắc cơ bản được định nghĩa trong `app_colors.dart`:

```dart
abstract class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF4CAF50);
  
  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  
  // Functional Colors
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color success = Color(0xFF4CAF50);
  
  // Onboarding specific colors
  static const Color onboardingBlue = Color(0xFF607395);
  // ... các màu khác
}
```

File `colors.dart` export `app_colors.dart` để dễ dàng import:

```dart
export 'app_colors.dart';
```

### Text Styles

Các kiểu text được định nghĩa trong `app_text_styles.dart`:

```dart
abstract class AppTextStyle {
  // Headings
  static TextStyle headingLg() {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
    );
  }
  
  static TextStyle heading() {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    );
  }
  
  static TextStyle headingSm() {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    );
  }
  
  static TextStyle headingXs() {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    );
  }
  
  // Body text
  static TextStyle bodyLg() {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    );
  }
  
  static TextStyle body() {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }
  
  static TextStyle bodySm() {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
  }
  
  // ... các kiểu text khác
}
```

File `styles.dart` export `app_text_styles.dart` và `colors.dart`:

```dart
export 'app_text_styles.dart';
export 'colors/colors.dart';
```

## Themes

### Theme Configuration

File `app_theme.dart` quản lý cấu hình theme chính của ứng dụng:

```dart
class AppTheme {
  AppTheme._();
  
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    // ... các cấu hình khác
    extensions: [
      AppColorExtension.light,
      AppAssetExtension.light,
    ],
  );
  
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.black,
    // ... các cấu hình khác
    extensions: [
      AppColorExtension.dark,
      AppAssetExtension.dark,
    ],
  );
}
```

### Theme Extensions

#### Color Extension

File `app_color_extension.dart` định nghĩa các màu sắc theo theme:

```dart
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  final Color background;
  final Color surface;
  final Color text;
  final Color primaryText;
  // ... các màu khác

  const AppColorExtension({
    required this.background,
    required this.surface,
    required this.text,
    required this.primaryText,
    // ... các màu khác
  });

  static const light = AppColorExtension(
    background: AppColors.white,
    surface: AppColors.white,
    text: AppColors.black,
    primaryText: AppColors.primary,
    // ... các màu khác
  );

  static const dark = AppColorExtension(
    background: AppColors.black,
    surface: Color(0xFF121212),
    text: AppColors.white,
    primaryText: AppColors.primary,
    // ... các màu khác
  );

  @override
  ThemeExtension<AppColorExtension> copyWith({...}) {...}

  @override
  ThemeExtension<AppColorExtension> lerp(
      ThemeExtension<AppColorExtension>? other, double t) {...}
}
```

#### Asset Extension

File `app_asset_extension.dart` quản lý assets theo theme:

```dart
class AppAssetExtension extends ThemeExtension<AppAssetExtension> {
  final String logoPath;
  final String backgroundPath;
  // ... các asset khác

  const AppAssetExtension({
    required this.logoPath,
    required this.backgroundPath,
    // ... các asset khác
  });

  static const light = AppAssetExtension(
    logoPath: 'assets/images/logo_light.png',
    backgroundPath: 'assets/images/background_light.png',
    // ... các asset khác
  );

  static const dark = AppAssetExtension(
    logoPath: 'assets/images/logo_dark.png',
    backgroundPath: 'assets/images/background_dark.png',
    // ... các asset khác
  );

  @override
  ThemeExtension<AppAssetExtension> copyWith({...}) {...}

  @override
  ThemeExtension<AppAssetExtension> lerp(
      ThemeExtension<AppAssetExtension>? other, double t) {...}
}
```

## Cách sử dụng

### Sử dụng Colors

```dart
import 'package:ksk_app/core/styles/colors/app_colors.dart';
// hoặc
import 'package:ksk_app/core/styles/styles.dart';

Container(
  color: AppColors.primary,
  child: Text('Example'),
)
```

### Sử dụng Text Styles

```dart
import 'package:ksk_app/core/styles/app_text_styles.dart';
// hoặc
import 'package:ksk_app/core/styles/styles.dart';

Text(
  'Heading',
  style: AppTextStyle.headingLg(),
)
```

### Sử dụng Theme Extensions

```dart
import 'package:flutter/material.dart';
import 'package:ksk_app/core/themes/extensions/app_color_extension.dart';
import 'package:ksk_app/core/themes/extensions/app_asset_extension.dart';

// Trong widget
Widget build(BuildContext context) {
  final colors = Theme.of(context).extension<AppColorExtension>()!;
  final assets = Theme.of(context).extension<AppAssetExtension>()!;
  
  return Container(
    color: colors.background,
    child: Column(
      children: [
        Image.asset(assets.logoPath),
        Text(
          'Example',
          style: TextStyle(color: colors.text),
        ),
      ],
    ),
  );
}
```

### Kết hợp Text Styles với Theme Colors

```dart
Text(
  'Example',
  style: AppTextStyle.heading().copyWith(
    color: Theme.of(context).extension<AppColorExtension>()!.primaryText,
  ),
)
```

## Tại sao phân tách Styles và Themes?

1. **Tách biệt mối quan tâm**: Styles định nghĩa các giá trị cơ bản, trong khi Themes quản lý cách các giá trị đó được kết hợp lại
2. **Tái sử dụng**: Các style cơ bản có thể được sử dụng trực tiếp hoặc kết hợp vào themes
3. **Dễ bảo trì**: Khi cần thay đổi một giá trị, chỉ cần cập nhật tại một nơi
4. **Nhất quán**: Đảm bảo giao diện người dùng nhất quán trong toàn bộ ứng dụng 