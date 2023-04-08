import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Controller/authController.dart';
import 'package:field_vision/widgets/appText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ImageConstant.dart';
import '../../RouteHelper/route_helper.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appYellowButton.dart';

class OtpVerificationScreen extends StatefulWidget {
  String? email;
  String? password;
  String? sendOtp;
  String? confirmPassword;
   OtpVerificationScreen({Key? key,this.email,this.password,this.sendOtp,this.confirmPassword}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final authController=Get.put(AuthController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.verifyCodeText.clear();
  }
  showPopup(){
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
                        Text("Verification Code is required",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Get.height*0.020,
                            fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                            fontWeight: FontWeight.w700,
                          ),),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: RichText(
              text: TextSpan(
                children:  <TextSpan>[
                  TextSpan(text: ConstantStrings.receiveCode, style: TextStyle(
                      fontFamily: ConstantStrings.fontFamilyMontserrat
                      ,fontWeight: FontWeight.w500,
                      fontSize: Get.height*0.016,
                      color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor))),
                  TextSpan(text: ConstantStrings.requestAgain
                      ,style: TextStyle(
                        fontFamily: ConstantStrings.fontFamilyMontserratSemiBold
                        ,fontWeight: FontWeight.w500,
                        fontSize: Get.height*0.018,
                        color: CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white)  ,decoration: TextDecoration.underline,),
                      recognizer:  TapGestureRecognizer()
                        ..onTap = (){
                        // if(widget.checkScreen=="Login"){
                        //   authController.login(context,widget.email!,widget.password!, 1);
                        // }
                        // else{
                          authController.register(context,widget.email!,widget.password!,
                              widget.confirmPassword!, 1);
                        //}
                        }),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height*0.030,),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkTopLoginDesign: ImageString.topLoginDesign,)),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.050),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBarWidget(
                      text: ConstantStrings.otp,
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height*0.080,),
                      Align(
                          alignment:Alignment.center,
                          child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkOtpVerificationIcon: ImageString.otpVerificationIcon)),
                      SizedBox(height: Get.height*0.040,),
                      AppText(text: ConstantStrings.verificationCode,
                          height: 0.030,
                          fontFamily: ConstantStrings.fontFamilyMontserratBold,
                          fontWeight: FontWeight.w700),
                      SizedBox(height: Get.height*0.010,),
                      Container(
                        width: Get.width*0.75,
                        child: AppText(text: ConstantStrings.verifyOtpDescription,
                            height: 0.019,
                            fontFamily: ConstantStrings.fontFamilyMontserrat,
                            textAlign: TextAlign.center,
                            color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: Get.height*0.010,),
                      AppText(text: widget.email!,
                          height: 0.020,
                          fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                          fontWeight: FontWeight.w600),
                      SizedBox(height:  Get.height*0.030,),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20,right: Get.width*0.14,
                            left: Get.width*0.14),
                        child: PinCodeTextField(
                          appContext: context,
                          animationType: AnimationType.fade,
                          hintCharacter: "0",
                         autoFocus: authController.focusCheck,
                         focusNode: authController.inputNode,
                         hintStyle:const TextStyle(
                           fontWeight: FontWeight.w500,
                           fontFamily: ConstantStrings.fontFamilyMontserrat,
                         ),
                          textStyle:const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: ConstantStrings.fontFamilyMontserrat,
                          ),
                          autoDisposeControllers: false,
                          length: 4,
                          controller: authController.verifyCodeText,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            print(value);
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            borderWidth: 1,
                            fieldHeight: Get.height * 0.070,
                            fieldWidth: Get.width * 0.130,
                            inactiveColor: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),
                            activeColor: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),
                            selectedColor:CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),
                          ),
                          boxShadows:  [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackButtonColor),
                            )
                          ],
                          onCompleted: (value) {
                            // if (value == requiredNumber) {
                            //   print("valid pin");
                            // } else {
                            //   print("invalid pin");
                            // }
                          },
                        ),
                      ),
                      SizedBox(height:  Get.height*0.030,),
                      GestureDetector(
                        onTap: () async{
                          if(authController.verifyCodeText.text.length >3){
                            await authController.verifyCode(context, widget.email!, authController.verifyCodeText.text,widget.password!,widget.sendOtp!);
                          }
                          else{
                            showPopup();
                          }

                         // Get.toNamed(RouteHelper.getHomeSubmissionsScreen());
                        },
                        child: AppYellowButton(
                          height: 0.075,
                          fontSize: 0.022,
                          width: Get.width,
                          borderRadius: Get.height*0.060,
                          textColor: Colors.black,
                          text: ConstantStrings.verifyAndProceed,
                          color:  AppColors.appYellowColor,
                          borderWidth: 0,
                          borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                        ),
                      ),
                    ],
                  ),
                    SizedBox(height: Get.height*0.025,),
                  ],
                ),

              ),
            ),
          ),


        ],
      ),
    );
  }
}
