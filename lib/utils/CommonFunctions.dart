import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonFunctions {
  static Color getThemeColor({required Color light, required Color dark}) {
    if (Get.isDarkMode) {
      return dark;
    } else {
      return light;
    }
  }
}
