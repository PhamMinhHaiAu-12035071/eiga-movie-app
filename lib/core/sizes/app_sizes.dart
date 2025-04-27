/// Defines standard size constants for consistent spacing
/// and dimensions across the application.
///
/// This abstract class allows for dependency injection and mocking in tests.
abstract class AppSizes {
  // Regular dimensions
  // r: Responsive size for both width and height
  // v: Responsive height
  // h: Responsive width

  // 2 pixel variations
  double get r2;
  double get v2;
  double get h2;

  // 4 pixel variations
  double get r4;
  double get v4;
  double get h4;

  // 8 pixel variations
  double get r8;
  double get v8;
  double get h8;

  // 12 pixel variations
  double get r12;
  double get v12;
  double get h12;

  // 14 pixel variations
  double get r14;
  double get v14;
  double get h14;

  // 16 pixel variations
  double get r16;
  double get v16;
  double get h16;

  // 20 pixel variations
  double get r20;
  double get v20;
  double get h20;

  // 24 pixel variations
  double get r24;
  double get v24;
  double get h24;

  // 32 pixel variations
  double get r32;
  double get v32;
  double get h32;

  // 40 pixel variations
  double get r40;
  double get v40;
  double get h40;

  // 48 pixel variations
  double get r48;
  double get v48;
  double get h48;

  // 56 pixel variations
  double get r56;
  double get v56;
  double get h56;

  // 64 pixel variations
  double get r64;
  double get v64;
  double get h64;

  // 80 pixel variations
  double get r80;
  double get v80;
  double get h80;

  // 128 pixel variations
  double get r128;
  double get v128;
  double get h128;

  // 192 pixel variations
  double get r192;
  double get v192;
  double get h192;

  // 256 pixel variations
  double get r256;
  double get v256;
  double get h256;

  // 260 pixel variations (specific for onboarding image size)
  double get r260;
  double get v260;
  double get h260;

  // Border radius dimensions
  // xs: Extra small border radius
  double get borderRadiusXs;

  // sm: Small border radius
  double get borderRadiusSm;

  // md: Medium border radius
  double get borderRadiusMd;

  // lg: Large border radius
  double get borderRadiusLg;
}
