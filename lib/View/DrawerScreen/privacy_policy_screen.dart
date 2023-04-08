import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Controller/settingController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ImageConstant.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  String? changeTermAndPolicy;
   PrivacyPolicyScreen({Key? key,this.changeTermAndPolicy}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final settingController=Get.put(SettingController());

  @override
  void initState() {
    super.initState();
    init();
  }
  init(){
    (widget.changeTermAndPolicy=="Privacy Policy")? WidgetsBinding.instance
        .addPostFrameCallback((_) =>  settingController.privacyPolicy()):
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>  settingController.termAndCondition());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Obx(() {
          return Padding(
            padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.050),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkHomeTopIcon: ImageString.homeTopIcon,)),
                SizedBox(height: Get.height*0.020,),
                AppBarWidget(

                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height*0.030,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(text:widget.changeTermAndPolicy!,
                                fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                height: 0.024, fontWeight: FontWeight.w700),
                            SizedBox(height: Get.height*0.010,),
                            (widget.changeTermAndPolicy=="Privacy Policy")?
                                Html(data: settingController.privacyPolicyText.value,defaultTextStyle: TextStyle(
                                    fontSize: Get.height*0.018,
                                    letterSpacing: 1.2,
                                    fontFamily: ConstantStrings.fontFamilyMontserrat,  color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500)
                                ):
                                Html(data: settingController.termAndConditionsText.value,defaultTextStyle: TextStyle(
                                    fontSize: Get.height*0.018,
                                    letterSpacing: 1.2,
                                    fontFamily: ConstantStrings.fontFamilyMontserrat,  color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500
                                ),)
                          //   AppText(text: "Last updated 23 February 2022",
                          //       fontFamily: ConstantStrings.fontFamilyMontserrat,
                          //       height: 0.018,
                          //       color: CommonFunctions.getThemeColor(light: Colors.black, dark: Colors.white) ,fontWeight: FontWeight.w500),
                          //   SizedBox(height: Get.height*0.020,),
                          //   AppText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula laoreet rutrum. Nam sed eros turpis. Donec convallis erat dolor, eu congue leo facilisis quis. Nunc dui massa, bibendum at congue vitae, efficitur id metus. Donec tristique purus ut tellus semper volutpat. Phasellus auctor pretium tincidunt. Curabitur at tempor velit. Donec lobortis gravida erat at scelerisque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                          //       fontFamily: ConstantStrings.fontFamilyMontserrat,  height: 0.018, color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                          //   SizedBox(height: Get.height*0.020,),
                          //   AppText(text: "Nunc volutpat non augue ut pharetra. Sed placerat est vitae nisi venenatis hendrerit. Praesent et mi sapien. Suspendisse bibendum, odio eget tristique feugiat, justo nisi mattis velit, eu vehicula purus massa non lectus. Pellentesque vehicula tortor eget enim gravida, quis porta arcu venenatis. Suspendisse metus lacus, interdum sodales enim sed, hendrerit vulputate enim. Quisque aliquet tempor pharetra. Nam mattis ultrices nisl ut interdum. Pellentesque at nibh purus. Ut nec hendrerit odio. Phasellus justo nisl, consequat quis mattis sit amet, ornare non leo.Morbi at ex dignissim.",
                          //       fontFamily: ConstantStrings.fontFamilyMontserrat,  height: 0.018, color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                          //   SizedBox(height: Get.height*0.020,),
                          //   AppText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula laoreet rutrum. Nam sed eros turpis. Donec convallis erat dolor, eu congue leo facilisis quis. Nunc dui massa, bibendum at congue vitae, efficitur id metus. Donec tristique purus ut tellus semper volutpat. Phasellus auctor pretium tincidunt. Curabitur at tempor velit. Donec lobortis gravida erat at scelerisque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                          //       fontFamily: ConstantStrings.fontFamilyMontserrat,  height: 0.018, color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                          //   SizedBox(height: Get.height*0.020,),
                          //   AppText(text: "Nunc volutpat non augue ut pharetra. Sed placerat est vitae nisi venenatis hendrerit. Praesent et mi sapien. Suspendisse bibendum, odio eget tristique feugiat, justo nisi mattis velit, eu vehicula purus massa non lectus. Pellentesque vehicula tortor eget enim gravida, quis porta arcu venenatis. Suspendisse metus lacus, interdum sodales enim sed, hendrerit vulputate enim. Quisque aliquet tempor pharetra. Nam mattis ultrices nisl ut interdum. Pellentesque at nibh purus. Ut nec hendrerit odio. Phasellus justo nisl, consequat quis mattis sit amet, ornare non leo.Morbi at ex dignissim.",
                          //       fontFamily: ConstantStrings.fontFamilyMontserrat, height: 0.018, color:CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                          //   SizedBox(height: Get.height*0.020,),
                          //   AppText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula laoreet rutrum. Nam sed eros turpis. Donec convallis erat dolor, eu congue leo facilisis quis. Nunc dui massa, bibendum at congue vitae, efficitur id metus. Donec tristique purus ut tellus semper volutpat. Phasellus auctor pretium tincidunt. Curabitur at tempor velit. Donec lobortis gravida erat at scelerisque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                          //       fontFamily: ConstantStrings.fontFamilyMontserrat, height: 0.018, color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                          //   SizedBox(height: Get.height*0.020,),
                          //   AppText(text: "Nunc volutpat non augue ut pharetra. Sed placerat est vitae nisi venenatis hendrerit. Praesent et mi sapien. Suspendisse bibendum, odio eget tristique feugiat, justo nisi mattis velit, eu vehicula purus massa non lectus. Pellentesque vehicula tortor eget enim gravida, quis porta arcu venenatis. Suspendisse metus lacus, interdum sodales enim sed, hendrerit vulputate enim. Quisque aliquet tempor pharetra. Nam mattis ultrices nisl ut interdum. Pellentesque at nibh purus. Ut nec hendrerit odio. Phasellus justo nisl, consequat quis mattis sit amet, ornare non leo.Morbi at ex dignissim.",
                          //       fontFamily: ConstantStrings.fontFamilyMontserrat,  height: 0.018, color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                          ],
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          );
        }
      ),
    );
  }
}
