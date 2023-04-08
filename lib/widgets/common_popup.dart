import 'package:field_vision/widgets/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Constants/ColorConstant.dart';
import '../Constants/ConstantStrings.dart';

 commonPopup(BuildContext context,String image,Color colors,String text,final VoidCallback? yesCallBack) async {
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Get.height*0.030,),
                       SvgPicture.asset(image,color: colors,height: Get.height*0.070,width: Get.width*0.080,fit: BoxFit.fill,),
                      SizedBox(height: Get.height*0.030),
                      Container(
                        width: Get.width*0.6,
                        child: AppText(text: text,
                            height: 0.024,
                            textAlign: TextAlign.center,
                            fontFamily: ConstantStrings.fontFamilyMontserratBold,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: Get.height*0.030,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                padding: EdgeInsets.all(2),
                                height: Get.height * 0.040,
                                width: Get.width * 0.18,
                                decoration: BoxDecoration(
                                  color: (Get.isDarkMode)?AppColors.darkBackButtonColor: AppColors.dottedBorderColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Text(
                                      ConstantStrings.no,
                                      style: TextStyle(fontWeight: FontWeight.w600,fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,fontSize: Get.height * 0.020, color:(Get.isDarkMode)?Colors.white: Colors.black),
                                    ))),
                          ),
                          SizedBox(width: Get.width*0.010,),
                          InkWell(
                              onTap: yesCallBack,
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  height: Get.height * 0.040,
                                  width: Get.width * 0.18,
                                  decoration: BoxDecoration(
                                    color: AppColors.appYellowColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ConstantStrings.yes,
                                      style: TextStyle(fontWeight: FontWeight.w600,
                                          fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,fontSize: Get.height * 0.020,
                                          color:Colors.black),),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.010,
                      )
                    ])));
      });

}