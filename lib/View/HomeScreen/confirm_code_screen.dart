import 'package:field_vision/Controller/new_submission_controller.dart';
import 'package:field_vision/widgets/error_msg_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../Controller/home_page_controller.dart';
import '../../RouteHelper/route_helper.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/appTextField.dart';
import '../../widgets/appYellowButton.dart';

class ConfirmCodeScreen extends StatefulWidget {
  String? serialNumber;
  ConfirmCodeScreen({Key? key,this.serialNumber}) : super(key: key);

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  final homeController=Get.put(HomePageController());
 final newSubmissionController=Get.put(NewSubmissionController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newSubmissionController.confirmTextController.text="";
   // newSubmissionController.confirmTextController.text=widget.serialNumber!;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: context.theme.backgroundColor,

      body: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkHomeTopIcon: ImageString.homeTopIcon,)),
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
                            (Get.isDarkMode)? SvgPicture.asset(ImageString.darkConifmKioskIcon):Image.asset(ImageString.kisokImage,height: Get.height*0.13,),
                            SizedBox(height: Get.height*0.020,),
                            AppText(text: ConstantStrings.confirmKiosk,
                                height: 0.032,
                                fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                fontWeight: FontWeight.w700),
                            SizedBox(height: Get.height*0.020,),
                            AppText(text: ConstantStrings.confirmKioskDescription,
                              height: 0.021,
                              fontFamily: ConstantStrings.fontFamilyMontserrat,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500,
                              color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                            ),
                            SizedBox(height: Get.height*0.025,),
                            TextFormField(
                              controller:  newSubmissionController.confirmTextController,
                              // onChanged: (val){
                              //    val=homeController.confirmTextController.text;
                              //    if(val.isNotEmpty){
                              //
                              //    }
                              //   // if(val.length>=4){
                              //   //   // Get.snackbar(
                              //   //   //   "",
                              //   //   //   "Display the message here",
                              //   //   //   colorText: Colors.white,
                              //   //   //   backgroundColor: Colors.lightBlue,
                              //   //   //   icon: const Icon(Icons.add_alert),
                              //   //   // );
                              //   //   Get.toNamed(RouteHelper.getKioskVerificationScreen());
                              //   // }
                              // },
                              style: TextStyle(
                                  color: CommonFunctions.getThemeColor(light: Colors.black, dark: Colors.white)),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),), //<-- SEE HERE
                                ),
                                filled: true, //<-- SEE HERE
                                fillColor: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackButtonColor),
                                hintText:ConstantStrings.kioskSerialNumber,
                                hintStyle: TextStyle(
                                  fontSize: Get.height*0.020   ,
                                  color:  CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                                  fontFamily: ConstantStrings.fontFamilyMontserrat,
                                ),
                                prefixIcon: SvgPicture.asset( ImageString.barCodeIcon,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor)),
                                contentPadding:
                                 EdgeInsets.symmetric(
                                    vertical: Get.height*0.022,
                                    horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.grayColor,
                                      width: 2),
                                ),
                              ),
                            ),



                          ],
                        )),
                    SizedBox(height: Get.height*0.025,),

                    GestureDetector(
                      onTap: (){
                        if(newSubmissionController.confirmTextController.text.isNotEmpty){
                          newSubmissionController.verifyKiosk(context,newSubmissionController.confirmTextController.text);
                        }else{
                          commonErrorPopup(context, "Kiosk serial number is required", "");
                        }

                      },
                      child: AppYellowButton(
                        height: 0.075,
                        width: Get.width,
                        fontSize: 0.022,
                        borderRadius: Get.height*0.060,
                        textColor: Colors.black,
                        text: ConstantStrings.submit,
                        color:  AppColors.appYellowColor,
                        borderWidth: 0,
                        borderColor: Colors.white,
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
