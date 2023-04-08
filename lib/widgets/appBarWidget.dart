import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Constants/ColorConstant.dart';
import '../Constants/ConstantStrings.dart';
import '../Constants/ImageConstant.dart';
import 'appText.dart';

class AppBarWidget extends StatelessWidget {
  String? text;
  AppBarWidget({Key? key,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(color: context.theme.buttonColor,
              shape: BoxShape.circle,
            ),
            child:SvgPicture.asset((Get.isDarkMode)?ImageString.darkBackIcon: ImageString.leftArrow),
          ),
        ),
        (text!=null)?
        AppText(text: text!,
            fontFamily: ConstantStrings.fontFamilyMontserratBold,
            height: 0.025,
            fontWeight: FontWeight.w600):Container(),
        SizedBox(width: 35,)
      ],
    );
  }
}
