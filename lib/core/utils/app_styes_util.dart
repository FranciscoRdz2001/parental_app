import 'package:flutter/material.dart';

class AppStyles {
  static const String fontFamily = 'Poppins';

  static TextStyle _defaultStyle(
    FontWeight fontWeight,
    double size, [
    Color? color,
  ]) {
    return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
    );
  }

  static TextStyle w400(double size, [Color? color]) {
    return _defaultStyle(FontWeight.w400, size, color);
  }

  static TextStyle w500(double size, [Color? color]) {
    return _defaultStyle(FontWeight.w500, size, color);
  }

  static TextStyle w600(double size, [Color? color]) {
    return _defaultStyle(FontWeight.w600, size, color);
  }

  static TextStyle w700(double size, [Color? color]) {
    return _defaultStyle(FontWeight.w700, size, color);
  }

  static TextStyle w800(double size, [Color? color]) {
    return _defaultStyle(FontWeight.w800, size, color);
  }

  static TextStyle w900(double size, [Color? color]) {
    return _defaultStyle(FontWeight.w900, size, color);
  }
}
