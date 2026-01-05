import 'package:flutter/material.dart';

class TextStyleTheme {
  static TextStyle customTextStyle(
    { Color? color,
    double? size,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    String? fontFamily,
    double spacing = 0.0,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? "Urbanist",
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
      decoration: decoration ?? TextDecoration.none,
      letterSpacing: spacing,
    );
  }
}
