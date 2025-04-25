import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksk_app/core/durations/app_durations.dart';
import 'package:ksk_app/core/sizes/app_sizes.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';
import 'package:ksk_app/core/styles/colors/app_colors.dart';
import 'package:ksk_app/generated/assets.gen.dart';
import 'package:mocktail/mocktail.dart';

/// A helper to pump widgets with necessary wrappers for testing
/// Wraps the given [child] with MaterialApp, StackRouter (if provided)
/// and other necessary providers
Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  StackRouter? stackRouter,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: stackRouter != null
          ? StackRouterScope(
              controller: stackRouter,
              stateHash: 0,
              child: child,
            )
          : Scaffold(body: child),
    ),
  );
}

/// A helper to pump and settle with a duration
Future<void> pumpAndSettleWithDuration(
  WidgetTester tester, [
  Duration duration = const Duration(milliseconds: 100),
]) async {
  await tester.pump(duration);
  await tester.pumpAndSettle();
}

/// Sets up the global GetIt dependency injector with common mocks
void setUpTestInjection() {
  GetIt.I.reset();

  final mockAppSizes = MockAppSizes();
  final mockAppColors = MockAppColors();
  final mockAppTextStyles = MockAppTextStyles();
  final mockAppDurations = MockAppDurations();

  GetIt.I.registerSingleton<AppSizes>(mockAppSizes);
  GetIt.I.registerSingleton<AppColors>(mockAppColors);
  GetIt.I.registerSingleton<AppTextStyles>(mockAppTextStyles);
  GetIt.I.registerSingleton<AppDurations>(mockAppDurations);
}

/// Tears down the global GetIt dependency injector
void tearDownTestInjection() {
  GetIt.I.reset();
}

// Common Mocks ---------------------------------------------------------

/// Mock for StackRouter used in navigation tests
class MockStackRouter extends Mock implements StackRouter {
  @override
  Future<T?> replace<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) {
    noSuchMethod(Invocation.method(#replace, [route], {#onFailure: onFailure}));
    return Future.value();
  }

  @override
  Future<T?> push<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) {
    noSuchMethod(Invocation.method(#push, [route], {#onFailure: onFailure}));
    return Future.value();
  }
}

/// Mock for AppSizes used in UI tests
class MockAppSizes extends Mock implements AppSizes {
  @override
  double get v256 => 256;
  @override
  double get v192 => 192;
  @override
  double get v128 => 128;
  @override
  double get v64 => 64;
  @override
  double get v56 => 56;
  @override
  double get v48 => 48;
  @override
  double get v40 => 40;
  @override
  double get v32 => 32;
  @override
  double get v24 => 24;
  @override
  double get v20 => 20;
  @override
  double get v16 => 16;
  @override
  double get v12 => 12;
  @override
  double get v8 => 8;
  @override
  double get v4 => 4;
  @override
  double get v2 => 2;
  @override
  double get v260 => 260;

  @override
  double get h256 => 256;
  @override
  double get h192 => 192;
  @override
  double get h128 => 128;
  @override
  double get h64 => 64;
  @override
  double get h40 => 40;
  @override
  double get h32 => 32;
  @override
  double get h24 => 24;
  @override
  double get h20 => 20;
  @override
  double get h16 => 16;
  @override
  double get h12 => 12;
  @override
  double get h8 => 8;
  @override
  double get h4 => 4;
  @override
  double get h2 => 2;
  @override
  double get h260 => 260;

  @override
  double get r256 => 256;
  @override
  double get r192 => 192;
  @override
  double get r128 => 128;
  @override
  double get r80 => 80;
  @override
  double get r64 => 64;
  @override
  double get r24 => 24;
  @override
  double get r20 => 20;
  @override
  double get r16 => 16;
  @override
  double get r12 => 12;
  @override
  double get r8 => 8;
  @override
  double get r4 => 4;
  @override
  double get r2 => 2;

  @override
  double get borderRadiusXs => 4;
  @override
  double get borderRadiusSm => 6;
  @override
  double get borderRadiusMd => 8;
  @override
  double get borderRadiusLg => 12;

  double get buttonHeight => 56;
}

/// Mock for AppColors used in UI tests
class MockAppColors extends Mock implements AppColors {
  // Helper method to create MaterialColors
  static MaterialColor createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.r.toInt();
    final g = color.g.toInt();
    final b = color.b.toInt();

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.toARGB32(), swatch);
  }

  @override
  MaterialColor get white => createMaterialColor(Colors.white);
  @override
  MaterialColor get black => createMaterialColor(Colors.black);
  @override
  MaterialColor get grey => Colors.grey;
  @override
  MaterialColor get onboardingBlue => Colors.blue;
  @override
  MaterialColor get primary => Colors.blue;
  @override
  Color get onboardingGradientStart => Colors.blue.shade200;
  @override
  Color get onboardingGradientEnd => Colors.blue.shade800;
  Color get error => Colors.red;
  @override
  Color get onboardingBackground => Colors.white;
  @override
  Color get transparent => Colors.transparent;
}

/// Mock for AppTextStyles used in UI tests
class MockAppTextStyles extends Mock implements AppTextStyles {
  @override
  TextStyle headingXl({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 28,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color,
      );

  @override
  TextStyle headingLg({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 24,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color,
      );

  TextStyle headingMd({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 20,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color,
      );

  @override
  TextStyle headingSm({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 18,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color,
      );

  @override
  TextStyle body({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
      );

  @override
  TextStyle bodySm({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
      );

  TextStyle bodyXs({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
      );

  TextStyle button({Color? color, FontWeight? fontWeight}) => TextStyle(
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color,
      );
}

/// Mock for AppDurations used in animation tests
class MockAppDurations extends Mock implements AppDurations {
  Duration get fast => const Duration(milliseconds: 300);
  @override
  Duration get medium => const Duration(milliseconds: 500);
  Duration get slow => const Duration(milliseconds: 700);
}

/// Mock for AssetGenImage used in tests with image resources
class MockAssetGenImage extends Mock implements AssetGenImage {
  MockAssetGenImage([this.assetPath = 'assets/images/test_image.png']);
  final String assetPath;

  @override
  String get path => assetPath;

  @override
  Image image({
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    AlignmentGeometry? alignment,
    AssetBundle? bundle,
    int? cacheHeight,
    int? cacheWidth,
    Rect? centerSlice,
    Color? color,
    BlendMode? colorBlendMode,
    bool? excludeFromSemantics,
    FilterQuality? filterQuality,
    ImageFrameBuilder? frameBuilder,
    bool? gaplessPlayback,
    bool? isAntiAlias,
    bool? matchTextDirection,
    Animation<double>? opacity,
    String? package,
    ImageRepeat? repeat,
    double? scale,
    String? semanticLabel,
  }) {
    return Image.asset(
      path,
      key: key,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: errorBuilder,
      alignment: alignment ?? Alignment.center,
      bundle: bundle,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      centerSlice: centerSlice,
      color: color,
      colorBlendMode: colorBlendMode,
      excludeFromSemantics: excludeFromSemantics ?? false,
      filterQuality: filterQuality ?? FilterQuality.low,
      frameBuilder: frameBuilder,
      gaplessPlayback: gaplessPlayback ?? false,
      isAntiAlias: isAntiAlias ?? false,
      matchTextDirection: matchTextDirection ?? false,
      opacity: opacity,
      package: package,
      repeat: repeat ?? ImageRepeat.noRepeat,
      scale: scale,
      semanticLabel: semanticLabel,
    );
  }

  @override
  String toString({DiagnosticLevel? minLevel}) => path;
}
