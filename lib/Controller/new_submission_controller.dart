import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Constants/ImageConstant.dart';
import 'package:field_vision/Model/KioskDetailModel.dart';
import 'package:field_vision/Model/UpdateNoRepairModel.dart';
import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:field_vision/widgets/error_msg_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Model/NewSubmissionFoundModel.dart';
import '../Model/SubmissionFoundDetailModel.dart';
import '../Model/VerifyKioskModel.dart';
import '../Model/error_model.dart';
import '../network/api_provider.dart';
import '../utils/app_loader.dart';
import '../utils/error_snackbar.dart';

class NewSubmissionController extends GetxController{

  TextEditingController confirmTextController=TextEditingController();
  final Rx<TextEditingController> qrCode=TextEditingController().obs;
  RxBool? checkCameraAndManualScan=false.obs;
  RxString? serialNumberk;
  RxString? qrCodeValue="".obs;
  String? kioskDate;
  String? submissionData;
  var repairYesNoCheck = "".obs;
  var damageYesNoCheck = "".obs;

  RxString? textCheckOther="".obs;

  serialDoesNotNumber(BuildContext context,String msg){
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(10),
            height: Get.height*0.080,
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: AppColors.errorPopupColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageString.errorTrangle),
                SizedBox(width: Get.width*0.030,),
                Container(
                  width: Get.width*0.7,
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: Get.height*0.016,
                        fontWeight: FontWeight.w500,
                        color: AppColors.deleteTextColor,
                        fontFamily: ConstantStrings.fontFamilyMontserrat
                    ),
                    child: Text(msg),
                  ),
                ),

              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  getKioskDetails(BuildContext context,String serialNo,String brand,String location,String timestamp) async{
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().getKioskDetails(serialNo, brand, location, timestamp);
      if (response is ErrorMessage) {
         //toastMessage(response.message!, );
        CommanDialog.hideLoading();
         commonErrorPopup(context, response.message!, "");
      } else {
        if ((response as KioskDetailModel).status != null){
          CommanDialog.hideLoading();
           serialNumberk=response.data!.kiosk!.serialNumber!.obs;
           Get.toNamed(RouteHelper.getConfirmCodeScreen(response.data!.kiosk!.serialNumber!));
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  List<KioskComponentsData> kioskComponents=[];
  String? kioskTitle;

  verifyKiosk(BuildContext context, String serialNumber) async{
    CommanDialog.showLoading();
    try{
      kioskComponents.clear();
      var response = await ApiProvider().verifyKiosk(serialNumberk!.value, serialNumber);

      if (response is ErrorMessage) {
       // toastMessage(response.message!, );
        CommanDialog.hideLoading();
        serialDoesNotNumber(context,response.message!);
        Future.delayed(const Duration(milliseconds: 2000), () {
          Get.back();
        });
      //  commonErrorPopup(context, response.message!, "");
      } else {
        int?  value=Prefs.getInt("CheckSubmission");
        if(value==0){
          if ((response as SubmissionFoundDetailModel).status != null){
            CommanDialog.hideLoading();

            kioskDate=response.data!.submission!.submissionData!.date!;
            submissionData=response.data!.submission!.submissionData!.id!.toString();
            kioskTitle=response.data!.title;
            Prefs.setInt("kioskIdNewSub", response.data!.kiosk!.id!);
            Prefs.setInt("KioskCheckNewUpdate", 0);
            Prefs.setString("kioskSerialNumber", response.data!.kiosk!.serialNumber!);
            kioskComponents.addAll(response.data!.submission!.submissionData!.kioskComponents!);
            //Prefs.setStringList("ListComponents", response.data!.submission!.submissionData!.kioskComponents);
            Prefs.setString("kioskSubmissionId", response.data!.submission!.submissionData!.id!.toString());
             Get.toNamed(RouteHelper.getKioskDamageVerifyScreen());
           // Get.toNamed(RouteHelper.getKioskVerificationScreen(response.data!.title!));
            confirmTextController.clear();
            // Get.toNamed(RouteHelper.getConfirmCodeScreen(response.data!.kiosk!.serialNumber!));
          }
        }else{
          if ((response as NewSubmissionFoundModel).status != null){
            CommanDialog.hideLoading();
            int kioskId=response.data!.kiosk!.id!;
            Prefs.setInt("KioskCheckNewUpdate", 1);
            Prefs.setInt("kioskIdNewSub", response.data!.kiosk!.id!);
            Prefs.setString("kioskSerialNumber", response.data!.kiosk!.serialNumber!);
            Get.toNamed(RouteHelper.getKioskVerificationScreen(
                response.data!.title!,kioskId.toString()));
            confirmTextController.clear();
            // Get.toNamed(RouteHelper.getConfirmCodeScreen(response.data!.kiosk!.serialNumber!));
          }
        }

      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  updateNoRepair( String submissionId,String reason) async {
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().updateNoRepair(submissionId, reason);
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
        CommanDialog.hideLoading();

      } else {
        if ((response as UpdateNoRepairModel).status != null){
          CommanDialog.hideLoading();
         // Prefs.setInt("AddYesNo", 2);
          repairYesNoCheck.value = "false";
         // Get.toNamed(RouteHelper.getInspectKioskScreen());
        //  Get.offAllNamed(RouteHelper.getHomeSubmissionsScreen());
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }


}