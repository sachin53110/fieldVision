import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Constants/ColorConstant.dart';

class AppText extends StatelessWidget {
  String text;
  Color? color;
  double height;
  FontWeight fontWeight;
  String? fontFamily;
  TextAlign? textAlign;
  AppText({Key? key,required this.text,this.color,required this.height,required this.fontWeight,this.textAlign
  ,this.fontFamily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: fontFamily
        ,fontWeight: fontWeight,
        fontSize: Get.height*height,
        color: color,
    ),
    );
  }
}
