import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/appYellowButton.dart';

class KioskVerificationScreen extends StatefulWidget {
  String? kioskTitle;
  String? kioskId;
  KioskVerificationScreen({Key? key,this.kioskTitle,this.kioskId}) : super(key: key);

  @override
  State<KioskVerificationScreen> createState() => _KioskVerificationScreenState();
}

class _KioskVerificationScreenState extends State<KioskVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(   (Get.isDarkMode)?ImageString.darkHomeTopIcon: ImageString.homeTopIcon,)),
              SizedBox(height: Get.height*0.020,),
              Padding(
                padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.050),
                child: Column(
                  children: [
                    AppBarWidget(
                      text: ConstantStrings.newSubmission,
                    ),
                    SizedBox(
                        height: Get.height*0.70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset((Get.isDarkMode)?ImageString.darkKioskVerifyIcon: ImageString.kioskVerifyIcon),
                            SizedBox(height: Get.height*0.030,),
                            AppText(text: widget.kioskTitle!,
                                height: 0.032,
                                fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                fontWeight: FontWeight.w700),
                            SizedBox(height: Get.height*0.020,),
                            AppText(text: ConstantStrings.kioskDiscription,
                              height: 0.021,
                              fontFamily: ConstantStrings.fontFamilyMontserrat,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500,
                              color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                            ),
                            SizedBox(height: Get.height*0.010,),
                          ],
                        )),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getInspectKioskScreen());
                          //Get.toNamed(RouteHelper.getKioskDamageVerifyScreen());
                      },
                      child: AppYellowButton(
                        height: 0.075,
                        width: Get.width,
                        fontSize: 0.022,
                        borderRadius: Get.height*0.060,
                        textColor: Colors.black,
                        text: ConstantStrings.addNewPhotos,
                        color:  AppColors.appYellowColor,
                        borderWidth: 0,
                        borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          ),
    );
  }
}
