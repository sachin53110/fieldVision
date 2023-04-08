import 'dart:io';

import 'package:dio/dio.dart';
import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Controller/new_submission_controller.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:field_vision/Controller/damage_report_controller.dart';
import 'package:field_vision/Controller/home_page_controller.dart';
import 'package:field_vision/Model/lockDoorModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Constants/ColorConstant.dart';
import '../../Constants/ImageConstant.dart';
import '../../RouteHelper/route_helper.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/appYellowButton.dart';

class DamageReportScreen extends StatefulWidget {
  DamageReportScreen({Key? key}) : super(key: key);

  @override
  State<DamageReportScreen> createState() => _DamageReportScreenState();
}

class _DamageReportScreenState extends State<DamageReportScreen> {
  final damageController = Get.put(DamageReportController());
  final homeController = Get.put(HomePageController());
  String kioskSerialNumber = "";
  @override
  initState() {
    lockDoorValue.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) => damageController.components());
    super.initState();
    kioskSerialNumber = Prefs.getString("kioskSerialNumber")??"";
  }
  RxList<int> lockDoorValue = <int>[].obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    (Get.isDarkMode) ? ImageString.darkHomeTopIcon : ImageString.homeTopIcon,
                  )),
              SizedBox(
                height: Get.height * 0.020,
              ),
              AppBarWidget(
                text: "Submission ${kioskSerialNumber.toString()}",
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.040,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: (Get.isDarkMode)
                          ? SvgPicture.asset(ImageString.darkConifmKioskIcon)
                          : Image.asset(
                              ImageString.kisokImage,
                              height: Get.height * 0.12,
                            )),
                  SizedBox(
                    height: Get.height * 0.020,
                  ),
                  Column(
                    children: [
                      Obx(() => AppText(
                          text: damageController.kioskComponent.isEmpty
                              ? ""
                              : (damageController.kioskComponent[5].selected.value == true ||
                                      damageController.kioskComponent[0].selected.value == true ||
                                      damageController.kioskComponent[1].selected.value == true ||
                                      damageController.kioskComponent[2].selected.value == true ||
                                      damageController.kioskComponent[3].selected.value == true ||
                                      damageController.kioskComponent[4].selected.value == true)
                                  ? "Review Submission"
                                  : ConstantStrings.reportDamage,
                          fontFamily: ConstantStrings.fontFamilyMontserratBold,
                          textAlign: TextAlign.center,
                          height: 0.032,
                          fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: Get.height * 0.010,
                      ),
                      Container(
                        width: Get.width * 0.8,
                        child: Obx(() => AppText(
                            text: damageController.kioskComponent.isEmpty
                                ? ""
                                : (damageController.kioskComponent[5].selected.value == true ||
                                        damageController.kioskComponent[0].selected.value == true ||
                                        damageController.kioskComponent[1].selected.value == true ||
                                        damageController.kioskComponent[2].selected.value == true ||
                                        damageController.kioskComponent[3].selected.value == true ||
                                        damageController.kioskComponent[4].selected.value == true)
                                    ? "Review the inspection details before submitting the report"
                                    : "Select any component that is damaged",
                            fontFamily: ConstantStrings.fontFamilyMontserrat,
                            height: 0.021,
                            textAlign: TextAlign.center,
                            color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                            fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.020,
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() => ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: damageController.kioskComponent.length,
                          itemBuilder: (context, index) {
                            return Obx(() => GestureDetector(
                                  onTap: () {
                                    damageController.kioskComponent[index].selected.value = !damageController.kioskComponent[index]!.selected.value;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    height: (damageController.kioskComponent[index].slug == "locker-door" &&
                                            damageController.kioskComponent[0].selected.value == true)
                                        ? Get.height * 0.23
                                        : (damageController.kioskComponent[index].slug == "other" &&
                                                damageController.kioskComponent[5].selected.value == true)
                                            ? Get.height * 0.3
                                            : Get.height * 0.080,
                                    //height: Get.height*0.22,
                                    decoration: BoxDecoration(
                                        color: CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15, left: 15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              damageController.kioskComponent[index].selected.value =
                                                  !damageController.kioskComponent[index].selected.value;
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AppText(
                                                    text: damageController.kioskComponent[index].name!,
                                                    height: 0.022,
                                                    fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                    fontWeight: FontWeight.w600),
                                                Obx(() => SvgPicture.asset(
                                                    (damageController.kioskComponent[index].selected.value)
                                                        ? ImageString.yellowTick
                                                        : ImageString.grayTick,
                                                    fit: BoxFit.scaleDown,
                                                    height: Get.height * 0.030)),
                                              ],
                                            ),
                                          ),
                                          Obx(() => (damageController.kioskComponent[index].slug == "locker-door" &&
                                                  damageController.kioskComponent[0].selected.value == true)
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.020,
                                                    ),
                                                    Divider(
                                                      height: 5,
                                                      color: (Get.isDarkMode) ? Colors.white : AppColors.grayColor,
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.010,
                                                    ),
                                                    Obx(() => Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Wrap(
                                                            spacing: 4.0,
                                                            runSpacing: -6,
                                                            children: List<Widget>.generate(damageController.kioskComponent[index].lockDoor!.length,
                                                                (int innerIndex) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  damageController.kioskComponent[index].lockDoor![innerIndex].select!.value =
                                                                      !damageController.kioskComponent[index].lockDoor![innerIndex].select!.value;
                                                                },
                                                                child: Chip(
                                                                  backgroundColor: Colors.white,
                                                                  shape: RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                        color: (damageController
                                                                                    .kioskComponent[index].lockDoor![innerIndex].select!.value ==
                                                                                true)
                                                                            ? Colors.black
                                                                            : Colors.white,
                                                                      ),
                                                                      borderRadius: BorderRadius.all(
                                                                        Radius.circular(5),
                                                                      )),
                                                                  label: Text(
                                                                    damageController.kioskComponent[index].lockDoor![innerIndex].name.toString(),
                                                                    style: TextStyle(
                                                                        fontSize: Get.height * 0.016,
                                                                        color: (damageController
                                                                                    .kioskComponent[index].lockDoor![innerIndex].select!.value ==
                                                                                true)
                                                                            ? Colors.black
                                                                            : Colors.grey
                                                                        //color: Colors.grey
                                                                        ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        )),
                                                  ],
                                                )
                                              : (damageController.kioskComponent[index].slug == "other" &&
                                                      damageController.kioskComponent[5].selected.value == true)
                                                  ? Column(
                                                      children: [
                                                        SizedBox(
                                                          height: Get.height * 0.020,
                                                        ),
                                                        Divider(
                                                          height: 8,
                                                          color: CommonFunctions.getThemeColor(
                                                              light: AppColors.otherLineColor, dark: AppColors.darkDotsIndicatorColor),
                                                        ),
                                                        SizedBox(
                                                          height: Get.height * 0.020,
                                                        ),
                                                        TextFormField(
                                                          textAlign: TextAlign.start,
                                                          maxLines: 5,
                                                          controller: damageController.otherTextController,
                                                          keyboardType: TextInputType.multiline,
                                                          decoration: InputDecoration(
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                              borderSide: BorderSide(
                                                                color: CommonFunctions.getThemeColor(
                                                                    light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),
                                                              ), //<-- SEE HERE
                                                            ),
                                                            prefixIcon: Padding(
                                                                padding: const EdgeInsets.only(bottom: 70),
                                                                child: SvgPicture.asset(
                                                                  ImageString.chatIcon,
                                                                  fit: BoxFit.scaleDown,
                                                                  color: CommonFunctions.getThemeColor(
                                                                      light: Colors.black, dark: AppColors.darkDotsIndicatorColor),
                                                                )),
                                                            hintText: "The kiosk has a dent on the right side that Causes it to lean.",
                                                            hintStyle: TextStyle(
                                                                fontFamily: ConstantStrings.fontFamilyMontserrat,
                                                                color: CommonFunctions.getThemeColor(
                                                                    light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                                                                fontSize: Get.height * 0.020),
                                                            filled: true, //<-- SEE HERE
                                                            fillColor: CommonFunctions.getThemeColor(
                                                                light: Colors.white, dark: AppColors.darkBackgroundColor),
                                                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : Container())
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          })),
                      SizedBox(
                        height: Get.height * 0.020,
                      ),
                      Obx(() => GestureDetector(
                            onTap: () {
                              int checkNewUpdate=Prefs.getInt("KioskCheckNewUpdate")!;
                              if(checkNewUpdate==0){
                                Map<String, dynamic> mapUpdate = {};
                               // int? kioskId = Prefs.getInt("kioskIdNewSub");
                                int anyRepairToday=Prefs.getInt("AnyRepairToday")!;
                                mapUpdate["any_repair_today"]=anyRepairToday;
                                if(anyRepairToday==0){
                                  mapUpdate["reason_for_no_repair_today"]=0;
                                }
                                String subId=Prefs.getString("kioskSubmissionId")!;
                                mapUpdate['submission_id'] = subId;
                                int yesNo=Prefs.getInt("AddYesNo")!;
                                mapUpdate['additional_damage_could_not_repair_today']=yesNo;
                                mapUpdate['is_damage'] = 0;

                                int count = 0;
                                for (int i = 0; i < damageController.kioskComponent.length; i++) {
                                  if (damageController.kioskComponent[i].slug == "locker-door" && damageController.kioskComponent[i].selected.value
                                  ) {
                                    String ids = "";
                                    mapUpdate['is_damage'] = 1;
                                    for (int j = 0; j < damageController.kioskComponent[i].lockDoor!.length; j++) {
                                      if (damageController.kioskComponent[i].lockDoor![j].select!.value) {
                                        if (ids == "") {
                                          ids = "${damageController.kioskComponent[i].lockDoor![j].name!.value}";
                                        } else {
                                          ids = "$ids,${damageController.kioskComponent[i].lockDoor![j].name!.value}";
                                        }
                                      }
                                    }
                                    mapUpdate["component_values[$count]"] = ids;
                                    if(ids!=""){
                                      mapUpdate["component_ids[$count]"] = damageController.kioskComponent[i].id;
                                    }
                                    ids = "";
                                    count = count + 1;
                                  } else if ((damageController.kioskComponent[i].slug == "kick-plate" ||
                                      damageController.kioskComponent[i].slug == "header" ||
                                      damageController.kioskComponent[i].slug == "side-panel" ||
                                      damageController.kioskComponent[i].slug == "touchscreen") &&
                                      damageController.kioskComponent[i].selected.value) {
                                    mapUpdate["component_ids[$count]"] = damageController.kioskComponent[i].id;
                                    mapUpdate["component_values[$count]"] = 0;
                                    mapUpdate['is_damage'] = 1;
                                    count = count + 1;
                                  } else if (damageController.kioskComponent[i].slug == "other" && damageController.kioskComponent[i].selected.value&&damageController.otherTextController.text.isNotEmpty) {
                                   if(damageController.otherTextController.text.isNotEmpty){
                                     mapUpdate["component_ids[$count]"] = damageController.kioskComponent[i].id;
                                     mapUpdate['is_damage'] = 1;
                                     mapUpdate["component_values[$count]"] = damageController.otherTextController.text;
                                     count = count + 1;
                                   }
                                  }
                                }
                                damageController.updateSubmission(mapUpdate, File(homeController.selectedImagePath1S),
                                    File(homeController.selectedImagePath2S), File(homeController.selectedImagePath3S));


                                print("Map kiosk ${mapUpdate}");
                              }
                              else{
                                Map<String, dynamic> map = {};
                                int? kioskId = Prefs.getInt("kioskIdNewSub");
                                map['kiosk_id'] = kioskId;
                                map['is_damage'] = 0;
                                int count = 0;
                                for (int i = 0; i < damageController.kioskComponent.length; i++) {
                                  if (damageController.kioskComponent[i].slug == "locker-door" && damageController.kioskComponent[i].selected.value
                                  ) {
                                    String ids = "";
                                    //map["component_ids[$count]"] = damageController.kioskComponent[i].id;

                                    for (int j = 0; j < damageController.kioskComponent[i].lockDoor!.length; j++) {
                                      map['is_damage'] = 1;
                                      if (damageController.kioskComponent[i].lockDoor![j].select!.value) {
                                        if (ids == "") {
                                          ids = "${damageController.kioskComponent[i].lockDoor![j].name!.value}";
                                        } else {
                                          ids = "$ids,${damageController.kioskComponent[i].lockDoor![j].name!.value}";
                                        }
                                      }
                                    }
                                    map["component_values[$count]"] = ids;
                                    if(ids!=""){
                                      map["component_ids[$count]"] = damageController.kioskComponent[i].id;
                                    }
                                    ids = "";
                                    count = count + 1;
                                  } else if ((damageController.kioskComponent[i].slug == "kick-plate" ||
                                      damageController.kioskComponent[i].slug == "header" ||
                                      damageController.kioskComponent[i].slug == "side-panel" ||
                                      damageController.kioskComponent[i].slug == "touchscreen") &&
                                      damageController.kioskComponent[i].selected.value) {
                                    map['is_damage'] = 1;
                                    map["component_ids[$count]"] = damageController.kioskComponent[i].id;
                                    map["component_values[$count]"] = 0;
                                    count = count + 1;
                                  } else if (damageController.kioskComponent[i].slug == "other" && damageController.kioskComponent[i].selected.value&&damageController.otherTextController.text.isNotEmpty) {
                                    if(damageController.otherTextController.text.isNotEmpty){
                                      map["component_ids[$count]"] = damageController.kioskComponent[i].id;
                                      map['is_damage'] = 1;
                                      map["component_values[$count]"] = damageController.otherTextController.text;
                                      count = count + 1;
                                    }

                                  }
                                }
                                damageController.newSubmission(map, File(homeController.selectedImagePath1S),
                                    File(homeController.selectedImagePath2S), File(homeController.selectedImagePath3S));


                                print("Map kiosk ${map}");
                              }

                            },
                            child: AppYellowButton(
                              height: 0.075,
                              width: Get.width,
                              textColor: Colors.black,
                              borderRadius: Get.height * 0.060,
                              fontSize: 0.022,
                              text: damageController.kioskComponent.isEmpty
                                  ? ""
                                  : (damageController.kioskComponent[5].selected.value == true ||
                                          damageController.kioskComponent[0].selected.value == true ||
                                          damageController.kioskComponent[1].selected.value == true ||
                                          damageController.kioskComponent[2].selected.value == true ||
                                          damageController.kioskComponent[3].selected.value == true ||
                                          damageController.kioskComponent[4].selected.value == true)
                                      ? ConstantStrings.confirmDamageToKiosk
                                      : ConstantStrings.noDamageToKiosk,
                              color: AppColors.appYellowColor,
                              borderWidth: 0,
                              borderColor: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                            ),
                          )),
                      SizedBox(
                        height: Get.height * 0.030,
                      ),

                    ],
                  ),
                ),
              ),
            ])));
  }
}
