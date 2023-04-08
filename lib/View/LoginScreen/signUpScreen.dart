import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Constants/ImageConstant.dart';
import 'package:field_vision/Controller/authController.dart';

import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/View/LoginScreen/loginScreen.dart';
import 'package:field_vision/View/LoginScreen/otpVerificationScreen.dart';
import 'package:field_vision/utils/CommonFunctions.dart';
import 'package:field_vision/utils/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Controller/settingController.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/appTextField.dart';
import '../../widgets/appYellowButton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final settingController=Get.put(SettingController());
  final authController=Get.put(AuthController());
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  void showDailog(int check) async {
    setState(() {});
    showDialog(
      context: context, // <<----
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: SingleChildScrollView(
            child: Container(
             height: Get.height*0.65,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height*0.020,),
                    Text((check==0)?"Term And Conditions":"Privacy Policy",style: TextStyle(
                      fontSize: Get.height*0.022,
                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold
                    ),),
                    Html(
                      data: (check==0)?settingController.termAndConditionsText.value:settingController.privacyPolicyText.value,defaultTextStyle: TextStyle(
                        fontSize: Get.height*0.018,
                        letterSpacing: 1.2,
                        fontFamily: ConstantStrings.fontFamilyMontserrat,
                        color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500
                    ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    await Future.delayed(const Duration(milliseconds: 2000));
    // Get.off(BookTourPage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children:  <TextSpan>[
                  TextSpan(text: ConstantStrings.joinedUsBefore, style: TextStyle(
                      fontFamily: ConstantStrings.fontFamilyMontserrat
                      ,fontWeight: FontWeight.w500,
                      fontSize: Get.height*0.018,
                      color:CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor))),
                  TextSpan(text: ConstantStrings.login
                      ,style: TextStyle(
                        fontFamily: ConstantStrings.fontFamilyMontserratSemiBold
                        ,fontWeight: FontWeight.w500,
                        fontSize: Get.height*0.020,
                        color: CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white) ,decoration: TextDecoration.underline,),
                      recognizer:  TapGestureRecognizer()
                        ..onTap = (){
                          Get.toNamed(RouteHelper.getLogin());
                        }),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height*0.030,),
        ],
      ),
      body:   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkTopLoginDesign: ImageString.topLoginDesign,)),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.050),
                    child: Form(
                      key: signUpFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppBarWidget(text: "",),
                          Padding(
                            padding:  EdgeInsets.only(top: Get.height*0.080),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                      text: ConstantStrings.signUpText,
                                      height: 0.045,
                                      fontWeight: FontWeight.w700,
                                    fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                  ),
                                  SizedBox(height: Get.height*0.015,),
                                  AppText(
                                    text: ConstantStrings.signUpDetail,
                                    height: 0.020,
                                    fontFamily: ConstantStrings.fontFamilyMontserrat,
                                    fontWeight: FontWeight.w500,
                                    color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                  ),
                                  SizedBox(height: Get.height*0.030,),
                                  AppTextField(
                                    validator: (value){
                                      return authController.validationSignUpEmail(value!);
                                    },

                                    textColor: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                                    hintText: ConstantStrings.email,
                                    prefixIcon: SvgPicture.asset(ImageString.email,fit: BoxFit.scaleDown,height: 10,width: 10,
                                      color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),
                                    textController: authController.signUpEmail,
                                  ),
                                  SizedBox(height: Get.height*0.020,),
                                 Obx(()=> AppTextField(
                                   validator: (value){
                                     return authController.validationPassword(value!);
                                   },
                                    onChanged: (value){
                                     if(authController.signUpConfirmPassword.text.isNotEmpty){
                                       signUpFormKey.currentState!
                                           .validate();
                                     }

                                    },
                                    textColor: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                                    hintText: ConstantStrings.password,
                                    obscureText: authController.passwordShow!.value,
                                    callbackSuffix: (){
                                      authController.passwordShow!.value = !authController.passwordShow!.value;
                                    },
                                    suffix:  SvgPicture.asset((authController.passwordShow!.value)?ImageString.eyeClose:ImageString.passEyeIcon,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),height: Get.height*0.020,),
                                    prefixIcon: SvgPicture.asset(ImageString.lock,fit: BoxFit.scaleDown,height: 10,width: 10,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),
                                    textController: authController.signUpPassword,
                                 ) ),
                                  SizedBox(height: Get.height*0.020,),
                             Obx(()=>   AppTextField(
                                    validator: (value){
                                     return authController.validateConfirmPassword(value!);
                                    },
                               // onChanged: (value){
                               //   signUpFormKey.currentState!
                               //       .validate();
                               // },
                                    textColor: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                                    hintText: ConstantStrings.confirmPassword,
                                    obscureText: authController.confPasswordShow!.value,
                                    callbackSuffix: (){
                                      authController.confPasswordShow!.value = !authController.confPasswordShow!.value;
                                    },
                                    suffix:  SvgPicture.asset((authController.confPasswordShow!.value)?ImageString.eyeClose:ImageString.passEyeIcon,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),height: Get.height*0.020,),

                                    prefixIcon: SvgPicture.asset(ImageString.lock,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),
                                    textController: authController.signUpConfirmPassword,

                                  )),
                                  SizedBox(height: Get.height*0.020,),
                                  RichText(

                                    text: TextSpan(
                                      style: TextStyle(
                                        height: 1.5
                                      ),
                                      children:  <TextSpan>[
                                        TextSpan(text:  ConstantStrings.bySigningUpAgree, style: TextStyle(
                                            fontFamily: ConstantStrings.fontFamilyMontserrat
                                            ,fontWeight: FontWeight.w500,
                                            fontSize: Get.height*0.018,
                                            color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor))),
                                        TextSpan(text: ConstantStrings.termsAndConditions,
                                            recognizer: TapGestureRecognizer()..onTap=(){
                                            settingController.termAndCondition().then((value) {
                                            showDailog(0);
                                            });
                                            },
                                            style: TextStyle(
                                            fontFamily: ConstantStrings.fontFamilyMontserrat
                                            ,fontWeight: FontWeight.w500,
                                            fontSize: Get.height*0.018,
                                            color: CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white))),
                                        TextSpan(text:  ConstantStrings.and, style: TextStyle(
                                            fontFamily: ConstantStrings.fontFamilyMontserrat
                                            ,fontWeight: FontWeight.w500,
                                            fontSize: Get.height*0.018,
                                            color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor))),
                                        TextSpan(text: ConstantStrings.privacyPolicy,
                                          recognizer:  TapGestureRecognizer()
                                            ..onTap = (){
                                              settingController.privacyPolicy().then((value) {
                                                showDailog(1);
                                              });
                                            },
                                            style: TextStyle(
                                            fontFamily: ConstantStrings.fontFamilyMontserrat
                                            ,fontWeight: FontWeight.w500,
                                            fontSize: Get.height*0.018,
                                            color:CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Get.height*0.040,),
                                  GestureDetector(
                                    onTap: (){
                                      if (signUpFormKey.currentState!
                                          .validate())
                                      {
                                        authController.register(context,authController.signUpEmail.text, authController.signUpPassword.text, authController.signUpConfirmPassword.text,0);
                                      }

                                     // Get.toNamed(RouteHelper.getOtpVerificationScreen());
                                    },
                                    child: AppYellowButton(
                                      height: 0.075,
                                      width: Get.width,
                                      fontSize: 0.025,
                                      borderRadius: 15,
                                      text: ConstantStrings.signUp,
                                      color:  AppColors.appYellowColor,
                                      borderWidth: 0,
                                      textColor: Colors.black,
                                      borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                                    ),
                                  ),
                                ],
                              ),
                          ),

                          SizedBox(height: Get.height*0.025,),

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
