import 'package:dotted_border/dotted_border.dart';
import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Controller/damage_report_controller.dart';
import 'package:field_vision/Controller/home_page_controller.dart';
import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ImageConstant.dart';
import '../../services/prefs.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/appYellowButton.dart';

class ReviewSubmissionScreen extends StatefulWidget {
  String? submissionId;
  ReviewSubmissionScreen({Key? key,this.submissionId}) : super(key: key);

  @override
  State<ReviewSubmissionScreen> createState() => _ReviewSubmissionScreenState();
}

class _ReviewSubmissionScreenState extends State<ReviewSubmissionScreen> {
  
  final damageController=Get.put(DamageReportController());
  final homeController=Get.put(HomePageController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => damageController.reviewSubmission(widget.submissionId!));
    kioskSerialNumber=Prefs.getString("kioskSerialNumber")!;
  }
  String kioskSerialNumber="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: Padding(
            padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.050),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    (Get.isDarkMode)?ImageString.darkHomeTopIcon: ImageString.homeTopIcon,
                  )),
              SizedBox(
                height: Get.height * 0.020,
              ),
              AppBarWidget(
                text: "Submission ${kioskSerialNumber.toString()}",
              ),
              Expanded(child: SingleChildScrollView(child: Column(
                children: [
                  SizedBox(height: Get.height*0.040,),
                  Align(
                      alignment: Alignment.center,
                      child: (Get.isDarkMode)? SvgPicture.asset(ImageString.darkConifmKioskIcon):Image.asset(ImageString.kisokImage,height: Get.height*0.12,)),
                  SizedBox(height: Get.height*0.020,),
                  AppText(text: ConstantStrings.reviewSubmission,
                      fontFamily: ConstantStrings.fontFamilyMontserratBold,
                      height: 0.032, fontWeight: FontWeight.w700),
                  SizedBox(height: Get.height*0.010,),
                  Container(
                    width: Get.width*0.8,
                    child: AppText(text: ConstantStrings.reviewInspectionDetails,
                        fontFamily: ConstantStrings.fontFamilyMontserrat,
                        height: 0.020,textAlign: TextAlign.center, color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: Get.height*0.040,),
                  Container(
                    margin: EdgeInsets.only(bottom: Get.height*0.020),
                    padding: EdgeInsets.only(bottom: Get.height*0.020),
                    width: Get.width,
                    decoration: BoxDecoration(
                        color:CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height*0.020,),
                        AppText(text: ConstantStrings.kioskInformation,
                            height: 0.022,
                            fontFamily: ConstantStrings.fontFamilyMontserratBold,
                            fontWeight: FontWeight.w600),
                        SizedBox(height: Get.height*0.020,),
                        Container(
                          margin: EdgeInsets.only(right: 15,left: 15),
                          padding: EdgeInsets.all(15),
                          height: Get.height*0.15,
                          decoration: BoxDecoration(
                              border: Border.all(color: (Get.isDarkMode)?AppColors.darkBackgroundColor: AppColors.countBorderColor,width: 1),
                              color:  context.theme.backgroundColor,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  AppText(text: "Kiosk Confirmed",
                                      height: 0.020,
                                      fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                      fontWeight: FontWeight.w600),
                                  Row(

                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: Get.height*0.010,),
                                          AppText(text: "Kiosk SN:  ",
                                              height: 0.018,
                                              color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                              fontFamily: ConstantStrings.fontFamilyMontserrat,
                                              fontWeight: FontWeight.w400),
                                          AppText(text: "Brand:  ",
                                              height: 0.018,
                                              color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                              fontFamily: ConstantStrings.fontFamilyMontserrat,
                                              fontWeight: FontWeight.w400),
                                          AppText(text: "Location:  ",
                                              height: 0.018,
                                              fontFamily: ConstantStrings.fontFamilyMontserrat,
                                              color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                              fontWeight: FontWeight.w400),
                                        ],
                                      ),
                                  Obx(()=>    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: Get.height*0.010,),
                                        AppText(text: damageController.kioskSerialNumber!.value,
                                            height: 0.020,
                                            color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                            fontFamily: ConstantStrings.fontFamilyMontserrat,
                                            fontWeight: FontWeight.w600),
                                        AppText(text: damageController.brand!.value,
                                            height: 0.018,
                                            fontFamily: ConstantStrings.fontFamilyMontserrat,
                                            color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                            fontWeight: FontWeight.w400),
                                        AppText(text: damageController.location!.value,
                                            color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                            height: 0.018,
                                            fontFamily: ConstantStrings.fontFamilyMontserrat,
                                            fontWeight: FontWeight.w400),
                                      ],))
                                    ],
                                  ),
                                  // AppText(text: "Kiosk Confirmed",
                                  //     height: 0.020,
                                  //     fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                  //     fontWeight: FontWeight.w600),
                                  // SizedBox(height: Get.height*0.010,),
                                  // AppText(text: "Kiosk SN:  11383",
                                  //     height: 0.018,
                                  //     fontFamily: ConstantStrings.fontFamilyMontserrat,
                                  //     fontWeight: FontWeight.w400),
                                  // AppText(text: "Brand:  Sam’s Club",
                                  //     height: 0.018,
                                  //     fontFamily: ConstantStrings.fontFamilyMontserrat,
                                  //     fontWeight: FontWeight.w400),
                                  // AppText(text: "Location:  Denton",
                                  //     height: 0.018,
                                  //     fontFamily: ConstantStrings.fontFamilyMontserrat,
                                  //     fontWeight: FontWeight.w400),
                                ],
                              ),
                              SvgPicture.asset((Get.isDarkMode)?ImageString.darkConfirmedIcon: ImageString.confirmedIcon,
                              fit: BoxFit.scaleDown,
                                height: Get.height*0.070,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height*0.020,),
                        Container(
                          margin: EdgeInsets.only(right: 15,left: 15),
                          padding: EdgeInsets.all(15),
                          height: Get.height*0.185,
                          width: Get.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: (Get.isDarkMode)?AppColors.darkBackgroundColor: AppColors.countBorderColor,width: 1),
                              color: context.theme.backgroundColor,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: ConstantStrings.inspectionInformation,
                                  height: 0.020,
                                  fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                  fontWeight: FontWeight.w600),
                              SizedBox(height: Get.height*0.020,),
                            Obx(()=>  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(color: CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor),
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: DottedBorder(
                                      color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: Colors.black),
                                      dashPattern: [10, 10],
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.network(ConstantStrings.submissionImageUrl+ damageController.rightImage!.value,
                                          fit: BoxFit.fill,width: Get.width*0.19,height: Get.height*0.080,),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(color: CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor),
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: DottedBorder(
                                      color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: Colors.black),
                                      dashPattern: [10, 10],
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.network(ConstantStrings.submissionImageUrl+ damageController.leftImage!.value,
                                          fit: BoxFit.fill,width: Get.width*0.19,height: Get.height*0.080,),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(color: CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor),
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: DottedBorder(
                                      color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: Colors.black),
                                      dashPattern: [10, 10],
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.network(ConstantStrings.submissionImageUrl+ damageController.middleImage!.value,
                                          fit: BoxFit.fill,width: Get.width*0.19,height: Get.height*0.080,),
                                      ),
                                    ),
                                  ),
                                  // // SvgPicture.asset((Get.isDarkMode)?ImageString.darkImageInfo: ImageString.imageInfo,
                                  // // fit: BoxFit.scaleDown,width: Get.width*0.11,height: Get.height*0.083,
                                  // // ),
                                  // Image.network(ConstantStrings.submissionImageUrl+ damageController.leftImage!.value,
                                  //   fit: BoxFit.fill,width: Get.width*0.2,height: Get.height*0.083,),
                                  // // // SvgPicture.asset((Get.isDarkMode)?ImageString.darkImageInfo: ImageString.imageInfo,
                                  // // //   fit: BoxFit.scaleDown,width: Get.width*0.11,height: Get.height*0.083,),
                                  // Image.network(ConstantStrings.submissionImageUrl+ damageController.middleImage!.value,
                                  //   fit: BoxFit.fill,width: Get.width*0.2,height: Get.height*0.083,),
                                  // SvgPicture.asset((Get.isDarkMode)?ImageString.darkImageInfo: ImageString.imageInfo,
                                  //   fit: BoxFit.scaleDown,width: Get.width*0.11,height: Get.height*0.083,),
                                ],
                              ))
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height*0.020,),
                        Container(
                          margin: EdgeInsets.only(right: 15,left: 15),
                          padding: EdgeInsets.all(15),
                          width: Get.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: (Get.isDarkMode)?AppColors.darkBackgroundColor: AppColors.countBorderColor,width: 1),
                              color: context.theme.backgroundColor,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:Obx(()=> Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: ConstantStrings.damageReport,
                                  height: 0.020,
                                  fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                  fontWeight: FontWeight.w600),
                              SizedBox(height: Get.height*0.010,),
                              (damageController.kioskComponentsData.length>0)?
                              MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                removeBottom: true,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: damageController.kioskComponentsData.length,
                                  itemBuilder: (context, index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(text: damageController.kioskComponentsData[index].name!,
                                        height: 0.018,
                                        color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                        fontFamily: ConstantStrings.fontFamilyMontserrat,
                                        fontWeight: FontWeight.w400),
                                    if(damageController.kioskComponentsData[index].value !=null)
                                      Container(
                                        width:Get.width*0.57,
                                        child: AppText(text: (" :- ")+damageController.kioskComponentsData[index].value!,
                                          height: 0.018,
                                          color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                          fontFamily: ConstantStrings.fontFamilyMontserrat,
                                          fontWeight: FontWeight.w400),
                                      ),
                                  ],
                                );
                                  }),
                              ):
                              AppText(text: "No Damage",
                                  height: 0.018,
                                  color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                  fontFamily: ConstantStrings.fontFamilyMontserrat,
                                  fontWeight: FontWeight.w400),
                            ],
                          )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.020,),
                  GestureDetector(
                    onTap: (){
                     damageController.submitSubmission(widget.submissionId!).then((value) {
                       homeController.selectedImagePath1S='';
                       homeController.selectedImagePath2S='';
                       homeController.selectedImagePath3S='';
                     });
                    },
                    child: AppYellowButton(
                      height: 0.075,
                      fontSize: 0.022,
                      width: Get.width,
                      borderRadius: Get.height*0.060,
                      textColor:Colors.black,
                      text: ConstantStrings.submit,
                      color:  AppColors.appYellowColor,
                      borderWidth: 0,
                      borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                    ),
                  ),
                  SizedBox(height: Get.height*0.020,),
                ],


              )))
            ])));
  }
}
