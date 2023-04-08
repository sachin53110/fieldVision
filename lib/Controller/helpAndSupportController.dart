import 'package:field_vision/Model/helpAndSupportModel.dart';
import 'package:field_vision/utils/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/error_model.dart';
import '../network/api_provider.dart';
import '../utils/error_snackbar.dart';

class HelpAndSupportController extends GetxController{

  TextEditingController helperSupportSubject=TextEditingController();
  TextEditingController helperSupportDescription=TextEditingController();
  GlobalKey<FormState>  subjectDescriptionFormKey = GlobalKey<FormState>();

  validationSubject(String value){
    if(value.isEmpty){
      return "Subject field is required";
    }
    return null;
  }
  RxBool? checkDescriptionVal=false.obs;
  validationDescription(String value){
    if(value.isEmpty){
      checkDescriptionVal=true.obs;
      return "";
    }
    checkDescriptionVal=false.obs;
    return null;
  }

  helpAndSupport(String subject,String description) async{
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().helpAndSupport(subject, description);
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
        CommanDialog.hideLoading();
      } else {
        if ((response as HelpAndSupportModel).status != null){
          CommanDialog.hideLoading();
          helperSupportSubject.text="";
          helperSupportDescription.text="";
          Get.back();
          toastMessage("Thank you for your response");
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }
}