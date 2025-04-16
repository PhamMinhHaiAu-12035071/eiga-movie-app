import 'package:flutter/material.dart';

/// Defines standard text style contracts for the application
abstract class AppTextStyles {
  TextStyle heading3Xl({Color? color, FontWeight? fontWeight});
  TextStyle heading2Xl({Color? color, FontWeight? fontWeight});
  TextStyle headingXl({Color? color, FontWeight? fontWeight});
  TextStyle headingLg({Color? color, FontWeight? fontWeight});
  TextStyle heading({Color? color, FontWeight? fontWeight});
  TextStyle headingSm({Color? color, FontWeight? fontWeight});
  TextStyle headingXs({Color? color, FontWeight? fontWeight});
  TextStyle bodyLg({Color? color, FontWeight? fontWeight});
  TextStyle body({Color? color, FontWeight? fontWeight});
  TextStyle bodySm({Color? color, FontWeight? fontWeight});
}
