---
sidebar_position: 2
title: FlutterGen
description: Quản lý assets an toàn với FlutterGen
---

# FlutterGen

FlutterGen là một công cụ code generation giúp quản lý assets (hình ảnh, màu sắc, phông chữ) một cách an toàn với type-safe trong Flutter.

## Cấu hình trong dự án

FlutterGen đã được cấu hình trong dự án KSK App với các thiết lập sau:

```yaml
flutter_gen:
  output: lib/generated/
  line_length: 80

  integrations:
    flutter_svg: true
    flare_flutter: false
    rive: false
    lottie: false

  colors:
    inputs:
      - assets/colors/colors.xml
```

## Cách sử dụng

### Chạy FlutterGen

Để tạo các file code tự động từ assets, sử dụng lệnh:

```bash
make gen-assets
```

Hoặc chạy trực tiếp:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Sử dụng trong code

#### Hình ảnh

Sau khi chạy code generation, bạn có thể truy cập hình ảnh thông qua class `Assets` được tạo tự động:

```dart
import 'package:ksk_app/generated/assets.gen.dart';

// Sử dụng hình ảnh
Image(image: Assets.images.logo.provider())

// Hoặc với widget có sẵn
Assets.images.logo.image()

// Truy cập đường dẫn
final String logoPath = Assets.images.logo.path;
```

#### Màu sắc

Nếu bạn đã định nghĩa màu sắc trong `assets/colors/colors.xml`, bạn có thể truy cập chúng như sau:

```dart
import 'package:ksk_app/generated/colors.gen.dart';

// Sử dụng màu
Container(
  color: ColorName.primary,
  child: Text('Example'),
)
```

## Thêm mới assets

### Hình ảnh

1. Thêm hình ảnh vào thư mục `assets/images/`
2. Đảm bảo đường dẫn đã được đăng ký trong `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/images/
   ```
3. Chạy lệnh `make gen-assets` để cập nhật code

### Màu sắc

1. Định nghĩa màu sắc trong file `assets/colors/colors.xml`:
   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <resources>
     <color name="primary">#2196F3</color>
     <color name="secondary">#FF9800</color>
     <color name="background">#FFFFFF</color>
   </resources>
   ```
2. Chạy lệnh `make gen-assets` để cập nhật code

## Ưu điểm

- **Type Safe**: Truy cập assets với kiểm tra kiểu tại thời gian biên dịch
- **Tự động hoàn thành**: IDE tự động gợi ý assets có sẵn
- **Ngăn ngừa lỗi**: Phát hiện sớm các lỗi như tên file không đúng, đường dẫn không tồn tại
- **Quản lý phiên bản**: Assets thay đổi sẽ được cập nhật trong mã nguồn đã tạo

## Lưu ý

- Luôn chạy `make gen-assets` sau khi thêm hoặc sửa đổi assets
- Không chỉnh sửa trực tiếp các file trong thư mục `lib/generated/`
- Tên file nên tuân theo quy tắc snake_case để có tên biến tốt trong code được tạo 