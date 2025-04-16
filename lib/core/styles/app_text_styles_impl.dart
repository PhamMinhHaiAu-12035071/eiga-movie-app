import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:ksk_app/core/styles/app_text_styles.dart';

/// Implementation of AppTextStyles for the application
@LazySingleton(as: AppTextStyles)
class AppTextStylesImpl implements AppTextStyles {
  const AppTextStylesImpl();

  TextStyle _base({
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

  @override
  TextStyle heading3Xl({Color? color, FontWeight? fontWeight}) => _base(
        fontSize: 36,
        fontWeight: fontWeight ?? FontWeight.w700,
        height: 1.2,
        color: color,
      );

  @override
  TextStyle heading2Xl({Color? color, FontWeight? fontWeight}) => _base(
        fontSize: 30,
        fontWeight: fontWeight ?? FontWeight.w700,
        height: 1.2,
        color: color,
      );

  @override
  TextStyle headingXl({Color? color, FontWeight? fontWeight}) => _base(
        fontSize: 24,
        fontWeight: fontWeight ?? FontWeight.w700,
        height: 1.3,
        color: color,
      );

  @override
  TextStyle headingLg({Color? color, FontWeight? fontWeight}) => _base(
        fontSize: 20,
        fontWeight: fontWeight ?? FontWeight.w700,
        height: 1.3,
        color: color,
      );

  @override
  TextStyle heading({Color? color, FontWeight? fontWeight}) => _base(
        fontSize: 18,
        fontWeight: fontWeight ?? FontWeight.w600,
        height: 1.4,
        color: color,
      );

  @override
  TextStyle headingSm({Color? color, FontWeight? fontWeight}) => _base(
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w600,
        height: 1.4,
        color: color,
      );

  @override
  TextStyle headingXs({Color? color, FontWeight? fontWeight}) => _base(
        fontWeight: fontWeight ?? FontWeight.w600,
        height: 1.4,
        color: color,
      );

  @override
  TextStyle bodyLg({Color? color, FontWeight? fontWeight}) => _base(
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.5,
        color: color,
      );

  @override
  TextStyle body({Color? color, FontWeight? fontWeight}) => _base(
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.5,
        color: color,
      );

  @override
  TextStyle bodySm({Color? color, FontWeight? fontWeight}) => _base(
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.5,
        color: color,
      );
}
