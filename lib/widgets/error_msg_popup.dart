import 'package:field_vision/widgets/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Constants/ColorConstant.dart';
import '../Constants/ConstantStrings.dart';

commonErrorPopup(BuildContext context,String first,String second) async {
  showDialog(
      context: context, // <<----
      barrierDismissible: true,
      barrierColor: (Get.isDarkMode)? Colors.white54:Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: context.theme.backgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Get.height*0.005,),
                      Text(first,

                        textAlign: TextAlign.center,style: TextStyle(

                          fontSize: Get.height*0.020,
                          fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                          fontWeight: FontWeight.w700,
                        ),),
                      (second.isNotEmpty)?  SizedBox(
                        height: Get.height * 0.010,
                      ):Container(),
                      (second.isNotEmpty)? Text(second,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:Get.height* 0.018,
                          fontFamily: ConstantStrings.fontFamilyMontserrat,
                          fontWeight: FontWeight.w400,
                        ),):Container(),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Divider(height: 2,color: Colors.blue,),
                      SizedBox(
                        height: Get.height * 0.010,
                      ),
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            height: Get.height*0.020,
                            width: Get.width,
                            color: Colors.transparent,
                            child: Text("OK",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize:Get.height* 0.020,
                                  fontFamily: ConstantStrings.fontFamilyMontserrat,
                                  fontWeight: FontWeight.w400,
                                )),
                          )),
                    ])));
      });

}