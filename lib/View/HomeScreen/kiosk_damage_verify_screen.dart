import 'package:dotted_border/dotted_border.dart';
import 'package:field_vision/Controller/home_page_controller.dart';
import 'package:field_vision/Controller/new_submission_controller.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:field_vision/widgets/error_msg_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../RouteHelper/route_helper.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appText.dart';
import '../../widgets/appYellowButton.dart';

class KioskDamageVerifyScreen extends StatefulWidget {
  const KioskDamageVerifyScreen({Key? key}) : super(key: key);

  @override
  State<KioskDamageVerifyScreen> createState() => _KioskDamageVerifyScreenState();
}

class _KioskDamageVerifyScreenState extends State<KioskDamageVerifyScreen> {
  final newSubmissionController=Get.put(NewSubmissionController());

  final TextEditingController _controller = new TextEditingController();

  var items = ['Did not receive replacement wraps on time', 'Forgot to bring wraps', 'Received the wrong wrap patches', 'Other'];
  void showDialogRepairs() async {

    showDialog(
        context: context, // <<----
        barrierDismissible: true,
        barrierColor: (Get.isDarkMode)? Colors.white54:Colors.black54,
        builder: (BuildContext context) {
      return Dialog(
          backgroundColor: context.theme.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(

            padding: EdgeInsets.all(15),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: Get.height*0.030,),
            Image.asset(ImageString.addImageIconPng,height: Get.height*0.1,width: Get.width*0.2,),
            // SvgPicture.asset(ImageString.addImageIcon),
            SizedBox(height: Get.height*0.030,),
            Container(
              width: Get.width*0.5,
              child: AppText(text: "Please add photos of repairs.",
                  height: 0.024,
                  textAlign: TextAlign.center,
                  fontFamily: ConstantStrings.fontFamilyMontserratBold,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Get.height*0.030,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      padding: EdgeInsets.all(2),
                      height: Get.height * 0.040,
                      width: Get.width * 0.18,
                      decoration: BoxDecoration(
                        color: (Get.isDarkMode)?AppColors.darkBackButtonColor: AppColors.dottedBorderColor,
                        borderRadius: BorderRadius.circular(5),

                      ),
                      child: Center(
                          child: Text(
                            ConstantStrings.cancel,
                            style: TextStyle(fontWeight: FontWeight.w600,fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,fontSize: Get.height * 0.020, color:(Get.isDarkMode)?Colors.white: Colors.black),
                          ))),
                ),
                SizedBox(width: Get.width*0.010,),
                InkWell(
                  onTap: () {
                    Prefs.setInt("AddYesNo", 1);
                    Get.back();
                     Get.toNamed(RouteHelper.getInspectKioskScreen());
                  },
                  child: Container(
                      padding: EdgeInsets.all(2),
                      height: Get.height * 0.040,
                      width: Get.width * 0.18,
                      decoration: BoxDecoration(
                        color: AppColors.appYellowColor,
                        borderRadius: BorderRadius.circular(5),

                      ),
                      child: Center(
                          child: Text(
                            ConstantStrings.add,
                            style: TextStyle(fontWeight: FontWeight.w600,
                                fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,fontSize: Get.height * 0.020,
                                color:Colors.black),),
                          ))),

              ],
            ),
            SizedBox(
              height: Get.height * 0.010,
            )
          ])));
      });
  }

  void showDialogNo() async {
    showDialog(
        context: context, // <<----
        barrierDismissible: true,
        barrierColor: (Get.isDarkMode)? Colors.white54:Colors.black54,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: context.theme.backgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: Get.height*0.030,),
                        Image.asset(ImageString.addImageIconPng,height: Get.height*0.1,width: Get.width*0.2,),
                       // SvgPicture.asset(ImageString.addImageIcon),
                        SizedBox(height: Get.height*0.030,),
                        AppText(text: "Please add new photos",
                            height: 0.024,
                            fontFamily: ConstantStrings.fontFamilyMontserratBold,
                            fontWeight: FontWeight.w700),
                        SizedBox(height: Get.height*0.030,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  height: Get.height * 0.040,
                                  width: Get.width * 0.18,
                                  decoration: BoxDecoration(
                                    color:  (Get.isDarkMode)?AppColors.darkBackButtonColor: AppColors.dottedBorderColor,
                                    borderRadius: BorderRadius.circular(5),

                                  ),
                                  child: Center(
                                      child: Text(
                                        ConstantStrings.cancel,
                                        style: TextStyle(fontWeight: FontWeight.w600,fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,fontSize: Get.height * 0.020,

                                            color: (Get.isDarkMode)?Colors.white: Colors.black),
                                      ))),
                            ),
                            SizedBox(width: Get.width*0.010,),
                            InkWell(
                              onTap: () {
                                Prefs.setInt("AddYesNo", 0);
                                Get.back();
                                Get.toNamed(RouteHelper.getInspectKioskScreen());
                              },
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  height: Get.height * 0.040,
                                  width: Get.width * 0.18,
                                  decoration: BoxDecoration(
                                    color: AppColors.appYellowColor,
                                    borderRadius: BorderRadius.circular(5),

                                  ),
                                  child: Center(
                                      child: Text(
                                        ConstantStrings.add,

                                        style: TextStyle(fontWeight: FontWeight.w600,fontFamily: ConstantStrings.fontFamilyMontserratSemiBold, fontSize: Get.height * 0.020, color: Colors.black),
                                      ))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.010,
                        )
                      ])));
        });
  }

  List<String> listString = [
    "Wrap Damages",
    "Side Wrap Damages",
    "Side Panel Placement Placement",
  ];
  check(){
    if( newSubmissionController.repairYesNoCheck.value.isEmpty){
      Get.back();
    }
    else{
      newSubmissionController.repairYesNoCheck.value="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async=>check(),
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    (Get.isDarkMode)?ImageString.darkHomeTopIcon: ImageString.homeTopIcon,
                  )),
              SizedBox(
                height: Get.height * 0.020,
              ),
              Padding(
                padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.050),
                child: Column(
                  children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if( newSubmissionController.repairYesNoCheck.value.isEmpty){
                          Get.back();
                        }
                        else{
                          newSubmissionController.repairYesNoCheck.value="";
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(color:  context.theme.buttonColor,
                          shape: BoxShape.circle,
                        ),
                        child:SvgPicture.asset((Get.isDarkMode)?ImageString.darkBackIcon: ImageString.leftArrow),
                      ),
                    ),
                    AppText(text: "New Submissions",
                        fontFamily: ConstantStrings.fontFamilyMontserratBold,
                        height: 0.025,
                        fontWeight: FontWeight.w600),
                    SizedBox(width: 35,)
                  ],
                ),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset((Get.isDarkMode)?ImageString.darkKioskVerifyIcon: ImageString.kioskVerifyIcon),
                        SizedBox(
                          height: Get.height * 0.030,
                        ),
                        AppText(text: newSubmissionController.kioskTitle!,
                            fontFamily: ConstantStrings.fontFamilyMontserratBold,
                            height: 0.032, fontWeight: FontWeight.w700),
                        SizedBox(
                          height: Get.height * 0.020,
                        ),
                        AppText(
                          text: "Kiosk was reported damaged on ${newSubmissionController.kioskDate!} on submission ${newSubmissionController.submissionData}",
                          height: 0.020,
                          fontFamily: ConstantStrings.fontFamilyMontserrat,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                        ),
                        SizedBox(
                          height: Get.height * 0.030,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),

                          decoration: BoxDecoration(color: CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor),
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          //height: Get.height * 0.060*newSubmissionController.kioskComponents.length,
                          width: Get.width,
                          child: DottedBorder(
                            color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: Colors.black),
                            dashPattern: [10, 10],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (newSubmissionController.kioskComponents.length>0)? MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: newSubmissionController.kioskComponents.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: SvgPicture.asset(ImageString.yellowCircle),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.020,
                                              ),
                                              AppText(text: newSubmissionController.kioskComponents[index].name!,
                                                  fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                  height: 0.020, fontWeight: FontWeight.w600),
                                              if(newSubmissionController.kioskComponents[index].value !=null)
                                                Container(
                                                  width:Get.width*0.57,
                                                  child: AppText(text: (" :- ")+newSubmissionController.kioskComponents[index].value!,
                                                      color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                      height: 0.020, fontWeight: FontWeight.w600),
                                                ),
                                              SizedBox(
                                                height: Get.height * 0.035,
                                              )
                                            ],
                                          );
                                        }),
                                  ):
                              Row(
                                children: [
                                  SvgPicture.asset(ImageString.yellowCircle),
                                  SizedBox(
                                    width: Get.width * 0.020,
                                  ),
                                  AppText(text: "No Damage",
                                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                      height: 0.020, fontWeight: FontWeight.w600),
                                  SizedBox(
                                    height: Get.height * 0.035,
                                  )
                                ],
                              )

                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.030,
                        ),
                        Obx(() =>   (newSubmissionController.repairYesNoCheck.value.isEmpty ||newSubmissionController.repairYesNoCheck.value == "true")?
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: AppText(text: "Did you make any repairs today?",
                                  fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                  height: 0.020, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: Get.height * 0.020,
                            ),
                            Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                          newSubmissionController.repairYesNoCheck.value = "false";
                                          Prefs.setInt("AnyRepairToday", 1);
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(newSubmissionController.repairYesNoCheck.value.isNotEmpty
                                              ? newSubmissionController.repairYesNoCheck.value == "false"
                                                  ? ImageString.yesIcon
                                                  : ImageString.noIcon
                                              : ImageString.noIcon),
                                          SizedBox(
                                            width: Get.width * 0.010,
                                          ),
                                          AppText(text: "Yes",
                                              fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                              height: 0.020, fontWeight: FontWeight.w600),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.020,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        newSubmissionController.repairYesNoCheck.value = "true";
                                        Prefs.setInt("AnyRepairToday", 0);
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(newSubmissionController.repairYesNoCheck.value.isNotEmpty
                                              ? newSubmissionController.repairYesNoCheck.value == "true"
                                                  ? ImageString.yesIcon
                                                  : ImageString.noIcon
                                              : ImageString.noIcon),
                                          SizedBox(
                                            width: Get.width * 0.010,
                                          ),
                                          AppText(text: "No",
                                              fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                              height: 0.020, fontWeight: FontWeight.w600),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                          ],
                        ):Container()),

                        Obx(() =>
                        (newSubmissionController.repairYesNoCheck.value.isNotEmpty)?
                        (newSubmissionController.repairYesNoCheck.value == "false")?
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: AppText(text: "Is there any additional damage that could not be repaired today?",
                                  fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                  height: 0.020, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: Get.height * 0.020,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialogRepairs();
                                    newSubmissionController.damageYesNoCheck.value = "false";
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(newSubmissionController.damageYesNoCheck.value.isNotEmpty
                                          ? newSubmissionController.damageYesNoCheck.value == "false"
                                          ? ImageString.yesIcon
                                          : ImageString.noIcon
                                          : ImageString.noIcon),
                                      SizedBox(
                                        width: Get.width * 0.010,
                                      ),
                                      AppText(text: "Yes", height: 0.020, fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.020,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialogNo();
                                    newSubmissionController.damageYesNoCheck.value = "true";
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(newSubmissionController.damageYesNoCheck.value.isNotEmpty
                                          ? newSubmissionController.damageYesNoCheck.value == "true"
                                          ? ImageString.yesIcon
                                          : ImageString.noIcon
                                          : ImageString.noIcon),
                                      SizedBox(
                                        width: Get.width * 0.010,
                                      ),
                                      AppText(text: "No", height: 0.020, fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ):
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height*0.020,),
                            AppText(text: ConstantStrings.addReason,
                                height: 0.020,
                                fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                fontWeight: FontWeight.w600),
                            SizedBox(height: Get.height*0.010,),
                         Obx(()=>  /*(newSubmissionController.textCheckOther!.value=="Other")?*/
                         // TextFormField(
                         //   textAlign: TextAlign.start,
                         //   maxLines: 5,
                         //   controller: _controller,
                         //   keyboardType: TextInputType.multiline,
                         //   decoration: InputDecoration(
                         //     enabledBorder: OutlineInputBorder(
                         //       borderRadius: BorderRadius.circular(10),
                         //       borderSide: BorderSide(
                         //         color: CommonFunctions.getThemeColor(
                         //             light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),
                         //       ), //<-- SEE HERE
                         //     ),
                         //     prefixIcon: Padding(
                         //         padding: const EdgeInsets.only(bottom: 70),
                         //         child: SvgPicture.asset(
                         //           ImageString.chatIcon,
                         //           fit: BoxFit.scaleDown,
                         //           color: CommonFunctions.getThemeColor(
                         //               light: Colors.black, dark: AppColors.darkDotsIndicatorColor),
                         //         )),
                         //     //hintText: "The kiosk has a dent on the right side that Causes it to lean.",
                         //     hintStyle: TextStyle(
                         //         fontFamily: ConstantStrings.fontFamilyMontserrat,
                         //         color: CommonFunctions.getThemeColor(
                         //             light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                         //         fontSize: Get.height * 0.020),
                         //     filled: true, //<-- SEE HERE
                         //     fillColor: CommonFunctions.getThemeColor(
                         //         light: Colors.white, dark: AppColors.darkBackgroundColor),
                         //     contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                         //
                         //   ),
                         // )
                         //        :
                            TextFormField(
                              readOnly: (newSubmissionController.textCheckOther!.value=="Other")?false:true,
                              controller: _controller,
                              style: TextStyle(
                                fontFamily: ConstantStrings.fontFamilyMontserrat,
                                color: CommonFunctions.getThemeColor(light: Colors.black, dark:Colors.white),),
                               decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),), //<-- SEE HERE
                                ),
                                filled: true, //<-- SEE HERE
                                fillColor: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackButtonColor),
                                hintText:
                                (newSubmissionController.textCheckOther!.value=="Other")?"": "Why is the kiosk still damaged?",
                                hintStyle: TextStyle(
                                    fontFamily: ConstantStrings.fontFamilyMontserrat,
                                    color:  CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),
                                    fontSize: Get.height*0.017
                                ),
                                 suffixIcon: PopupMenuButton<String>(
                                   icon: SvgPicture.asset((Get.isDarkMode)?ImageString.darkDownArrow: ImageString.downArrow,fit: BoxFit.scaleDown,
                                   ),
                                   onSelected: (String value) {
                                     print("value select $value");
                                     if(value=="Other"){
                                       _controller.text = "";
                                     }
                                     else{
                                       _controller.text = value;
                                     }

                                     newSubmissionController.textCheckOther!.value=value;
                                   },
                                   itemBuilder: (BuildContext context) {
                                     return items
                                         .map<PopupMenuItem<String>>((String value) {
                                       return new PopupMenuItem(
                                           child: new Text(value), value: value);
                                     }).toList();
                                   },
                                 ),
                                prefixIcon: SvgPicture.asset(ImageString.addResonIcon,fit: BoxFit.scaleDown,),
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

                            )),
                            // AppTextField(
                            //   hintText: "Why is kiosk still damaged?",
                            //   suffixIcon:SvgPicture.asset((Get.isDarkMode)?ImageString.darkDownArrow: ImageString.downArrow,fit: BoxFit.scaleDown,),
                            //   prefixIcon: SvgPicture.asset(ImageString.addResonIcon,fit: BoxFit.scaleDown,),
                            //   textController: homeController.addReasonController,
                            // ),
                            SizedBox(height: Get.height*0.030,),
                            GestureDetector(
                              onTap: (){
                                String submissionId=Prefs.getString("kioskSubmissionId")??"";
                                if(_controller.text.isNotEmpty){
                                  newSubmissionController.updateNoRepair(submissionId, _controller.text);
                                }
                                else{
                                  commonErrorPopup(context, "Please add reason", "");
                                }

                              },
                              child: AppYellowButton(
                                height: 0.075,
                                width: Get.width,
                                textColor: Colors.black,
                                borderRadius: Get.height*0.060,
                                fontSize: 0.022,
                                text: ConstantStrings.submit,
                                color:  AppColors.appYellowColor,
                                borderWidth: 0,
                                borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                              ),
                            ),
                            SizedBox(height: Get.height*0.010,)
                          ],
                        )
                            :Container()
                        ),

                      ],
                    ),
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
