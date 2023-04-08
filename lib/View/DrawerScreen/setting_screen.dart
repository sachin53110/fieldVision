import 'package:field_vision/Controller/drawer_Controller.dart';
import 'package:field_vision/Controller/settingController.dart';
import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/widgets/appText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../Controller/authController.dart';
import '../../services/prefs.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/common_popup.dart';
import '../../widgets/drawer_list.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final authController=Get.put(AuthController());
  final drawerController = Get.put(DrawerControllers());
  final settingController=Get.put(SettingController());
@override
  void initState() {
  drawerController.toggleCheck!.value = Prefs.getBool("theme") ?? false;
    // TODO: implement initState
    super.initState();
    init();
  }
  init(){
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>  settingController.setting());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: Padding(
      padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.050),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.060,
          ),
          AppBarWidget(
            text: ConstantStrings.settings,
          ),
          SizedBox(
            height: Get.height * 0.030,
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getAboutScreen());
            },
            child: DrawerList(
              text: ConstantStrings.aboutUs,
            ),
          ),
          SizedBox(
            height: Get.height * 0.020,
          ),
          Divider(
            height: 5,
            color: CommonFunctions.getThemeColor(light: AppColors.countBorderColor, dark: AppColors.darkDotsIndicatorColor),
          ),
          SizedBox(
            height: Get.height * 0.020,
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPrivacyPolicyScreen(ConstantStrings.privacyPolicy));
            },
            child: DrawerList(
              text: ConstantStrings.privacyPolicy,
            ),
          ),
          SizedBox(
            height: Get.height * 0.020,
          ),
          Divider(
            height: 5,
            color: CommonFunctions.getThemeColor(light: AppColors.countBorderColor, dark: AppColors.darkDotsIndicatorColor),
          ),
          SizedBox(
            height: Get.height * 0.020,
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPrivacyPolicyScreen(ConstantStrings.termsAndConditions));
            },
            child: DrawerList(
              text: ConstantStrings.termsAndConditions,
            ),
          ),
          SizedBox(
            height: Get.height * 0.020,
          ),
          Divider(
            height: 5,
            color: CommonFunctions.getThemeColor(light: AppColors.countBorderColor, dark: AppColors.darkDotsIndicatorColor),
          ),
          SizedBox(
            height: Get.height * 0.030,
          ),
          AppText(text: ConstantStrings.interfaceMode,
              fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
              height: 0.022, fontWeight: FontWeight.w600,
          color: CommonFunctions.getThemeColor(light: Colors.black, dark: Colors.white),),
          SizedBox(
            height: Get.height * 0.030,
          ),
          Container(
            height: Get.height * 0.085,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Get.height*0.060)),
              color: CommonFunctions.getThemeColor(light: Colors.white,
                  dark: AppColors.darkBackButtonColor),
              border: Border.all(width: 1, color: (Get.isDarkMode)?AppColors.darkBackButtonColor: AppColors.dotsIndicatorColor),
            ),
            child: Obx(()=> Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 AppText(text: "Light mode",
                     height: 0.018,
                     fontFamily: ConstantStrings.fontFamilyMontserrat,
                     color:(drawerController.toggleCheck!.value)?(Get.isDarkMode)? AppColors.darkDotsIndicatorColor:Colors.black:(Get.isDarkMode)?AppColors.darkDotsIndicatorColor:AppColors.grayColor,
                     fontWeight: FontWeight.w500),
                 Switch(
                   activeColor: AppColors.toggleColor,
                   activeTrackColor: Colors.grey.shade400,
                   inactiveThumbColor: AppColors.appYellowColor,
                   inactiveTrackColor: Colors.grey.shade400,
                   splashRadius: 50.0,
                   // boolean variable value
                   value: drawerController.toggleCheck!.value,
                   // changes the state of the switch
                   onChanged: (value){
                     drawerController.toggleCheck!.value = value;
                     bool checkStatus=Prefs.getBool("theme") ?? false;
                     if (Get.isDarkMode) {

                       Get.changeThemeMode(ThemeMode.light);
                     } else {

                       Get.changeThemeMode(ThemeMode.dark);
                     }
                     if(checkStatus==true){
                       Prefs.setBool("theme", false);
                     }else{
                       Prefs.setBool("theme", true);
                     }
                   },
                   // onChanged: (value) =>
                   //     setState(() =>
                   // drawerController.toggleCheck!.value = value
                   // ),
                 ),
                 AppText(text: "Dark mode",
                     height: 0.018,
                     fontFamily: ConstantStrings.fontFamilyMontserrat,
                     color: (drawerController.toggleCheck!.value)?CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: Colors.white):CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white),
                     fontWeight: FontWeight.w500),
               ],
            )),
          ),
          SizedBox(
            height: Get.height * 0.030,
          ),
          AppText(text: ConstantStrings.notificationSettings,
              fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
              height: 0.022, fontWeight: FontWeight.w600),
          SizedBox(
            height: Get.height * 0.020,
          ),
          Divider(
            height: 5,
            color: CommonFunctions.getThemeColor(light: AppColors.countBorderColor, dark: AppColors.darkDotsIndicatorColor),
          ),
          SizedBox(
            height: Get.height * 0.020,
          ),
          GestureDetector(
            onTap: () {
              settingController.changeNotification!.value = false;
              settingController.updateSetting(1, 0);
            },
            child: Obx(() => Row(
                  children: [
                    SvgPicture.asset(
                        (settingController.pushNotification!.value==1) ? ImageString.notificationOnCheck : ImageString.notificationOffCheck),
                    SizedBox(
                      width: Get.width * 0.040,
                    ),
                    AppText(text: ConstantStrings.pushNotifications,
                        fontFamily: ConstantStrings.fontFamilyMontserrat,
                        height: 0.018, fontWeight: FontWeight.w500)
                  ],
                )),
          ),
          SizedBox(
            height: Get.height * 0.020,
          ),
          Divider(
            height: 5,
            color: CommonFunctions.getThemeColor(light: AppColors.countBorderColor, dark: AppColors.darkDotsIndicatorColor),
          ),
          SizedBox(
            height: Get.height * 0.020,
          ),
          GestureDetector(
            onTap: () {
              settingController.changeNotification!.value = true;
              settingController.updateSetting(0, 1);
            },
            child: Obx(() => Row(
                  children: [
                    SvgPicture.asset(
                        (settingController.emailNotification!.value == 1) ? ImageString.notificationOnCheck : ImageString.notificationOffCheck),
                    SizedBox(
                      width: Get.width * 0.040,
                    ),
                    AppText(text: ConstantStrings.emailNotifications,
                        fontFamily: ConstantStrings.fontFamilyMontserrat,
                        height: 0.018, fontWeight: FontWeight.w500)
                  ],
                )),
          ),
          SizedBox(
            height: Get.height * 0.020,
          ),
          Divider(
            height: 5,
            color: CommonFunctions.getThemeColor(light: AppColors.countBorderColor, dark: AppColors.darkDotsIndicatorColor),
          ),
          Spacer(),
          SizedBox(
            height: Get.height * 0.030,
          ),
          GestureDetector(
            onTap: (){
              commonPopup(context,ImageString.logoutPic,CommonFunctions.getThemeColor(light: AppColors.deleteTextColor, dark:  Colors.white),
                  ConstantStrings.logoutMsg,
                      (){
                    authController.logout();
                  });
            },
            child: Container(
              height: Get.height * 0.075,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Get.height*0.060)),
                color: AppColors.deleteRedColor,
                border: Border.all(width: 0, color: (Get.isDarkMode)?AppColors.darkBackgroundColor: AppColors.deleteTextColor),
              ),
              child:  Center(
                  child: Text(
                ConstantStrings.logout,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red,
                    fontSize:  Get.height*0.022,
                    fontFamily: ConstantStrings.fontFamilyMontserratSemiBold, fontWeight: FontWeight.w600),
              )),
            ),
          ),
          SizedBox(
            height: Get.height * 0.040,
          ),
        ],
      ),
    ));
  }
}
