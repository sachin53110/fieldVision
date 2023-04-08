import 'package:field_vision/View/HomeScreen/damage_report_screen.dart';
import 'package:field_vision/View/HomeScreen/homeSubmissions.dart';
import 'package:field_vision/View/LoginScreen/change_password.dart';
import 'package:field_vision/View/LoginScreen/loginScreen.dart';
import 'package:field_vision/View/LoginScreen/signUpScreen.dart';
import 'package:field_vision/View/LoginScreen/splashScreen.dart';
import 'package:get/get.dart';

import '../View/DrawerScreen/about_screen.dart';
import '../View/DrawerScreen/help_support_screen.dart';
import '../View/DrawerScreen/notification_screen.dart';
import '../View/DrawerScreen/privacy_policy_screen.dart';
import '../View/DrawerScreen/profile_screen.dart';
import '../View/DrawerScreen/setting_screen.dart';
import '../View/HomeScreen/Inspect_kiosk_screen.dart';
import '../View/HomeScreen/confirm_code_screen.dart';
import '../View/HomeScreen/kiosk_damage_verify_screen.dart';
import '../View/HomeScreen/kiosk_verification_screen.dart';
import '../View/HomeScreen/new_submission_screen.dart';
import '../View/HomeScreen/review_submission_screen.dart';
import '../View/LoginScreen/checkEmailScreen.dart';
import '../View/LoginScreen/forgotPasswordScreen.dart';
import '../View/LoginScreen/introduction_screen.dart';
import '../View/LoginScreen/otpVerificationScreen.dart';

class RouteHelper{
  //Route String
  static const String splash = "/splash";
  static const String signUp="/signUp";
  static const String introScreen="/introScreen";
  static const String login="/login";
  static const String otpVerificationScreen="/otpVerificationScreen";
  static const String forgotPasswordScreen="/forgotPasswordScreen";
  static const String checkEmailScreen="/checkEmailScreen";
  static const String homeSubmissionsScreen="/homeSubmissionsScreen";
  static const String newSubmissionScreen="/newSubmissionScreen";
  static const String confirmCodeScreen="/confirmCodeScreen";
  static const String kioskVerificationScreen="/kioskVerificationScreen";
  static const String kioskDamageVerifyScreen="/kioskDamageVerifyScreen";
  static const String aboutScreen="/aboutScreen";
  static const String profileScreen="/profileScreen";
  static const String helpSupportScreen="/helpSupportScreen";
  static const String settingScreen="/settingScreen";
  static const String privacyPolicyScreen="/privacyPolicyScreen";
  static const String notificationScreen="/notificationScreen";
  static const String inspectKioskScreen="/inspectKioskScreen";
  static const String damageReportScreen="/damageReportScreen";
  static const String reviewSubmissionScreen="/reviewSubmissionScreen";
  static const String changePassword="/changePassword";

  static String getSplash() => splash;
  static String getSignUpPage()=>signUp;
  static String getIntroScreen()=>introScreen;
  static String getLogin()=>login;
  static String getOtpVerificationScreen(String email,String password,
      String sendOtp,String confirmPassword)=>'$otpVerificationScreen?'
      'email=$email&password=$password&sendOtp=$sendOtp&confirmPassword=$confirmPassword';
  static String getForgotPasswordScreen()=>forgotPasswordScreen;
  static String getCheckEmailScreen(String email)=>'$checkEmailScreen?email=$email';
  static String getHomeSubmissionsScreen()=>homeSubmissionsScreen;
  static String getNewSubmissionScreen()=>newSubmissionScreen;
  static String getConfirmCodeScreen(String serialNumber)=>'$confirmCodeScreen?serialNumber=$serialNumber';
  static String getKioskVerificationScreen(String kioskTitle,String kioskId)=>'$kioskVerificationScreen?kioskTitle=$kioskTitle&kioskId=$kioskId';
  static String getKioskDamageVerifyScreen()=>kioskDamageVerifyScreen;
  static String getAboutScreen()=>aboutScreen;
  static String getProfileScreen()=>profileScreen;
  static String getHelpSupportScreen()=>helpSupportScreen;
  static String getSettingScreen()=>settingScreen;
  static String getPrivacyPolicyScreen( String changeTermAndPolicy)=>'$privacyPolicyScreen?changeTermAndPolicy=$changeTermAndPolicy';
  static String getNotificationScreen()=>notificationScreen;
  static String getInspectKioskScreen()=>inspectKioskScreen;
  static String getDamageReportScreen()=>damageReportScreen;
  static String getReviewSubmissionScreen(String submissionId)=>'$reviewSubmissionScreen?submissionId=$submissionId';
  static String getChangePassword()=>changePassword;

  //route
  static List<GetPage> routes = [
  GetPage(
  name: splash, page: () => const SplashScreen()),
  GetPage(name: signUp, page:()=> const SignUpScreen()),
  GetPage(name: introScreen, page:()=> const IntroductionScreen()),
  GetPage(name: login, page: ()=>const LoginScreen()),
  GetPage(name: otpVerificationScreen, page:(){
  var email=Get.parameters['email'];
  var password=Get.parameters['password'];
  var sendOtp=Get.parameters['sendOtp'];

  var confirmPassword=Get.parameters['confirmPassword'];
   return OtpVerificationScreen(email:email,password:password,sendOtp:sendOtp,
       confirmPassword:confirmPassword);
  }),
  GetPage(name: forgotPasswordScreen, page: ()=>const ForgotPasswordScreen()),
  GetPage(name: checkEmailScreen, page: (){
    var email=Get.parameters['email'];
   return CheckEmailScreen(email: email);}),
  GetPage(name: homeSubmissionsScreen, page: ()=>const HomeSubmissionsScreen()),
  GetPage(name: newSubmissionScreen, page: ()=>const NewSubmissionScreen()),
  GetPage(name: confirmCodeScreen, page: (){
    var serialNumber=Get.parameters['serialNumber'];
    return ConfirmCodeScreen(serialNumber: serialNumber,);}),
  GetPage(name: kioskVerificationScreen, page: (){
    var kioskTitle=Get.parameters['kioskTitle'];
    var kioskId=Get.parameters['kioskId'];
    return KioskVerificationScreen(kioskTitle: kioskTitle,kioskId:kioskId);}),
  GetPage(name: kioskDamageVerifyScreen, page: ()=>const KioskDamageVerifyScreen()),
  GetPage(name: aboutScreen, page: ()=>const AboutScreen()),
  GetPage(name: profileScreen, page: ()=>const ProfileScreen()),
  GetPage(name: helpSupportScreen, page: ()=>const HelpSupportScreen()),
  GetPage(name: settingScreen, page: ()=>const SettingScreen()),
  GetPage(name: privacyPolicyScreen, page: (){
      var changeTermAndPolicy=Get.parameters['changeTermAndPolicy'];
     return PrivacyPolicyScreen(changeTermAndPolicy:changeTermAndPolicy);}),
  GetPage(name: notificationScreen, page: ()=>const NotificationScreen()),
  GetPage(name: inspectKioskScreen, page: ()=> InspectKioskScreen()),
  GetPage(name: damageReportScreen, page: ()=>  DamageReportScreen()),
  GetPage(name: reviewSubmissionScreen, page: (){
    var submissionId=Get.parameters['submissionId'];
    return ReviewSubmissionScreen(submissionId: submissionId,);}),
  GetPage(name: changePassword, page: ()=>const ChangePasswordPage()),
  ];
}