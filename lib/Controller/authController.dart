import 'package:field_vision/Model/ForgotPasswordModel.dart';
import 'package:field_vision/Model/IntroModel.dart';
import 'package:field_vision/Model/LoginErrorMsgModel.dart';
import 'package:field_vision/Model/LoginModel.dart';
import 'package:field_vision/Model/logoutModel.dart';
import 'package:field_vision/Model/signUpModel.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../Constants/ConstantStrings.dart';
import '../Model/error_model.dart';
import '../Model/status_message.dart';
import '../Model/verify_code_model.dart';
import '../RouteHelper/route_helper.dart';
import '../network/api_provider.dart';
import '../utils/app_loader.dart';
import '../utils/error_snackbar.dart';
import '../widgets/common_popup.dart';

class AuthController extends GetxController{




  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController signUpEmail=TextEditingController();
  TextEditingController signUpPassword=TextEditingController();
  TextEditingController signUpConfirmPassword=TextEditingController();

  TextEditingController verifyCodeText=TextEditingController();
  TextEditingController loginEmail=TextEditingController();
  TextEditingController loginPassword=TextEditingController();

  TextEditingController forgotPasswordText=TextEditingController();

  RxBool? checkBoxValue=false.obs;
  RxBool? isObscureSignUp=false.obs;

  RxBool? confPasswordShow=true.obs;
  RxBool? passwordShow=true.obs;
  RxBool? loginPasswordShow=true.obs;
  bool focusCheck=true;
  FocusNode inputNode = FocusNode();


 validationSignUpEmail(String value){
   if(value.isEmpty){
     return "Email is required";
   }else if(!GetUtils.isEmail(value)){
     return "Please enter valid email";
   }
   return null;
 }

  validationEmail(String value) {
    if(value.isEmpty){
      return "Email is required";
    }else if(!GetUtils.isEmail(value)){
      return "Please enter the valid email address";
    }
    return null;

  }
  validationLoginPassword(String value){
    if(value.isEmpty){
      return "Password is required";
    }
    // else if(value.length<=7){
    //   return "Password must be at least 8 characters long";
    // }
    return null;
  }
  validationPassword(String value) {
   if(value.isEmpty){
     return "Password is required";
   }
   else if(value.length<=7){
     return "Password must be at least 8 characters long";
   }

    return null;
  }
  validateConfirmPassword(String value) {
   if(value.isEmpty){
     return "Confirm password is required";
   }
   else if (value != signUpPassword.text ) {
      return "Password & Confirm Passwords must be same";
    }
    return null;
  }

  register(BuildContext context,String email,String password,String confPassword,int check) async{
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().register(email, password, confPassword);
      if (response is ErrorMessage) {
       // toastMessage(response.message!, );
        CommanDialog.hideLoading();
        showPopup(context,response.message!,"");
      } else {
        if ((response as SignUpModel).status != null){
          CommanDialog.hideLoading();
          verifyCodeText.clear();
          if(check==0){
            Prefs.setString("loginOtp", response.sentOtp.toString());
            Get.toNamed(RouteHelper.getOtpVerificationScreen(
                email,response.password.toString(),
                response.sentOtp.toString(),
                confPassword));
          }
        else{
            Prefs.setString("loginOtp", response.sentOtp.toString());
            showPopup(context, "Verification code has been sent to your email", "");
            //toastMessage("Otp has been sent to your email");
          }
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  verifyCode(BuildContext context,String email,String otp,String password,String sentOtp) async{
    CommanDialog.showLoading();
    String? send=Prefs.getString("loginOtp");
    try{
      var response = await ApiProvider().verifyCode(email, otp,password,send!);
      if (response is ErrorMessage) {
        //toastMessage(response.message!, );
        CommanDialog.hideLoading();
        showPopup(context, response.message!, "");
      } else {
        if ((response as VerifyCodeModel).status != null){
          CommanDialog.hideLoading();
          Prefs.setString(ConstantStrings.token, response.data!.accessToken!);
          Prefs.setString(ConstantStrings.userEmail, response.data!.user!.email!);
          Prefs.setString(ConstantStrings.userLogin, ConstantStrings.userLogin);
          Prefs.setString(ConstantStrings.firstName, response.data!.user!.firstName ?? "");
          Prefs.setString(ConstantStrings.lastName, response.data!.user!.lastName ?? "");
          Prefs.setString(ConstantStrings.imageShare, response.data!.user!.image ?? "");
          Get.offAllNamed(RouteHelper.getHomeSubmissionsScreen());
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }
  showPopup(BuildContext context,String first,String second){
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

  login(BuildContext context,String email,String password) async{
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().login(email, password);
      if (response is LoginErrorMsgModel) {
        //toastMessage(response.message!, );

        CommanDialog.hideLoading();
        showPopup(context,response.title!,response.message!);
      } else {
        if ((response as LoginModel).status != null){
          CommanDialog.hideLoading();
          verifyCodeText.clear();
          Prefs.setString(ConstantStrings.token, response.data!.accessToken!);
          Prefs.setString(ConstantStrings.userEmail, response.data!.user!.email!);
          Prefs.setString(ConstantStrings.userLogin, ConstantStrings.userLogin);
          Prefs.setString(ConstantStrings.firstName, response.data!.user!.firstName ?? "");
          Prefs.setString(ConstantStrings.lastName, response.data!.user!.lastName ?? "");
          Prefs.setString(ConstantStrings.imageShare, response.data!.user!.image ?? "");
          // if(check==0){
          //   Prefs.setString("loginOtp", response.sentOtp.toString());
          //   Get.toNamed(RouteHelper.getOtpVerificationScreen(
          //       email,
          //       response.password.toString(),
          //       response.sentOtp.toString(),
          //       "Login",""
          //   ));
          // }else{
          //   Prefs.setString("loginOtp", response.sentOtp.toString());
          //   showPopup(context, "Verification code has been sent to your email", "");
          //   //toastMessage("Otp has been sent to your email");
          // }

          Get.offAllNamed(RouteHelper.getHomeSubmissionsScreen());
        }
      }
    }
    catch(e){
      //CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  forgotPassword(BuildContext context,String email,int checkForgetResend ) async{
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().forgotPassword(email);
      if (response is LoginErrorMsgModel) {
        //toastMessage(response.message!, );
        CommanDialog.hideLoading();
        showPopup(context,response.title!,response.message!);
      } else {
        if ((response as ForgotPasswordModel).status != null){
          CommanDialog.hideLoading();
          Prefs.setString(ConstantStrings.token, response.token!);
          Prefs.setString("changePasswordEmail", email);
          if(checkForgetResend==1){
            Get.toNamed(RouteHelper.getCheckEmailScreen(email));
          }

        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  logout() async{
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().logout();
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
        CommanDialog.hideLoading();
      } else {
        if ((response as LogoutModel).status != null){
          CommanDialog.hideLoading();
          //Prefs.clear();
          Prefs.setString(ConstantStrings.userLogin, "");
          Get.offAllNamed(RouteHelper.getLogin());
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }


}