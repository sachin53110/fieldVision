import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/utils/CommonFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Constants/ConstantStrings.dart';
import '../Constants/ImageConstant.dart';
import 'appText.dart';

class DrawerList extends StatelessWidget {
  String? text;
  String? image;
  DrawerList({Key? key,this.text,this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: Get.height*0.030,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              (image!=null)? SizedBox(
                  width: 20,
                  child: SvgPicture.asset((image!=null)? image!:"",color:CommonFunctions.getThemeColor(light: Colors.black, dark:  Colors.white) ,)):
              Container(),
              SizedBox(width: Get.width*0.025,),
              AppText(text: text!,
                  height: 0.020,
                  fontFamily: ConstantStrings.fontFamilyMontserrat,
                  fontWeight: FontWeight.w400),
            ],
          ),
          SvgPicture.asset(ImageString.rightArrow,color: CommonFunctions.getThemeColor(light: Colors.black, dark:  Colors.white),)

        ],

      ),
    );
  }
}
