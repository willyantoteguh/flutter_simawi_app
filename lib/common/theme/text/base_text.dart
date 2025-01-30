import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color/color_name.dart';

class BaseText {
  const BaseText();

  static TextStyle mainTextStyle = const TextStyle(
    fontFamily: "Lexend",
    color: ColorName.mainColor,
  );

  static TextStyle subTextStyle = const TextStyle(
    fontFamily: "Lexend",
    color: ColorName.main2Color,
  );

  static TextStyle blackTextStyle = const TextStyle(
    fontFamily: "Lexend",
    color: ColorName.blackColor,
  );
  static TextStyle whiteTextStyle = const TextStyle(
    fontFamily: "Lexend",
    color: ColorName.whiteColor,
  );

  static TextStyle grey1TextStyle = const TextStyle(
    fontFamily: "Lexend",
    color: ColorName.grey1Color,
  );

  // Main Text
  static TextStyle mainText12 = mainTextStyle.copyWith(fontSize: 12.sp);
  static TextStyle mainText13 = mainTextStyle.copyWith(fontSize: 13.sp);
  static TextStyle mainText14 = mainTextStyle.copyWith(fontSize: 14.sp);
  static TextStyle mainText16 = mainTextStyle.copyWith(fontSize: 16);
  static TextStyle mainText18 = mainTextStyle.copyWith(fontSize: 18.sp);
  static TextStyle mainText20 = mainTextStyle.copyWith(fontSize: 20.sp);
  static TextStyle mainText24 = mainTextStyle.copyWith(fontSize: 24.sp);

  // Sub Text
  static TextStyle subText12 = subTextStyle.copyWith(fontSize: 12.sp);
  static TextStyle subText14 = subTextStyle.copyWith(fontSize: 14.sp);
  static TextStyle subText16 = subTextStyle.copyWith(fontSize: 16.sp);

  // Grey Text 1
  static TextStyle grey1Text11 = grey1TextStyle.copyWith(fontSize: 11.sp);
  static TextStyle grey1Text12 = grey1TextStyle.copyWith(fontSize: 12.sp);
  static TextStyle grey1Text13 = grey1TextStyle.copyWith(fontSize: 13.sp);
  static TextStyle grey1Text14 = grey1TextStyle.copyWith(fontSize: 14.sp);
  static TextStyle grey1Text15 = grey1TextStyle.copyWith(fontSize: 15.sp);

  static TextStyle blackText11 = blackTextStyle.copyWith(fontSize: 11);
  static TextStyle blackText12 = blackTextStyle.copyWith(fontSize: 12);
  static TextStyle blackText14 = blackTextStyle.copyWith(fontSize: 14.sp);
  static TextStyle blackText15 = blackTextStyle.copyWith(fontSize: 15.sp);
  static TextStyle blackText16 = blackTextStyle.copyWith(fontSize: 16.sp);
  static TextStyle blackText18 = blackTextStyle.copyWith(fontSize: 18.sp);
  static TextStyle blackText24 = blackTextStyle.copyWith(fontSize: 24.sp);

  static TextStyle whiteText14 = whiteTextStyle.copyWith(fontSize: 14.sp);

  // Font Weight
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}
