import 'package:field_vision/services/prefs.dart';
import 'package:field_vision/widgets/appYellowButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../Controller/changePasswordController.dart';
import '../../RouteHelper/route_helper.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/appTextField.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final changePasswordController=Get.put(ChangePasswordController());
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  RxBool? newPasswordShow=true.obs;
  RxBool? confirmNewPasswordShow=true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,

      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkTopLoginDesign: ImageString.topLoginDesign,)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: changePasswordFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*0.2,),
                      AppText(
                        text: "Reset Password",
                        height: 0.040,
                        fontFamily: ConstantStrings.fontFamilyMontserratBold,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: Get.height*0.010,),
                      AppText(
                          text: "Change your password",
                          height: 0.018,
                          fontFamily: ConstantStrings.fontFamilyMontserrat,
                          fontWeight: FontWeight.w500,
                          color:  CommonFunctions.getThemeColor(
                              light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor)
                      ),
                      SizedBox(height: Get.height*0.030,),
                    Obx(()=>  AppTextField(
                        validator: (value){
                          return changePasswordController.validationNewPassword(value!);
                        },
                        callbackSuffix: (){
                          newPasswordShow!.value = !newPasswordShow!.value;
                        },
                      obscureText: newPasswordShow!.value,
                        suffix:  SvgPicture.asset((newPasswordShow!.value)?ImageString.eyeClose:ImageString.passEyeIcon,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),height: Get.height*0.020,),
                        minChar: 15,
                        textColor: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                        hintText: "New Password",
                        //obscureText: authController.loginPasswordShow!.value,

                       // suffix:  SvgPicture.asset((authController.loginPasswordShow!.value)?ImageString.eyeClose:ImageString.passEyeIcon,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),height: Get.height*0.020,),
                        prefixIcon: SvgPicture.asset(ImageString.lock,fit: BoxFit.scaleDown,
                          color:  CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),

                        textController: changePasswordController.newPassword,
                      )),
                      SizedBox(height: Get.height*0.020,),
                    Obx(()=>  AppTextField(
                        validator: (value){
                           return changePasswordController.validateConfirmPassword(value!);
                        },
                        minChar: 15,
                        textColor: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                        hintText: "Confirm New Password",
                        //obscureText: authController.loginPasswordShow!.value,
                        callbackSuffix: (){
                          confirmNewPasswordShow!.value = !confirmNewPasswordShow!.value;
                        },
                        obscureText: confirmNewPasswordShow!.value,
                        suffix:  SvgPicture.asset((confirmNewPasswordShow!.value)?ImageString.eyeClose:ImageString.passEyeIcon,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),height: Get.height*0.020,),

                        // suffix:  SvgPicture.asset((authController.loginPasswordShow!.value)?ImageString.eyeClose:ImageString.passEyeIcon,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),height: Get.height*0.020,),
                        prefixIcon: SvgPicture.asset(ImageString.lock,fit: BoxFit.scaleDown,
                          color:  CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),

                        textController: changePasswordController.confirmNewPassword,
                    )),
                      SizedBox(height: Get.height*0.025,),
                      GestureDetector(
                        onTap: (){
                          if(changePasswordFormKey.currentState!.validate()){
                            changePasswordController.changePassword(
                                changePasswordController.newPassword.text, changePasswordController.confirmNewPassword.text);
                          }
                        },
                        child: AppYellowButton(
                          height: 0.075,
                          width: Get.width,
                          textColor: Colors.black,
                          borderRadius: 15,
                          fontSize: 0.025,
                          text: "Submit",
                          color:  AppColors.appYellowColor,
                          borderWidth: 0,
                          borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


        ],
      ),

    );
  }
}
