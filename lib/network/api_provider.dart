import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Model/ForgotPasswordModel.dart';
import 'package:field_vision/Model/IntroModel.dart';
import 'package:field_vision/Model/KioskDetailModel.dart';
import 'package:field_vision/Model/LoginErrorMsgModel.dart';
import 'package:field_vision/Model/LoginModel.dart';
import 'package:field_vision/Model/aboutModel.dart';
import 'package:field_vision/Model/helpAndSupportModel.dart';
import 'package:field_vision/Model/logoutModel.dart';
import 'package:field_vision/Model/notificationModel.dart';
import 'package:field_vision/Model/profileModel.dart';
import 'package:field_vision/Model/settingModel.dart';
import 'package:field_vision/Model/signUpModel.dart';
import 'package:field_vision/Model/updateProfileModel.dart';
import 'package:field_vision/Model/updateSettingModel.dart';
import 'package:field_vision/Model/verify_code_model.dart';
import 'package:field_vision/network/api_constants.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../Model/KioskComponentsModel.dart';
import '../Model/MarkNotification.dart';
import '../Model/NewSubmissionFoundModel.dart';
import '../Model/NewSubmissionModel.dart';
import '../Model/ReviewSubmissionModel.dart';
import '../Model/SubmissionFoundDetailModel.dart';
import '../Model/SubmissionModel.dart';
import '../Model/SubmitSubmissionModel.dart';
import '../Model/UpdateNoRepairModel.dart';
import '../Model/UpdateSubmissionModel.dart';
import '../Model/VerifyKioskModel.dart';
import '../Model/error_model.dart';
import '../Model/status_message.dart';

class ApiProvider{
  static BaseOptions options =
  BaseOptions(receiveTimeout: 90000, connectTimeout: 90000);
  late Box box;
  final Dio _dio = Dio(options);
  String getUrlWithBaseUrl(String url) {
    return ApiConstants.baseUrl + url;
  }

  String handleError(error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription = "No internet";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
          "Received invalid status code: ${dioError.response?.statusCode}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Invalid response from server";
    }
    return errorDescription;
  }

  Future<dynamic> register(String email,String password,String confPassword) async {
    var map = <String, dynamic>{
      'email':email,
      'password': password,
      'password_confirmation': confPassword,
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.register),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =SignUpModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return SignUpModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("register Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> verifyCode(String email,String otp,String password,String sentOtp) async{
    var map=<String,dynamic>{
      'email':email,
      'otp':otp,
      'password':password,
      'sent_otp':sentOtp
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.verifyOtp),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =VerifyCodeModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return VerifyCodeModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("verifyCode Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> login(String email,String password) async {
    var map = <String, dynamic>{
      'email':email,
      'password': password,
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.login),
          data: FormData.fromMap(map),
          options: headerOptions);

      var value =LoginModel.fromJson(response.data);
      if(value.status==false){
        return LoginErrorMsgModel.fromJson(response.data);
      }
      return LoginModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("login Exception occured: $error stackTrace: $stacktrace");
      var model = LoginErrorMsgModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    var map = <String, dynamic>{
      'email':email
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.forgotPassword),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =ForgotPasswordModel.fromJson(response.data);
      if(value.status==false){
        return LoginErrorMsgModel.fromJson(response.data);
      }
      return ForgotPasswordModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("forgotPassword Exception occured: $error stackTrace: $stacktrace");
      var model = LoginErrorMsgModel.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> logout() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.logout),
          options: headerOptions);
      return LogoutModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("register Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> profile() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.profile),
          options: headerOptions);
      return ProfileModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> updateProfile(String name, String email,String password,File image) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    box=await Hive.openBox("imageStore");
    var imageSave= box.get("profileImagePath");
    String fileName = image.path.split('/').last;

    var map = <String, dynamic>{
      'name':name,
      'email':email,
      'password':password,

    };
    if(imageSave!=null&&image.path!=""){
      map[ "image"]= (fileName != "")?await MultipartFile.fromFile(image.path, filename:fileName):await MultipartFile.fromFile(imageSave, filename:fileName);
    }
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.updateProfile),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =UpdateProfileModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return UpdateProfileModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("updateProfile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> helpAndSupport(String subject, String description) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var map = <String, dynamic>{
      'subject':subject,
      'description':description
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.helpAndSupport),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =HelpAndSupportModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return HelpAndSupportModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("forgotPassword Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> about() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.about),
          options: headerOptions);
      log("under about response $response");
      var value =AboutModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return AboutModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> privacyPolicy() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.privacyPolicy),
          options: headerOptions);
      log("under about response $response");
      var value =AboutModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return AboutModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> termAndCondition() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.termsAndConditions),
          options: headerOptions);
      log("under about response $response");
      var value =AboutModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return AboutModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> setting() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.setting),
          options: headerOptions);
      var value =SettingModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return SettingModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> updateSetting(int notification,int email) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var map = <String, dynamic>{
      'push_notification':notification,
      'email_notification':email
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.updateSetting),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =UpdateSettingModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return UpdateSettingModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("update setting Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> changePassword(String password,String passwordConfirmation)
  async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    String? email=Prefs.getString("changePasswordEmail");
    var map = <String, dynamic>{
      'email':email,
      'token':accessToken,
      'password':password,
      'password_confirmation':passwordConfirmation
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.changePassword),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =StatusMessage.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return StatusMessage.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("changePassword Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }


  Future<dynamic> introPageContents() async {
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.introPageContents),
          options: headerOptions);
      return IntroModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> getKioskDetails(String serialNumber,String brand,String location,String timestamp) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var map = <String, dynamic>{
      'serial_number':serialNumber,
      if(brand.isNotEmpty)
        'brand':brand,
      if(location.isNotEmpty)
        'location':location,
      if(timestamp.isNotEmpty)
        'timestamp':timestamp
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.getKioskDetails),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =KioskDetailModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return KioskDetailModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("KioskDetailModel Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> verifyKiosk(String serialNumber,String sentSerialNumber) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var map = <String, dynamic>{
      'serial_number':serialNumber,
      'sent_serial_number':sentSerialNumber
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.verifyKiosk),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =SubmissionFoundDetailModel.fromJson(response.data);
      Prefs.setInt("CheckSubmission", 0);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      if(value.isSubmissionFound==false){
        Prefs.setInt("CheckSubmission", 1);
        return NewSubmissionFoundModel.fromJson(response.data);
      }
      return SubmissionFoundDetailModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("KioskDetailModel Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> kioskComponents() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.kioskComponents),
          options: headerOptions);
      var value =KioskComponentsModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return KioskComponentsModel.fromJson(response.data);

    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> newSubmission(Map<String,dynamic> map,File rightImage,File leftImage,File middleImage) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    Map<String ,dynamic> mapValue={

    };
    String fileName = rightImage.path.split('/').last;
    mapValue=map;
    mapValue['right_image']=await MultipartFile.fromFile(rightImage.path, filename:fileName);
    mapValue[ 'left_image']=await MultipartFile.fromFile(leftImage.path, filename:fileName);
    mapValue['middle_image']=await MultipartFile.fromFile(middleImage.path, filename:fileName);
    Prefs.setString("imageRight","");
    Prefs.setString("imageLeft","");
    Prefs.setString("imageMiddle","");
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.newSubmission),
          data: FormData.fromMap(mapValue),
          options: headerOptions);
      var value =NewSubmissionModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return NewSubmissionModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("updateProfile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> reviewSubmission(String submissionId,) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var map = <String, dynamic>{
      'submission_id':submissionId,
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.reviewSubmission),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =ReviewSubmissionModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return ReviewSubmissionModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("review submission Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> submitSubmission(String submissionId,) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var map = <String, dynamic>{
      'submission_id':submissionId,
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.submitSubmission),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =SubmitSubmissionModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return SubmitSubmissionModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("submit submission Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> submission() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.submissions),
          options: headerOptions);
      var value =SubmissionModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return SubmissionModel.fromJson(response.data);

    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> deleteSubmission(String submissionId,) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var map = <String, dynamic>{
      'submission_id':submissionId,

    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.deleteSubmission),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =SubmissionModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return SubmissionModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("delete submission Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> notification() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.notifications),
          options: headerOptions);
      var value =NotificationModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return NotificationModel.fromJson(response.data);

    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> deleteNotification(String notificationId,) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var map = <String, dynamic>{
      'notification_id':notificationId,

    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.deleteNotification),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =NotificationModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return NotificationModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("delete submission Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> updateNoRepair(String submissionId,String reason) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var map = <String, dynamic>{
      'submission_id':submissionId,
      'reason_for_no_repair_today':reason,
    };
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.updateNoRepair),
          data: FormData.fromMap(map),
          options: headerOptions);
      var value =UpdateNoRepairModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return UpdateNoRepairModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("updateNoRepair Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> updateSubmission(Map<String,dynamic> map,
      File rightImage,File leftImage,File middleImage) async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    Map<String ,dynamic> mapValue={

    };
    String fileName = rightImage.path.split('/').last;
    mapValue=map;
    mapValue['right_image']=await MultipartFile.fromFile(rightImage.path, filename:fileName);
    mapValue[ 'left_image']=await MultipartFile.fromFile(leftImage.path, filename:fileName);
    mapValue['middle_image']=await MultipartFile.fromFile(middleImage.path, filename:fileName);
    Prefs.setString("imageRight","");
    Prefs.setString("imageLeft","");
    Prefs.setString("imageMiddle","");
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.post(
          getUrlWithBaseUrl(ApiConstants.updateSubmission),
          data: FormData.fromMap(mapValue),
          options: headerOptions);
      var value =UpdateSubmissionModel.fromJson(response.data);
      if(value.status==false){
        return ErrorMessage.fromJson(response.data);
      }
      return UpdateSubmissionModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("updateProfile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }

  Future<dynamic> markNotification() async {
    String? accessToken=Prefs.getString(ConstantStrings.token);
    var headerOptions = Options(
      headers: {
        "Content-Type": "application/json-path+json",
        "Accept":"application/json",
        "Authorization":"Bearer $accessToken"
      },
    );
    try{
      Response response = await _dio.get(
          getUrlWithBaseUrl(ApiConstants.markNotificationRead),
          options: headerOptions);
      return MarkNotificationModel.fromJson(response.data);
    }
    catch(error, stacktrace){
      debugPrint("profile Exception occured: $error stackTrace: $stacktrace");
      var model = ErrorMessage.fromJson((error as dynamic).response.data);
      return model;
    }
  }
}