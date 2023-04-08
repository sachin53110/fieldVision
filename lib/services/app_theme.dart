import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    primaryColor: Colors.white,

    buttonColor: AppColors.backArrowColor,

  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor:AppColors.darkBackgroundColor,
    primaryColor: Colors.black,
    buttonColor: AppColors.darkBackButtonColor,

  );
}