import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/ConstantStrings.dart';

class AppYellowButton extends StatelessWidget {
  double? height;
  double? width;
  Color color;
  String text;
  double borderWidth;
  Color borderColor;
  double borderRadius;
  double fontSize;
  Color? textColor;
  AppYellowButton({Key? key,this.height,this.width,required this.color,
    required this.text,required this.borderWidth,required this.borderColor
  ,required this.borderRadius,required this.fontSize,this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: Get.height*height!,
      width: Get.width*width!,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          color: color,
        border:  Border.all(
            width: borderWidth,
            color: borderColor),),
      child:  Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: Get.height*0.022,
                fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                fontWeight: FontWeight.w600),
          )),
    );
  }
}
