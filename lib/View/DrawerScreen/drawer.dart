import 'dart:io';

import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Constants/ImageConstant.dart';
import 'package:field_vision/Controller/authController.dart';
import 'package:field_vision/Controller/drawer_Controller.dart';
import 'package:field_vision/Controller/settingController.dart';
import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:field_vision/utils/CommonFunctions.dart';
import 'package:field_vision/widgets/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Constants/ColorConstant.dart';
import '../../widgets/common_popup.dart';
import '../../widgets/drawer_list.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final authController=Get.put(AuthController());
  final drawerController=Get.put(DrawerControllers());
 @override
  void initState() {
    // TODO: implement initState

    super.initState();
    init();
  }
  init(){
    WidgetsBinding.instance
        .addPostFrameCallback((_) => drawerController.profile());
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.theme.backgroundColor,
        child: Padding(
          padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.040),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: Get.height*0.1,),
                 Obx(()=> Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.dottedBorderColor,
                      shape: BoxShape.circle,
                    ),
                  child: (drawerController.selectedImagePath!.value !='')?
                  CircleAvatar(
                    radius: Get.height*0.070,
                    child: ClipOval(child:
                    Image.file(File(drawerController.selectedImagePath.value),
                      height: Get.height * 0.14,
                      width: Get.width * 0.28,fit: BoxFit.fill ,)
                    ),
                  ):(drawerController.profileImage.value !="")?
                  ClipOval(child: Image.network(ConstantStrings.profileImageUrl+ drawerController.profileImage.value,  height: Get.height * 0.13,
                    width: Get.width * 0.25,fit: BoxFit.fill ,)):
                  SvgPicture.asset(ImageString.drawerDemoProfile,),
                  )),
                  SizedBox(height: Get.height*0.010,),
                  Obx(()=>AppText(text: drawerController.userName!.value,
                      fontFamily: ConstantStrings.fontFamilyMontserratBold,
                      height: 0.022, fontWeight: FontWeight.w500)),
                  SizedBox(height: Get.height*0.005,),
                Obx(()=>  AppText(text: drawerController.userEmail!.value,
                      fontFamily: ConstantStrings.fontFamilyMontserrat,
                      color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                      height: 0.020, fontWeight: FontWeight.w500)),
                  SizedBox(height: Get.height*0.025,),
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getProfileScreen());
                      },
                      child: DrawerList(text: ConstantStrings.profile,
                        image: ImageString.drawerProfile,)),
                  SizedBox(height: Get.height*0.025,),
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getSettingScreen())?.then((value) => {
                          setState((){})
                        });
                      },
                      child: DrawerList(text: ConstantStrings.settings,image: ImageString.drawerSetting,)),
                  SizedBox(height: Get.height*0.025,),
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getNotificationScreen());
                      },
                      child: DrawerList(
                        text: ConstantStrings.notifications,
                        image: ImageString.drawerNotification,)),
                  SizedBox(height: Get.height*0.025,),
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getHelpSupportScreen());
                      },
                      child: DrawerList(text: ConstantStrings.helpAndSupport,image: ImageString.drawerHelp,)),
                  SizedBox(height: Get.height*0.025,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: (){
                    commonPopup(context,ImageString.logoutPic,CommonFunctions.getThemeColor(light: AppColors.deleteTextColor, dark:  Colors.white),
                    ConstantStrings.logoutMsg,
                            (){
                      authController.logout();
                        });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageString.logoutPic,color: CommonFunctions.getThemeColor(light: AppColors.deleteTextColor, dark:  Colors.white),),
                      SizedBox(width: Get.width*0.025,),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: AppText(text: ConstantStrings.logout,
                              fontFamily: ConstantStrings.fontFamilyMontserrat,
                              color: CommonFunctions.getThemeColor(light: AppColors.deleteTextColor, dark:  Colors.white), height: 0.020, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
