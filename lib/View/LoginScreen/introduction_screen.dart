import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Constants/ImageConstant.dart';
import 'package:field_vision/Controller/home_page_controller.dart';
import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/View/LoginScreen/loginScreen.dart';
import 'package:field_vision/View/LoginScreen/signUpScreen.dart';
import 'package:field_vision/utils/CommonFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Model/tutorialModel.dart';
import '../../widgets/appYellowButton.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  CarouselController buttonCarouselController = CarouselController();

  RxInt? corrousalCount = 0.obs;

  final homeController=Get.put(HomePageController());

  @override
  void initState() {
    // TODO: implement
    //  initState
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>  homeController.introPageContents());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // homeController.updateData();
    return Obx(()=> Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body:Column(
        children: [
          CarouselSlider(
            items: homeController.content
                .map((item) => Column(
                  children: [
                    SizedBox(height: Get.height*0.030,),
                    SvgPicture.network(
                     ConstantStrings.introImageUrl+((Get.isDarkMode)?item.darkImage.toString(): item.lightImage.toString()),
                      height: Get.height*0.5,
                    ),
                    SizedBox(height: Get.height*0.040,),
                    Container(
                    width: Get.width,
                    height: Get.height * 0.030,
                    alignment: Alignment.topCenter,
                    child: Text(
                      item.title.toString(),
                      style: TextStyle(
                          fontFamily: ConstantStrings.fontFamilyMontserratBold,
                          color: CommonFunctions.getThemeColor(
                              light: Colors.black, dark: Colors.white)
                          , fontSize: Get.height * 0.024,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: Get.height*0.010,),
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.only(left: 30, right: 30, top: Get.height*0.005),
                    child:
                    
                    Text(item.description.toString(),style: TextStyle(
                     fontFamily: ConstantStrings.fontFamilyMontserrat,
                      fontSize: Get.height*0.018,
                      fontWeight:  FontWeight.w400,
                      height: 1.2,
                      color: CommonFunctions.getThemeColor(
                                       light:  AppColors.grayColor,
                                       dark: AppColors.darkDotsIndicatorColor),
                    ),textAlign: TextAlign.center,)
                   //  Html(data: item.description.toString()  ,
                   //    defaultTextStyle: TextStyle(
                   //
                   // fontFamily: ConstantStrings.fontFamilyMontserrat,
                   //    fontWeight: FontWeight.w400,
                   //    fontSize: Get.height * 0.018,
                   //    color: CommonFunctions.getThemeColor(
                   //                light:  AppColors.grayColor,
                   //                dark: AppColors.darkDotsIndicatorColor),
                   //    height: 1.5,
                   //  ),)

                    // Text(
                    //   item.description.toString(),
                    //   style: TextStyle(
                    //       fontFamily: ConstantStrings.fontFamilyMontserrat,
                    //       color: CommonFunctions.getThemeColor(
                    //           light:  AppColors.grayColor,
                    //           dark: AppColors.darkDotsIndicatorColor),
                    //       height: 1.5,
                    //
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: Get.height * 0.018),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                  ],
                ))
                .toList(),
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: Get.height*0.81,
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: (Get.width / Get.height) * 1.9,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  setState(() {
                    corrousalCount!.value = index;
                  });
                }),
          ),
          SizedBox(height: Get.height*0.010,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DotsIndicator(
                dotsCount: homeController.content.length,
                position: corrousalCount!.value.toDouble(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(25.0, 8.0),
                  activeColor: Colors.black,
                  color: CommonFunctions.getThemeColor(light: AppColors.dotsIndicatorColor, dark: AppColors.darkDotsIndicatorColor),
                  spacing: EdgeInsets.all(2),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              SizedBox(height: Get.height*0.040,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getSignUpPage());
                    },
                    child: AppYellowButton(
                      height: 0.075,
                      width: 0.4,
                      fontSize: 0.022,
                      borderRadius: 15,
                      textColor:Colors.black,
                      text: ConstantStrings.signUp,
                      color:  AppColors.appYellowColor,
                      borderWidth: 0,
                      borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.020,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getLogin());
                    },
                    child: AppYellowButton(
                      height: 0.075,
                      width: 0.4,
                      borderRadius: 15,
                      fontSize: 0.022,
                      text: ConstantStrings.login,
                      color:  context.theme.backgroundColor,
                      borderWidth: 1,
                      borderColor:CommonFunctions.getThemeColor(light: Colors.black, dark: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: Get.width,
                height: Get.height * 0.040,
              ),
            ],
          ),
        ],
      ),
    ));

  }

  Widget crosal(TutorialModel item){
   return Column(

   );
  }
}
class Indicator extends StatelessWidget{
  RxBool? isActive=false.obs;
   Indicator({
     Key? key,
    this.isActive

}):super(key: key);
  @override
  Widget build(BuildContext context){
    return  Container(
      width: (isActive!.value) ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
          color: (isActive!.value) ?Colors.red:Colors.grey,
          borderRadius: BorderRadius.circular(8)

      ),
    );
  }
}