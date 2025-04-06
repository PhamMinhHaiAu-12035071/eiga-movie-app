---
sidebar_position: 0
title: Tổng quan
description: Giới thiệu về các Shared Widgets trong KSK App
---

# Shared Widgets

Các widget dùng chung là những component UI có thể tái sử dụng trong toàn bộ ứng dụng, không phụ thuộc vào bất kỳ feature cụ thể nào.

## Vị trí trong dự án

Theo cấu trúc Clean Architecture, các shared widgets được đặt trong thư mục:

```
lib/
└── shared/
    └── widgets/
        └── [widget_name].dart
```

## Danh sách Shared Widgets

### UI Components

- [ResponsiveInitializer](./responsive-initializer.md) - Widget khởi tạo responsive UI cho ứng dụng

## Nguyên tắc thiết kế Shared Widgets

Khi phát triển các shared widgets, cần tuân thủ các nguyên tắc sau:

1. **Tính độc lập**: Widget không nên phụ thuộc vào các feature cụ thể trong ứng dụng
2. **Tái sử dụng**: Widget có thể được sử dụng ở nhiều nơi trong ứng dụng
3. **Đóng gói**: Widget nên đóng gói chức năng cụ thể và có trách nhiệm rõ ràng
4. **Kế thừa**: Ưu tiên sử dụng composition thay vì inheritance
5. **Tham số hóa**: Widget nên cung cấp các tham số để tùy chỉnh hành vi và giao diện

## Cách thêm một Shared Widget mới

1. Tạo file mới trong thư mục `lib/shared/widgets/`
2. Đặt tên file theo snake_case và tên widget theo PascalCase
3. Đảm bảo widget có documentation đầy đủ (docstring, comments)
4. Bổ sung test case cho widget nếu cần
5. Cập nhật tài liệu trong thư mục `docs/docs/shared/widgets/` 