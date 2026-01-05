import 'package:flutter/material.dart';

ValueNotifier<bool> isLightThemeMode = ValueNotifier(false);

///CommonColors
class AppCommonColors {
  static const Color background = Color(0xffe8e8e8);
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color dividerColor = Color(0xffF1F3F5);
  static const Color lightGrey = Color(0xffe8e8e8);
  static const Color cream = Color(0xffFBF1DC);
  static const Color yellow = Color(0xffF1CD52);
  static const Color green = Color(0xff61A16C);
  static const Color orange = Color(0xffE99942);
  static Color primary70Opacity = const Color(0xff117472).withOpacity(0.7);
  static const Color darkCream = Color(0xffD69278);
  // static Color primary70Opacity = const Color(0xff117472).withOpacity(0.7);
}

///TextColors
class AppTextColors {
  static const Color red = Colors.red;
  static const Color primaryTextColor = Color(0xff117472);
  static const Color transparent = Color(0x00000000);
  static const Color black = Color(0xff000000);
  static const Color lightBlack = Color(0xff505050);
  static const Color grey = Color(0xff838181);
  static const Color newGrey = Color(0xffC1BDB6);
  static const Color hintGrey = Color(0xff7D7D7D);
  static const Color listTitleGrey = Color(0xff747577);
  static const Color textWhite = Color(0xffFFFFFF);
  static const Color green = Color(0xff61A16C);
  static const Color darkThemeTextColor = Color(0xff252525);
  static const Color midTextGrey = Color(0xff5A5A5A);
  static const Color greyText = Color(0xff5A5A5A);
  static const Color textLightGrey = Color(0xff736D69);
  static const Color orange = Color(0xffE99942);
  // static const Color lightRed = Color(0xffEF866A);
  static Color primary70Opacity = const Color(0xff117472).withOpacity(0.7);
  static const Color newBgPrimaryColor = Color(0xffFBF1DC);

  static const Color cream = Color(0xffFCF1EB);
  static const Color darkCream = Color(0xffD69278);
  static const Color textGrey = Color(0xffAEA6A0);
  static const Color lightOrange = Color(0xffF26540);
  static const Color lightGrey = Color(0xffE0E0E0);
  static const Color white = Color(0xffFFFFFF);
}

///BackgroundColors
class AppBgColors {
  static const Color darkBackground = Color(0xff252525);
  static const Color newBgPrimaryColor = Color(0xffFBF1DC);
  static const Color newBgSecondaryColor = Color(0xffFAF5E8);
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color lightBlack = Color(0xff7A5A5036);
  static const Color blueGrey = Color(0xffEDEFF2);
  static const Color blueGreyDark = Color(0xffD8D9DD);
  static const Color lightBlueGrey = Color(0xffF9F9FB);
  static const Color lightGreenGrey = Color(0xffF4F8EF);
  static const Color cream = Color(0xffFCF1EB);
  static const Color darkCream = Color(0xffD69278);
  static const Color orange = Color(0xffE99942);
  static const Color lightRed = Color(0xffEF866A);
  static const Color lightOrange = Color(0xffFFDE89);
  static const Color green = Color(0xff61A16C);
  static const Color grey = Color(0xff838181);
  static const Color lightGrey = Color(0xffAEA6A0);
  static const Color background = Color(0xffFAF5E8);
  static Color primary70Opacity = const Color(0xff117472).withOpacity(0.7);
  // static const Color background = Color(0xffefefef);
}

///IconColors
class AppIconColors {
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color darkGrey = Color(0xff9A928C);
  static const Color darkCream = Color(0xffFFB8A1);
  static const Color lightGrey = Color(0xffAEA6A0);
  static const Color midWhite = Color(0xffF3EFEB);
  static const Color orange = Color(0xffE99942);
  // static const Color lightRed = Color(0xffEF866A);
  static Color primary70Opacity = const Color(0xff117472).withOpacity(0.7);
  static const Color suffixIconGrey = Color(0xffABABAB);
  static const Color grey = Color(0xffAEA6A0);
}

///BorderColors
class AppBorderColors {
  // static const Color primary70Opacity = Colors.red;
  static const Color red = Colors.red;
  static Color primary70Opacity = const Color(0xff117472).withOpacity(0.7);

  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color grey = Color(0xffAEA6A0);
  static const Color lightGrey = Color(0xff595959);
  static const Color darkGrey = Color(0xff9A928C);
  // static const Color darkCream = Color(0xffFFB8A1);
  static Color darkCream = primary70Opacity;
  static const Color orange = Color(0xffE99942);
  static const Color lightRed = Color(0xffEF866A);
}

///ButtonColors
class AppButtonColors {
  static const Color background = Color(0xffF3EFEB);
  static const Color primaryBtnColor = Color(0xff117472);
  static Color primaryBtn70Opacity = const Color(0xff117472).withOpacity(0.7);
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color grey = Color(0xff727272);
  static const Color lightGrey = Color(0xffb0b0b0);
  // static const Color green = Color(0xff61A16C);
  static Color green = primaryBtnColor;
  static const Color darkCream = Color(0xffD69278);
  static const Color orange = Color(0xffE99942);
  static const Color lightRed = Color(0xffEF866A);
}
