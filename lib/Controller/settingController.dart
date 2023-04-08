import 'package:field_vision/Model/aboutModel.dart';
import 'package:field_vision/Model/settingModel.dart';
import 'package:field_vision/Model/updateSettingModel.dart';
import 'package:get/get.dart';

import '../Model/error_model.dart';
import '../network/api_provider.dart';
import '../utils/app_loader.dart';
import '../utils/error_snackbar.dart';

class SettingController extends GetxController {
  var aboutText = "".obs;
  var privacyPolicyText="".obs;
  var termAndConditionsText="".obs;
  RxInt? pushNotification=0.obs;
  RxInt? emailNotification=0.obs;
  RxBool? changeNotification=false.obs;
  about() async {
    CommanDialog.showLoading();
    try {
      var response = await ApiProvider().about();
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
        CommanDialog.hideLoading();
      } else {
        if ((response as AboutModel).status != null) {
          CommanDialog.hideLoading();
          if (response.data != null) {
            if (response.data!.content != null) {
              if (response.data!.content!.content != null) {
                aboutText.value = response.data!.content!.content!;
              }
            }
          }
        }
      }
    } catch (e) {
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }

  privacyPolicy() async {
    CommanDialog.showLoading();
    try {
      var response = await ApiProvider().privacyPolicy();
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
        CommanDialog.hideLoading();
      } else {
        if ((response as AboutModel).status != null) {
          CommanDialog.hideLoading();
          if (response.data != null) {
            if (response.data!.content != null) {
              if (response.data!.content!.content != null) {
                privacyPolicyText.value = response.data!.content!.content!;
              }
            }
          }
        }
      }
    } catch (e) {
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }

  termAndCondition() async {
    CommanDialog.showLoading();
    try {
      var response = await ApiProvider().termAndCondition();
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
        CommanDialog.hideLoading();
      } else {
        if ((response as AboutModel).status != null) {
          CommanDialog.hideLoading();
          if (response.data != null) {
            if (response.data!.content != null) {
              if (response.data!.content!.content != null) {
                termAndConditionsText.value = response.data!.content!.content!;
              }
            }
          }
        }
      }
    } catch (e) {
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }

  setting() async {
    //CommanDialog.showLoading();
    try {
      var response = await ApiProvider().setting();
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
       // CommanDialog.hideLoading();
      } else {
        if ((response as SettingModel).status != null) {
         // CommanDialog.hideLoading();
          pushNotification!.value=response.data!.setting!.pushNotification!;
          emailNotification!.value=response.data!.setting!.emailNotification!;
        }
      }
    } catch (e) {
      //CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }

  updateSetting(int notification,int email) async {
    CommanDialog.showLoading();
    try {
      var response = await ApiProvider().updateSetting(notification, email);
      if (response is ErrorMessage) {
        toastMessage(
          response.message!,
        );
        CommanDialog.hideLoading();
      } else {
        if ((response as UpdateSettingModel).status != null) {
          CommanDialog.hideLoading();
          pushNotification!.value=response.data!.setting!.pushNotification!;
          emailNotification!.value=response.data!.setting!.emailNotification!;
        }
      }
    } catch (e) {
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    } finally {}
  }
}
