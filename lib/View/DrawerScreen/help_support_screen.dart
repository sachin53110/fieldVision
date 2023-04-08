import 'package:field_vision/Controller/drawer_Controller.dart';
import 'package:field_vision/Controller/helpAndSupportController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appTextField.dart';
import '../../widgets/appYellowButton.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final helpAndSupportController = Get.put(HelpAndSupportController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(left: Get.width * 0.050, right: Get.width * 0.050),
          child: Form(
            key: helpAndSupportController.subjectDescriptionFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.060,
                ),
                AppBarWidget(
                  text: ConstantStrings.helpAndSupport,
                ),
                SizedBox(
                  height: Get.height * 0.040,
                ),
                TextFormField(
                  validator: (value){
                    return helpAndSupportController.validationSubject(value!);
                  },
                  textAlign: TextAlign.start,
                  controller: helpAndSupportController.helperSupportSubject,
                  style: TextStyle(
                    fontFamily: ConstantStrings.fontFamilyMontserrat,
                    color: CommonFunctions.getThemeColor(light: Colors.black, dark: Colors.white),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),
                      ), //<-- SEE HERE
                    ),
                    filled: true, //<-- SEE HERE
                    fillColor: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackButtonColor),
                    hintText: "Subject",
                    hintStyle: TextStyle(
                        color: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                        fontFamily: ConstantStrings.fontFamilyMontserrat,
                        fontSize: Get.height * 0.020),
                    prefixIcon: SvgPicture.asset(
                      ImageString.helpSubjectIcon,
                      fit: BoxFit.scaleDown,
                      color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),
                    ),

                    contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.022, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.grayColor, width: 2),
                    ),
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.020,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackButtonColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border:  Border.all(width: 1, color: (Get.isDarkMode)?AppColors.darkBackgroundColor:AppColors.grayColor,
                        )),
                    child:
                      Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 15,left: 15),
                            child: SvgPicture.asset(
                              ImageString.helpDescription,
                              color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),
                            )),
                        Expanded(
                          child: Padding(
                            padding:  EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              // validator: (value){
                              //   return helpAndSupportController.validationDescription(value!);
                              // },
                              maxLines: 50,
                               maxLength: 200,
                              //minLines: (Get.height*0.0265).toInt(),
                              controller: helpAndSupportController.helperSupportDescription,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(10),
                                //   borderSide: BorderSide(
                                //     color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),
                                //   ), //<-- SEE HERE
                                // ),
                                filled: true, //<-- SEE HERE
                                fillColor: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackButtonColor),
                                // prefixIcon: Padding(
                                //     padding: EdgeInsets.all(15),
                                //     child: SvgPicture.asset(
                                //       ImageString.helpDescription,
                                //       color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),
                                //     )),
                                hintText: "Description",
                                hintStyle: TextStyle(
                                    fontFamily: ConstantStrings.fontFamilyMontserrat,
                                    color: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                                    fontSize: Get.height * 0.020),
                                // contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(10),
                                //   borderSide: BorderSide(color: Colors.white, width: 0),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              // Obx (()=> (helpAndSupportController.checkDescriptionVal!.value==false)? Padding(
              //     padding: const  EdgeInsets.only(top:5,left: 5),
              //     child: Text("Description field is required",style: TextStyle(
              //       fontSize: Get.height*0.016,
              //       color: Colors.red
              //     ),),
              //   ):Container()),
                SizedBox(
                  height: Get.height * 0.030,
                ),
                GestureDetector(
                  onTap: (){
                    if(helpAndSupportController.subjectDescriptionFormKey.currentState!.validate()){
                      helpAndSupportController.helpAndSupport(helpAndSupportController.helperSupportSubject.text,
                          helpAndSupportController.helperSupportDescription.text);
                    }

                  },
                  child: AppYellowButton(
                    height: 0.075,
                    width: Get.width,
                    borderRadius: 20,
                    fontSize: 0.022,
                    textColor: Colors.black,
                    text: ConstantStrings.submit,
                    color: AppColors.appYellowColor,
                    borderWidth: 0,
                    borderColor: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.020,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
