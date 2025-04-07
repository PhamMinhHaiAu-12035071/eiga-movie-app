import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

/// Định nghĩa các kiểu văn bản trong ứng dụng
class AppTextStyle {
  const AppTextStyle._();

  static TextStyle _base({
    double fontSize = 14,
    FontWeight? fontWeight = FontWeight.w400,
    Color? color,
    TextDecoration? decoration,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
  }) =>
      GoogleFonts.montserrat(
        fontSize: fontSize * 1.sp,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        height: height,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
      );

  // Heading Styles
  static TextStyle heading3Xl({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontSize: 36,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: 1.2,
      color: color,
    );
  }

  static TextStyle heading2Xl({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontSize: 30,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: 1.2,
      color: color,
    );
  }

  static TextStyle headingXl({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontSize: 24,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle headingLg({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontSize: 20,
      fontWeight: fontWeight ?? FontWeight.w700,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle heading({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontSize: 18,
      fontWeight: fontWeight ?? FontWeight.w600,
      height: 1.4,
      color: color,
    );
  }

  static TextStyle headingSm({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontSize: 16,
      fontWeight: fontWeight ?? FontWeight.w600,
      height: 1.4,
      color: color,
    );
  }

  static TextStyle headingXs({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontWeight: fontWeight ?? FontWeight.w600,
      height: 1.4,
      color: color,
    );
  }

  // Body Styles
  static TextStyle bodyLg({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontSize: 16,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: 1.5,
      color: color,
    );
  }

  static TextStyle body({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontWeight: fontWeight ?? FontWeight.w400,
      height: 1.5,
      color: color,
    );
  }

  static TextStyle bodySm({Color? color, FontWeight? fontWeight}) {
    return _base(
      fontSize: 12,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: 1.5,
      color: color,
    );
  }
}
