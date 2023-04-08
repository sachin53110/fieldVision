
import 'package:field_vision/utils/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Constants/ColorConstant.dart';
import '../Constants/ConstantStrings.dart';
import '../Constants/ImageConstant.dart';
import '../Controller/home_page_controller.dart';
import 'appText.dart';


final homeCon=Get.put(HomePageController());

Future bottomSheet(int checkStatus, {Function()? cameraClick, Function()? galleryClick}){
  return Get.bottomSheet(
    barrierColor: (Get.isDarkMode)? Colors.white54:Colors.black54,
    Container(
        height: Get.height*0.25,
        decoration: BoxDecoration(
            color: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor,),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
        ),

        child:Column(
          children: [
            SizedBox(height: Get.height*0.010,),
            SvgPicture.asset(ImageString.backBottomSheet),
            Padding(
              padding:  EdgeInsets.only(left: 15,top: Get.height*0.060),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: ()async{
                      if(cameraClick != null){
                        cameraClick();
                      }
                      // else {
                      //   if (checkStatus == 1) {
                      //     await homeCon.pickImageRight(ImageSource.camera);
                      //     print('images====>>${homeCon.selectedImagePath1.value}');
                      //   } else if (checkStatus == 2) {
                      //     await homeCon.pickImageLeft(ImageSource.camera);
                      //   } else {
                      //     await homeCon.pickImageMiddle(ImageSource.camera,);
                      //   }
                      // }                  //    homeCon.pickImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                            width:Get.width*0.1,
                            child: SvgPicture.asset(ImageString.newPhotoTake)),
                        SizedBox(width: Get.width*0.020,),
                        AppText(text: ConstantStrings.takeNewPhoto,
                            height: 0.020,
                            fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.020,),
                const   Divider(height: 5,),
                  SizedBox(height: Get.height*0.020,),
                  GestureDetector(
                    onTap: (){
                      if(galleryClick != null){
                        galleryClick();
                      }
                      // if(checkStatus==1){
                      //   homeCon.pickImageRight(ImageSource.gallery);
                      // }else if(checkStatus==2){
                      //   homeCon.pickImageLeft(ImageSource.gallery);
                      // }else{
                      //   homeCon.pickImageMiddle(ImageSource.gallery);
                      // }
                     //homeCon.pickImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                            width:Get.width*0.1,
                            child: SvgPicture.asset(ImageString.updateFromCamera)),
                        SizedBox(width: Get.width*0.020,),
                        AppText(text: ConstantStrings.uploadFromCameraRoll,
                            height: 0.020,
                            fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    ),
    isDismissible: true,
  );
}