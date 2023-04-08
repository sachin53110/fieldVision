import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Model/error_model.dart';
import '../Model/status_message.dart';
import '../RouteHelper/route_helper.dart';
import '../network/api_provider.dart';
import '../utils/app_loader.dart';
import '../utils/error_snackbar.dart';

class ChangePasswordController extends GetxController{
  TextEditingController oldPassword=TextEditingController();
  TextEditingController newPassword=TextEditingController();
  TextEditingController confirmNewPassword=TextEditingController();

  validationOldPassword(String value){
    if(value.isEmpty){
      return "Password is required";
    }else if(value.length<=7){
      return "Password must be at least 8 characters long";
    }
    return null;
  }
  validationNewPassword(String value){
    if(value.isEmpty){
      return "Password is required";
    }else if(value.length<=7){
      return "Password must be at least 8 characters long";
    }
    return null;
  }
  validateConfirmPassword(String value) {
    if(value.isEmpty){
      return "Confirm password is required";
    }
    else if (value != newPassword.text ) {
      return "Confirm Password & Passwords must be same";
    }
    return null;
  }

  changePassword(String password,String passwordConfirmation) async{
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().changePassword(  password, passwordConfirmation);
      if (response is ErrorMessage) {
        toastMessage(response.message!,);
        CommanDialog.hideLoading();
      } else {
        if ((response as StatusMessage).status != null){
          CommanDialog.hideLoading();
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
