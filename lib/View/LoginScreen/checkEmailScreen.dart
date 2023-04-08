import 'package:field_vision/Controller/authController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_mail_app/open_mail_app.dart';
import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/appYellowButton.dart';

class CheckEmailScreen extends StatefulWidget {
  String? email;
  CheckEmailScreen({Key? key,this.email}) : super(key: key);

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  final authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SingleChildScrollView(
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
                    text: "",
                  ),
                  SizedBox(
                      height: Get.height*0.75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                              alignment:Alignment.center,
                              child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkCheckEmail: ImageString.checkEmail)),
                          SizedBox(height: Get.height*0.040,),
                          AppText(text: ConstantStrings.checkYourEmail,
                              height: 0.032,
                              fontFamily: ConstantStrings.fontFamilyMontserratBold,
                              fontWeight: FontWeight.w700),
                          SizedBox(height: Get.height*0.010,),
                          AppText(text: ConstantStrings.passwordResetLink,
                              height: 0.020,
                              fontFamily: ConstantStrings.fontFamilyMontserrat,
                              textAlign: TextAlign.center,
                              color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                              fontWeight: FontWeight.w500),
                          SizedBox(height: Get.height*0.005,),
                          AppText(text: widget.email!,
                              height: 0.020,
                              fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500),
                          SizedBox(height:  Get.height*0.050,),
                          GestureDetector(
                            onTap: ()async{
                              var result = await OpenMailApp.openMailApp();
                              if (!result.didOpen && !result.canOpen) {
                                showNoMailAppsDialog(context);
                              } else if (!result.didOpen && result.canOpen) {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return MailAppPickerDialog(
                                      mailApps: result.options,
                                    );
                                  },
                                );
                              }
                            },
                            child: AppYellowButton(
                              height: 0.075,
                              width: Get.width,
                              fontSize: 0.022,
                              borderRadius: 25,
                              textColor: Colors.black,
                              text: ConstantStrings.openEmailApp,
                              color:  AppColors.appYellowColor,
                              borderWidth: 0,
                              borderColor: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                            ),
                          ),
                        ],
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        // style: DefaultTextStyle.of(context).style,
                        children:  <TextSpan>[
                          TextSpan(text: ConstantStrings.receiveEmail, style: TextStyle(
                              fontFamily: ConstantStrings.fontFamilyMontserrat
                              ,fontWeight: FontWeight.w500,
                              fontSize: Get.height*0.018,
                              color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor))),
                          TextSpan(text: ConstantStrings.clickResend,style: TextStyle(
                            fontFamily: ConstantStrings.fontFamilyMontserratSemiBold
                            ,fontWeight: FontWeight.w500,
                            fontSize: Get.height*0.018,
                            color: CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white) ,decoration: TextDecoration.underline,),
                              recognizer:  TapGestureRecognizer()
                                ..onTap = (){
                            authController.forgotPassword(context,widget.email!, 0);
                                  //Get.toNamed(RouteHelper.getSignUpPage());
                                }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height*0.030,),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
