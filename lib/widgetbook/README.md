# Widgetbook

Widgetbook là một thư viện giúp trình diễn và kiểm thử các widget của Flutter. Thư mục này chứa tất cả mã nguồn liên quan đến Widgetbook cho dự án EIGA Movie App.

## Cấu trúc thư mục

```
widgetbook/
├── bootstrap.dart              # Application initialization similar to main app
├── main_development.dart       # Entry point for development environment
├── main_staging.dart           # Entry point for staging environment
├── main_production.dart        # Entry point for production environment
├── app.dart                    # WidgetbookApp component
├── directories.dart            # Tổng hợp tất cả WidgetbookComponent
├── README.md                   # Tài liệu hướng dẫn (file này)
├── components/                 # Chứa các component được tổ chức theo feature
│   ├── onboarding/
│   │   ├── onboarding_component.dart
│   │   └── dot_indicator_component.dart
│   ├── login/
│   │   ├── login_page_component.dart
│   │   └── login_view_component.dart
│   └── shared/
│       └── responsive_initializer_component.dart
└── addons/
    └── material_theme_addon.dart
```

## Addons được sử dụng

Widgetbook hiện tại sử dụng các addon sau để nâng cao trải nghiệm kiểm thử và trình diễn:

- **MaterialThemeAddon**: Cho phép chuyển đổi giữa light/dark theme.
- **TextScaleAddon**: Thay đổi tỉ lệ chữ để kiểm thử khả năng thích ứng của UI với các kích thước chữ khác nhau.
- **DeviceFrameAddon**: Xem trước widget trên nhiều loại thiết bị phổ biến (iPhone SE, iPhone 12, iPhone 13, Samsung Galaxy S20, Note20 Ultra, ...).
- **ScreenUtil (BuilderAddon)**: Khởi tạo ScreenUtil để kiểm thử responsive layout, đảm bảo các widget hiển thị đúng trên nhiều kích thước màn hình khác nhau.

### Ví dụ cấu hình addons trong app.dart:

```dart
addons: [
  getMaterialThemeAddon(),
  TextScaleAddon(),
  DeviceFrameAddon(
    devices: [
      Devices.ios.iPhoneSE,
      Devices.ios.iPhone12,
      Devices.ios.iPhone13,
      Devices.android.samsungGalaxyS20,
      Devices.android.samsungGalaxyNote20Ultra,
    ],
  ),
  BuilderAddon(
    name: 'ScreenUtil',
    builder: (context, child) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) => child!,
        child: child,
      );
    },
  ),
],
```

## Cách chạy

Để chạy widgetbook cho các môi trường khác nhau:

```bash
# Development
flutter run -t lib/widgetbook/main_development.dart

# Staging
flutter run -t lib/widgetbook/main_staging.dart

# Production
flutter run -t lib/widgetbook/main_production.dart
```

## Kiến trúc

Widgetbook được thiết kế để phản ánh cấu trúc của ứng dụng chính:

1. **bootstrap.dart**
   - Khởi tạo ứng dụng, cấu hình xử lý lỗi và observer bloc
   - Cấu hình dependency injection (DI)
   - Tương tự như bootstrap.dart của ứng dụng chính

2. **app.dart**
   - Định nghĩa WidgetbookApp với ResponsiveInitializer
   - Tổ chức UI theo cùng một pattern như ứng dụng chính

3. **Môi trường**
   - Các môi trường (`development`, `staging`, `production`) được tách biệt 
   - Mỗi môi trường có entry point riêng (main_*.dart)

## Thêm component mới

Để thêm một component mới vào widgetbook:

1. Tạo file mới trong thư mục components/ theo cấu trúc feature-first
2. Tạo hàm trả về WidgetbookComponent với các WidgetbookUseCase tương ứng
3. Import và thêm component vào danh sách trong file directories.dart

Ví dụ:

```dart
// lib/widgetbook/components/myfeature/my_component.dart
import 'package:flutter/material.dart';
import 'package:ksk_app/features/myfeature/presentation/my_component.dart';
import 'package:widgetbook/widgetbook.dart';

/// Returns a WidgetbookComponent for MyComponent
WidgetbookComponent getMyComponent() {
  return WidgetbookComponent(
    name: 'MyComponent',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => const MyComponent(),
      ),
      // Thêm nhiều use case khác nếu cần
    ],
  );
}
```

Sau đó, thêm component vào directories.dart:

```dart
// lib/widgetbook/directories.dart
import 'components/myfeature/my_component.dart';

final List<WidgetbookComponent> directories = [
  // Các components đã có
  // ...
  
  // Thêm component mới
  getMyComponent(),
];
```

## Độ phức tạp của use case

Mỗi use case có thể đơn giản chỉ hiển thị component hoặc phức tạp hơn với các tham số khác nhau:

```dart
WidgetbookUseCase(
  name: 'Custom',
  builder: (context) => MyComponent(
    title: 'Custom title',
    color: Colors.blue,
    onPressed: () {},
  ),
),
```

## Knobs (Điều khiển động)

Để thêm các knob cho phép điều chỉnh tham số của widget một cách động, sử dụng context.knobs:

```dart
WidgetbookUseCase(
  name: 'Customizable',
  builder: (context) => MyComponent(
    title: context.knobs.string(
      label: 'Title',
      initialValue: 'Default title',
    ),
    enabled: context.knobs.boolean(
      label: 'Enabled',
      initialValue: true,
    ),
  ),
),
``` 