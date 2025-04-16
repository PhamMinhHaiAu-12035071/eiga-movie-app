import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/asset/app_image.dart';
import 'package:ksk_app/core/themes/extensions/app_asset_extension.dart';
import 'package:mocktail/mocktail.dart';

class MockAppImage extends Mock implements AppImage {}

void main() {
  group('AppAssetExtension', () {
    test('constructor assigns appImage', () {
      final mockImage = MockAppImage();
      final ext = AppAssetExtension(appImage: mockImage);
      expect(ext.appImage, mockImage);
    });

    test('dark() returns correct instance', () {
      final ext = AppAssetExtension.dark();
      expect(ext, isA<AppAssetExtension>());
      expect(ext.appImage, isNotNull);
    });

    test('light() returns correct instance', () {
      final ext = AppAssetExtension.light();
      expect(ext, isA<AppAssetExtension>());
      expect(ext.appImage, isNotNull);
    });

    test('copyWith returns new instance with updated appImage', () {
      final mockImage1 = MockAppImage();
      final mockImage2 = MockAppImage();
      final ext = AppAssetExtension(appImage: mockImage1);
      final copy = ext.copyWith(appImage: mockImage2) as AppAssetExtension;
      expect(copy.appImage, mockImage2);
      expect(copy, isNot(same(ext)));
    });

    test('copyWith returns same values if no params', () {
      final mockImage = MockAppImage();
      final ext = AppAssetExtension(appImage: mockImage);
      final copy = ext.copyWith() as AppAssetExtension;
      expect(copy.appImage, mockImage);
    });

    test('lerp returns this if other is not AppAssetExtension', () {
      final mockImage = MockAppImage();
      final ext = AppAssetExtension(appImage: mockImage);
      final result = ext.lerp(null, 0.5);
      expect(result, ext);
    });

    test('lerp returns this if other is AppAssetExtension (no lerp logic)', () {
      final mockImage = MockAppImage();
      final ext = AppAssetExtension(appImage: mockImage);
      final other = AppAssetExtension(appImage: mockImage);
      final result = ext.lerp(other, 0.5);
      expect(result, ext);
    });
  });
}
