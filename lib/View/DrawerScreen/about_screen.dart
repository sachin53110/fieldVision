import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/Controller/settingController.dart';
import 'package:field_vision/utils/CommonFunctions.dart';
import 'package:field_vision/widgets/appText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../widgets/appBarWidget.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final settingController=Get.put(SettingController());
  @override
  void initState() {
    super.initState();
    init();
  }
  init(){
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>  settingController.about());
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
                  text: ConstantStrings.aboutUs,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height*0.050,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(ImageString.splashImage,fit: BoxFit.scaleDown,height: Get.height*0.10,color: CommonFunctions.getThemeColor(light: Colors.black, dark: Colors.white),),
                            SizedBox(height: Get.height*0.005,),
                            AppText(text: "Version 1.4.5 build-1.0", height: 0.022, fontWeight: FontWeight.w500),
                            SizedBox(height: Get.height*0.010,),

                            Html(data: settingController.aboutText.value,defaultTextStyle: TextStyle(
                                  fontSize: Get.height*0.018,
                                  letterSpacing: 1.2,
                                  fontFamily: ConstantStrings.fontFamilyMontserrat,
                                  color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500
                            ),),

                            SizedBox(height: Get.height*0.020,),
                            // AppText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula laoreet rutrum. Nam sed eros turpis. Donec convallis erat dolor, eu congue leo facilisis quis. Nunc dui massa, bibendum at congue vitae, efficitur id metus. Donec tristique purus ut tellus semper volutpat. Phasellus auctor pretium tincidunt. Curabitur at tempor velit. Donec lobortis gravida erat at scelerisque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                            //     height: 0.018,
                            //     fontFamily: ConstantStrings.fontFamilyMontserrat,
                            //     color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                            // SizedBox(height: Get.height*0.020,),
                            // AppText(text: "Nunc volutpat non augue ut pharetra. Sed placerat est vitae nisi venenatis hendrerit. Praesent et mi sapien. Suspendisse bibendum, odio eget tristique feugiat, justo nisi mattis velit, eu vehicula purus massa non lectus. Pellentesque vehicula tortor eget enim gravida, quis porta arcu venenatis. Suspendisse metus lacus, interdum sodales enim sed, hendrerit vulputate enim. Quisque aliquet tempor pharetra. Nam mattis ultrices nisl ut interdum. Pellentesque at nibh purus. Ut nec hendrerit odio. Phasellus justo nisl, consequat quis mattis sit amet, ornare non leo.Morbi at ex dignissim.",
                            //     height: 0.018,
                            //     fontFamily: ConstantStrings.fontFamilyMontserrat,
                            //     color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                            // SizedBox(height: Get.height*0.020,),
                            // AppText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula laoreet rutrum. Nam sed eros turpis. Donec convallis erat dolor, eu congue leo facilisis quis. Nunc dui massa, bibendum at congue vitae, efficitur id metus. Donec tristique purus ut tellus semper volutpat. Phasellus auctor pretium tincidunt. Curabitur at tempor velit. Donec lobortis gravida erat at scelerisque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                            //
                            //     fontFamily: ConstantStrings.fontFamilyMontserrat,  height: 0.018, color:CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                            // SizedBox(height: Get.height*0.020,),
                            // AppText(text: "Nunc volutpat non augue ut pharetra. Sed placerat est vitae nisi venenatis hendrerit. Praesent et mi sapien. Suspendisse bibendum, odio eget tristique feugiat, justo nisi mattis velit, eu vehicula purus massa non lectus. Pellentesque vehicula tortor eget enim gravida, quis porta arcu venenatis. Suspendisse metus lacus, interdum sodales enim sed, hendrerit vulputate enim. Quisque aliquet tempor pharetra. Nam mattis ultrices nisl ut interdum. Pellentesque at nibh purus. Ut nec hendrerit odio. Phasellus justo nisl, consequat quis mattis sit amet, ornare non leo.Morbi at ex dignissim.",
                            //     fontFamily: ConstantStrings.fontFamilyMontserrat,   height: 0.020, color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                            // SizedBox(height: Get.height*0.020,),
                            // AppText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula laoreet rutrum. Nam sed eros turpis. Donec convallis erat dolor, eu congue leo facilisis quis. Nunc dui massa, bibendum at congue vitae, efficitur id metus. Donec tristique purus ut tellus semper volutpat. Phasellus auctor pretium tincidunt. Curabitur at tempor velit. Donec lobortis gravida erat at scelerisque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                            //     fontFamily: ConstantStrings.fontFamilyMontserrat,  height: 0.018, color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
                            // SizedBox(height: Get.height*0.020,),
                            // AppText(text: "Nunc volutpat non augue ut pharetra. Sed placerat est vitae nisi venenatis hendrerit. Praesent et mi sapien. Suspendisse bibendum, odio eget tristique feugiat, justo nisi mattis velit, eu vehicula purus massa non lectus. Pellentesque vehicula tortor eget enim gravida, quis porta arcu venenatis. Suspendisse metus lacus, interdum sodales enim sed, hendrerit vulputate enim. Quisque aliquet tempor pharetra. Nam mattis ultrices nisl ut interdum. Pellentesque at nibh purus. Ut nec hendrerit odio. Phasellus justo nisl, consequat quis mattis sit amet, ornare non leo.Morbi at ex dignissim.",
                            //     fontFamily: ConstantStrings.fontFamilyMontserrat,  height: 0.018, color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor) ,fontWeight: FontWeight.w500),
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
