import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> toastMessage(String error){
  return  Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.appYellowColor,
      textColor: Colors.black,
      fontSize: 16.0
  );
}