import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Controller/authController.dart';
import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/View/LoginScreen/checkEmailScreen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ImageConstant.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/appTextField.dart';
import '../../widgets/appYellowButton.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}


class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final authController=Get.put(AuthController());
  FirebaseDynamicLinks dynamicLinks=FirebaseDynamicLinks.instance;
  // Future<void> initDynamicLinks()async{
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     Get.toNamed(RouteHelper.login);
  //     // final Uri uri=dynamicLinkData.link;
  //     // final queryParams=uri.queryParameters;
  //     // if(queryParams.isNotEmpty){
  //     //   Get.toNamed(RouteHelper.login);
  //     // }
  //     // else{
  //     //   Get.toNamed(RouteHelper.signUp);
  //     // }
  //   }).onError((error){
  //     Get.toNamed(RouteHelper.signUp);
  //   });
  // }
  // Uri? shortUriLink;
  // Future<void> createDynamicLink(String link) async{
  //   final DynamicLinkParameters parameters=DynamicLinkParameters(
  //       link: Uri.parse(ConstantStrings.fieldVisionDynamicLink+link),
  //       uriPrefix: ConstantStrings.fieldVisionDynamicLink,
  //   androidParameters: AndroidParameters(
  //     packageName: "com.example.field_vision",
  //     minimumVersion: 0
  //   ));
  //   final ShortDynamicLink shortLink=await dynamicLinks.buildShortLink(parameters);
  //   shortUriLink=shortLink.shortUrl;
  // }
@override
  void initState() {
    // TODO: implement initState
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    //await initDynamicLinks();
  });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: authController.forgetPasswordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkTopLoginDesign: ImageString.topLoginDesign,)),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Column(
                  children: [
                    AppBarWidget(
                      text: ConstantStrings.forgotPassword,
                    ),
                    SizedBox(
                        height: Get.height*0.75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                                alignment:Alignment.center,
                                child: SvgPicture.asset((Get.isDarkMode)?ImageString.
                                darkPasswordIcon: ImageString.passwordIcon,
                                height: Get.height*0.145,)),
                            SizedBox(height: Get.height*0.040,),

                            Container(
                              width: Get.width*0.8,
                              child: AppText(text: ConstantStrings.noWorriesMsg,
                                  height: 0.022,
                                  fontFamily: ConstantStrings.fontFamilyMontserrat,
                                  textAlign: TextAlign.center,
                                  color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: Colors.white),
                                  fontWeight: FontWeight.w500),
                            ),

                            SizedBox(height:  Get.height*0.030,),
                            AppTextField(
                              validator: (value){
                                return authController.validationEmail(value!);
                              },
                              textColor: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                              hintText: ConstantStrings.email,
                              prefixIcon: SvgPicture.asset(ImageString.email,fit: BoxFit.scaleDown,

                                color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),
                              textController: authController.forgotPasswordText,
                            ),
                            SizedBox(height:  Get.height*0.050,),
                            GestureDetector(
                              onTap: (){

                                if(authController.forgetPasswordFormKey.currentState!.validate()){
                                  authController.forgotPassword(context,authController.forgotPasswordText.text,1);
                                }

                              },
                              child: AppYellowButton(
                                height: 0.075,
                                fontSize: 0.025,
                                width: Get.width,
                                borderRadius: 22,
                                textColor: Colors.black,
                                text: ConstantStrings.send,
                                color:  AppColors.appYellowColor,
                                borderWidth: 0,
                                borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                              ),
                            ),
                          ],
                        )),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
