# Widgetbook

Widgetbook là một thư viện giúp trình diễn và kiểm thử các widget của Flutter. Thư mục này chứa tất cả mã nguồn liên quan đến Widgetbook cho dự án EIGA Movie App.

## Cấu trúc thư mục

```
widgetbook/
├── main.dart                  # Entry point (điểm khởi chạy)
├── app.dart                   # WidgetbookApp component
├── directories.dart           # Tổng hợp tất cả WidgetbookComponent
├── README.md                  # Tài liệu hướng dẫn (file này)
├── components/                # Chứa các component được tổ chức theo feature
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

## Cách chạy

Để chạy widgetbook:

```bash
flutter run -t lib/widgetbook/main.dart
```

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