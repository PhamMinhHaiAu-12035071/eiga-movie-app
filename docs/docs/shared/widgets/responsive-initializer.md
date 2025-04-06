---
sidebar_position: 1
title: ResponsiveInitializer
description: Widget quản lý responsive UI trong KSK App
---

# ResponsiveInitializer

`ResponsiveInitializer` là một widget dùng để khởi tạo responsive design cho ứng dụng bằng cách sử dụng `flutter_screenutil`. Widget này đảm bảo UI của ứng dụng có thể thích ứng với các kích thước màn hình khác nhau.

## Vị trí trong dự án

```
lib/
└── shared/
    └── widgets/
        └── responsive_initializer.dart
```

## Mô tả

Widget này sử dụng thư viện `flutter_screenutil` để quản lý việc scale UI trên nhiều kích thước màn hình khác nhau. Nó giúp đảm bảo các phần tử UI như text, container, padding, margin, v.v. được hiển thị với kích thước phù hợp trên mọi thiết bị.

`ResponsiveInitializer` hoạt động bằng cách:
1. Bao bọc `MediaQuery` và `LayoutBuilder` để lấy thông tin về kích thước màn hình
2. Khởi tạo `ScreenUtil` với kích thước thiết kế được cung cấp hoặc kích thước hiện tại của layout
3. Trả về widget con được xây dựng từ hàm `builder`

## Properties

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `builder` | `Widget Function(BuildContext context)` | Yes | Hàm xây dựng widget con sau khi ScreenUtil đã được khởi tạo |
| `designSize` | `Size?` | No | Kích thước thiết kế tham chiếu (thường là kích thước của thiết bị được sử dụng khi thiết kế UI) |

## Cách sử dụng

```dart
import 'package:ksk_app/shared/widgets/responsive_initializer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveInitializer(
      // Kích thước thiết kế (design size) - thường là kích thước
      // của thiết bị được sử dụng khi thiết kế UI trong Figma/Adobe XD
      designSize: const Size(375, 812), // iPhone X dimensions
      
      builder: (context) {
        return MaterialApp(
          title: 'KSK App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
```

## Sử dụng ScreenUtil để làm Responsive UI

Sau khi đã khởi tạo `ResponsiveInitializer`, bạn có thể sử dụng các extension của `flutter_screenutil` để tạo responsive UI:

```dart
Container(
  // Responsive width và height
  width: 200.w, // 200 logical pixels trên thiết kế gốc
  height: 100.h, // 100 logical pixels trên thiết kế gốc
  
  child: Text(
    'Responsive Text',
    style: TextStyle(
      fontSize: 16.sp, // Responsive font size
    ),
  ),
)
```

### Các extension cơ bản:

| Extension | Mô tả |
|-----------|-------|
| `.w` | Responsive width |
| `.h` | Responsive height |
| `.r` | Responsive radius (dùng cho border radius, padding, margin) |
| `.sp` | Responsive font size |
| `.sw` | Tỷ lệ chiều rộng màn hình (1.sw = 100% chiều rộng màn hình) |
| `.sh` | Tỷ lệ chiều cao màn hình (1.sh = 100% chiều cao màn hình) |

## Lưu ý

- Nên đặt `ResponsiveInitializer` ở đầu cây widget (phổ biến nhất là trong `main.dart` hoặc widget root) để đảm bảo toàn bộ ứng dụng đều responsive
- Nếu không cung cấp `designSize`, kích thước hiện tại của layout sẽ được sử dụng
- Đảm bảo không sử dụng `ResponsiveInitializer` nhiều lần trong cùng một cây widget, vì điều này có thể dẫn đến việc khởi tạo `ScreenUtil` nhiều lần

## Mã nguồn

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A widget that initializes responsive scaling for its child widget.
///
/// This widget uses [ScreenUtil] to enable responsive scaling based on
/// the screen size or a provided design size. It handles the initialization
/// of screen metrics to ensure consistent UI across different device sizes.
///
/// Usage:
/// ```dart
/// ResponsiveInitializer(
///   builder: (context) => YourWidget(),
///   designSize: const Size(375, 812), // Optional design size (iPhone X dimensions)
/// )
/// ```
class ResponsiveInitializer extends StatelessWidget {
  /// Creates a ResponsiveInitializer widget.
  ///
  /// The [builder] parameter is required and is used to build the child widget
  /// after responsive scaling has been initialized.
  ///
  /// The optional [designSize] parameter specifies the reference design size.
  /// If not provided, the current constraints of the layout will be used.
  const ResponsiveInitializer({
    required this.builder,
    super.key,
    this.designSize,
  });

  /// Function to build the child widget after initialization.
  final Widget Function(BuildContext context) builder;

  /// Optional design size reference for responsive scaling.
  final Size? designSize;

  @override
  Widget build(BuildContext context) => MediaQuery(
        data: MediaQueryData.fromView(View.of(context)),
        child: LayoutBuilder(
          builder: (_, constraints) {
            if (constraints.maxWidth != 0) {
              // Initialize ScreenUtil with the current constraints or provided design size
              ScreenUtil.init(
                _,
                designSize: Size(
                  designSize?.width ?? constraints.maxWidth,
                  designSize?.height ?? constraints.maxHeight,
                ),
              );

              return builder(context);
            }

            // Return an empty container if constraints are not valid
            return const SizedBox.shrink();
          },
        ),
      );
} 