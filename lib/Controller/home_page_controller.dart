import 'dart:ffi';
import 'dart:io';
import 'package:field_vision/Model/notificationModel.dart';
import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/IntroModel.dart';
import '../Model/MarkNotification.dart';
import '../Model/SubmissionModel.dart';
import '../Model/error_model.dart';
import '../network/api_provider.dart';
import '../utils/app_loader.dart';
import '../utils/error_snackbar.dart';
import 'package:html/parser.dart';

class HomePageController extends GetxController {
  TextEditingController addReasonController = TextEditingController();

  String selectedImagePath1S = "";
  String selectedImagePath2S = "";
  String selectedImagePath3S = "";

  int? checkImageSelectBox;

  reset() {
    Prefs.setString("imageRight","");
    Prefs.setString("imageLeft","");
    Prefs.setString("imageMiddle","");
    selectedImagePath1S='';
    selectedImagePath2S='';
    selectedImagePath3S='';
  }


  File? pickedImage;


  RxBool? isLoading = false.obs;

  RxList<SubmissionsData> submissionsData = <SubmissionsData>[].obs;
  String? notificationCount="0";
  submission() async {
    isLoading!.value = true;
    //CommanDialog.showLoading();
    try {
      submissionsData.clear();
      var response = await ApiProvider().submission();
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
        // CommanDialog.hideLoading();
      } else {
        if ((response as SubmissionModel).status != null) {
          // CommanDialog.hideLoading();
          isLoading!.value = false;
          submissionsData.addAll(response.data!.submissions!);
          notificationCount=response.data!.notificationsCount.toString();
        }
      }
    } catch (e) {
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }

  deleteSubmission(
    String submissionId,
  ) async {
    CommanDialog.showLoading();
    try {
      submissionsData.clear();
      var response = await ApiProvider().deleteSubmission(submissionId);
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
        CommanDialog.hideLoading();
      } else {
        if ((response as SubmissionModel).status != null) {
          CommanDialog.hideLoading();
          submissionsData.addAll(response.data!.submissions!);
        }
      }
    } catch (e) {
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }

  RxList<NotificationsData> notificationsData = <NotificationsData>[].obs;

  notification() async {
    CommanDialog.showLoading();
    notificationsData.clear();
    try {
      var response = await ApiProvider().notification();
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
        CommanDialog.hideLoading();
      } else {
        if ((response as NotificationModel).status != null) {
          CommanDialog.hideLoading();
          notificationsData.addAll(response.data!.notifications!);
        }
      }
    } catch (e) {
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }

  deleteNotification(
    String notificationId,
  ) async {
    CommanDialog.showLoading();
    try {
      notificationsData.clear();
      var response = await ApiProvider().deleteNotification(notificationId);
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
        CommanDialog.hideLoading();
      } else {
        if ((response as NotificationModel).status != null) {
          CommanDialog.hideLoading();
          notificationsData.addAll(response.data!.notifications!);
        }
      }
    } catch (e) {
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }

  RxList<ContentData> content = <ContentData>[].obs;

  introPageContents() async {
    //CommanDialog.showLoading();
    try {
      var response = await ApiProvider().introPageContents();
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
        // CommanDialog.hideLoading();
      } else {
        if ((response as IntroModel).status != null) {
          // CommanDialog.hideLoading();
          for(int i=0;i<response.data!.length;i++){
            final document = parse(response.data![i].description);
            final String parsedString = parse(document.body.text).documentElement.text;
            response.data![i].description=parsedString;
          }
          content.addAll(response.data!);
        }
      }
    } catch (e) {
      //CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }

  markNotification() async {
    Get.back();
    try {
      var response = await ApiProvider().markNotification();
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
      } else {
        if ((response as MarkNotificationModel).status != null) {

        }
      }
    } catch (e) {
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }
}
