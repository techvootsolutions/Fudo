import 'package:flutter/material.dart';
import 'package:fudo/src/core/utils/Style/colors.dart';

final lightThemeData = ThemeData(
  useMaterial3: false,
  colorScheme: ColorScheme.light(
    primary: AppBgColors.white,
    onPrimary: AppBgColors.darkCream,
    secondary: AppBgColors.cream,
    onSecondary: AppBgColors.cream,
    surface: AppBgColors.white,
  ),
);

final darkThemeData = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.dark(
      primary: AppBgColors.black,
      onPrimary: Colors.black,
      secondary: AppBgColors.black,
      onSecondary: AppBgColors.lightGrey,
      surface: AppBgColors.white,
    ));
