import 'dart:io';

import 'package:field_vision/Model/NewSubmissionModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/KioskComponentsModel.dart';
import '../Model/KioskDetailModel.dart';
import '../Model/ReviewSubmissionModel.dart';
import '../Model/SubmitSubmissionModel.dart';
import '../Model/UpdateSubmissionModel.dart';
import '../Model/error_model.dart';
import '../RouteHelper/route_helper.dart';
import '../network/api_provider.dart';
import '../services/prefs.dart';
import '../utils/app_loader.dart';
import '../utils/error_snackbar.dart';
import '../widgets/error_msg_popup.dart';
import 'new_submission_controller.dart';

class DamageReportController extends GetxController{
  RxInt? lockerCount=0.obs;
  RxBool? lockerCheckOpenClose=false.obs;

  RxInt? kickplateCount=0.obs;
  RxBool? kickplateCheckOpenClose=false.obs;

  RxInt? headerCount=0.obs;
  RxBool? headerCheckOpenClose=false.obs;

  RxInt? sidePanelCount=0.obs;
  RxBool? sidePanelCheckOpenClose=false.obs;

  RxInt? touchscreenCount=0.obs;
  RxBool? touchscreenCheckOpenClose=false.obs;

  TextEditingController otherTextController=TextEditingController();
  RxBool? otherCheckOpenClose=false.obs;

  List<int> componentId=[];
  //List<ComponentModel> componentModel=[];
  List<int> checkSelectedWrap=[];
  final newSubmissionController=Get.put(NewSubmissionController());
  RxList<KioskComponentsList> kioskComponent=<KioskComponentsList>[].obs;
  components()async{
    CommanDialog.showLoading();
    try{
      kioskComponent.clear();
      var response = await ApiProvider().kioskComponents();
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
        CommanDialog.hideLoading();
      } else {
        if ((response as KioskComponentsModel).status != null){
          CommanDialog.hideLoading();
          kioskComponent.addAll(response.data!.kioskComponents!.obs);
          int checkNewUpdate=Prefs.getInt("KioskCheckNewUpdate")!;
          if(checkNewUpdate==0){
            for(int i=0;i<kioskComponent.length ;i++) {
              for (int j = 0; j < newSubmissionController.kioskComponents.length ; j++) {
                if (kioskComponent[i].id == newSubmissionController.kioskComponents[j].id) {
                  kioskComponent[i].selected = true.obs;
                }
              }
            }
          }else{
            for(int i=0;i<kioskComponent.length;i++) {
                  kioskComponent[i].selected = false.obs;
            }
          }
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  updateSubmission(Map<String,dynamic> map,
      File rightImage,File leftImage,File middleImage) async {
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().updateSubmission(map,rightImage,leftImage,middleImage);
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
        CommanDialog.hideLoading();
        //commonErrorPopup(context, response.message!, "");
      } else {
        if ((response as UpdateSubmissionModel).status != null){
          CommanDialog.hideLoading();
          Get.toNamed(RouteHelper.getReviewSubmissionScreen(response.data!.submission!.id.toString()));
          // serialNumber=response.data!.kiosk!.serialNumber!.obs;
          // Get.toNamed(RouteHelper.getConfirmCodeScreen(response.data!.kiosk!.serialNumber!));
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  newSubmission(Map<String,dynamic> map,File rightImage,File leftImage,File middleImage) async{
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().newSubmission(map,rightImage,leftImage,middleImage);
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
        CommanDialog.hideLoading();
        //commonErrorPopup(context, response.message!, "");
      } else {
        if ((response as NewSubmissionModel).status != null){
          CommanDialog.hideLoading();
          Get.toNamed(RouteHelper.getReviewSubmissionScreen(response.data!.submission!.id.toString()));
          // serialNumber=response.data!.kiosk!.serialNumber!.obs;
          // Get.toNamed(RouteHelper.getConfirmCodeScreen(response.data!.kiosk!.serialNumber!));
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }


  RxList<KioskComponentsData> kioskComponentsData=<KioskComponentsData>[].obs;

  RxString? kioskSerialNumber="".obs;
  RxString? brand="".obs;
  RxString? location="".obs;
  RxString? rightImage="".obs;
  RxString? leftImage="".obs;
  RxString? middleImage="".obs;
  reviewSubmission(String submissionId,)async{
    CommanDialog.showLoading();
    try{
      kioskComponentsData.clear();
      var response = await ApiProvider().reviewSubmission(submissionId);
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
        CommanDialog.hideLoading();
        //commonErrorPopup(context, response.message!, "");
      } else {
        if ((response as ReviewSubmissionModel).status != null){
          CommanDialog.hideLoading();
          kioskComponentsData.addAll(response.data!.kioskComponents!);
          kioskSerialNumber!.value=response.data!.kiosk!.serialNumber!;
          brand!.value=response.data!.kiosk!.brand!;
          location!.value=response.data!.kiosk!.location!;
          rightImage!.value=response.data!.rightImage!;
          leftImage!.value=response.data!.leftImage!;
          middleImage!.value=response.data!.middleImage!;
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  submitSubmission(String submissionId,) async {
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().submitSubmission(submissionId);
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
        CommanDialog.hideLoading();
        //commonErrorPopup(context, response.message!, "");
      } else {
        if ((response as SubmitSubmissionModel).status != null){
          CommanDialog.hideLoading();

          Get.offAllNamed(RouteHelper.getHomeSubmissionsScreen());
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

}




