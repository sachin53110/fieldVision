import 'package:field_vision/Controller/home_page_controller.dart';
import 'package:field_vision/Model/homeSubmissionModel.dart';
import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/utils/CommonFunctions.dart';
import 'package:field_vision/widgets/appText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../widgets/common_popup.dart';
import '../DrawerScreen/drawer.dart';

class HomeSubmissionsScreen extends StatefulWidget {
  const HomeSubmissionsScreen({Key? key}) : super(key: key);

  @override
  State<HomeSubmissionsScreen> createState() => _HomeSubmissionsScreenState();
}

class _HomeSubmissionsScreenState extends State<HomeSubmissionsScreen> {
  final homeController = Get.put(HomePageController());

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  Future refresh() async {
    await homeController.submission();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => homeController.submission());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        key: _scaffoldKey,
        drawer: const DrawerScreen(),
        floatingActionButton: GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getNewSubmissionScreen());
            },
            child: SvgPicture.asset(
              ImageString.plusBottom,
              height: Get.height * 0.1,
            )),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    (Get.isDarkMode) ? ImageString.darkHomeTopIcon : ImageString.homeTopIcon,
                  )),
              SizedBox(
                height: Get.height * 0.020,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.050, right: Get.width * 0.050),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: SvgPicture.asset(
                            ImageString.drawerIcon,
                            color: CommonFunctions.getThemeColor(light: Colors.black, dark: Colors.white),
                          ),
                        ),
                        AppText(
                            text: "Submissions", height: 0.025, fontFamily: ConstantStrings.fontFamilyMontserratBold, fontWeight: FontWeight.w600),

                          GestureDetector(
                          onTap: () {
                            // Get.toNamed(RouteHelper.getDamageReportScreen());
                            Get.toNamed(RouteHelper.getNotificationScreen());
                          },
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                ImageString.notificationIcon,
                                color: CommonFunctions.getThemeColor(light: Colors.black, dark: Colors.white),
                              ),
                              if(homeController.notificationCount!="0")
                                Positioned(
                                left: 6,
                                top: -3,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: AppColors.appYellowColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    homeController.notificationCount!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.020,
                    ),
                  (homeController.isLoading!.value)?
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 20),
                        height: 120,width: Get.width,
                      decoration: BoxDecoration(
                        color: (Get.isDarkMode)?AppColors.darkBackButtonColor:AppColors.borderColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //
                      //   height: 110,width: Get.width*0.4,
                      //   decoration: BoxDecoration(
                      //     color: (Get.isDarkMode)?AppColors.darkBackgroundColor:AppColors.backArrowColor,
                      //     borderRadius: BorderRadius.all(Radius.circular(20)),
                      //     )),
                      //     Container(
                      //
                      //     height: 120,width: Get.width*0.2,
                      //     decoration: BoxDecoration(
                      //     color: (Get.isDarkMode)?AppColors.darkBackgroundColor:AppColors.backArrowColor,
                      //     borderRadius: BorderRadius.all(Radius.circular(20))),
                      //     )
                      //   ],
                      // ),
                      );
                        }):
                  (homeController.submissionsData.length>0)? SizedBox(
                      height: Get.height - 84,
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: homeController.submissionsData.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: BehindMotion(),
                                    openThreshold: 0.2,
                                    extentRatio: 0.39,
                                    children: [
                                      MediaQuery.removePadding(
                                        context: context,
                                        removeRight: true,
                                        child: GestureDetector(
                                          onTap: () {
                                            commonPopup(context,ImageString.redRemove,
                                                CommonFunctions.getThemeColor(light: AppColors.deleteTextColor, dark:  Colors.white),
                                                ConstantStrings.deleteSubmissionMsg,
                                                    (){
                                                      Get.back();
                                                      homeController.deleteSubmission(
                                                        homeController.submissionsData[index].id.toString(),
                                                      );
                                                });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 10, left: 10),
                                            width: Get.width * 0.3,
                                            decoration: BoxDecoration(
                                                color: AppColors.deleteRedColor,
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                border: Border.all(color: AppColors.deleteBorderColor, width: 10)),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(ImageString.redRemove),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  AppText(
                                                      text: "Delete",
                                                      height: 0.020,
                                                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                      color: AppColors.deleteTextColor,
                                                      fontWeight: FontWeight.w700),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.022, top: Get.height * 0.022, bottom: Get.height * 0.022, left: Get.width * 0.022),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        color: context.theme.backgroundColor,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        border: Border.all(
                                            color: CommonFunctions.getThemeColor(light: AppColors.borderColor, dark: AppColors.darkBackButtonColor),
                                            width: 10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10, left: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  AppText(
                                                      text: "Submission ",
                                                      height: 0.018,
                                                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                      fontWeight: FontWeight.w600),
                                                  AppText(
                                                      text: homeController.submissionsData[index].id.toString(),
                                                      height: 0.018,
                                                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                      fontWeight: FontWeight.w600),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.005,
                                              ),
                                              Row(
                                                children: [
                                                  AppText(
                                                      text: "Kiosk SN: ",
                                                      height: 0.018,
                                                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                      fontWeight: FontWeight.w600),
                                                  AppText(
                                                      text: homeController.submissionsData[index].kiosk!.serialNumber.toString(),
                                                      height: 0.018,
                                                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                      fontWeight: FontWeight.w600),
                                                ],
                                              ),

                                              // AppText(text: homeController.homeScreen[index].title2!,
                                              //     height: 0.018,
                                              //     fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                              //     fontWeight: FontWeight.w600),
                                              SizedBox(
                                                height: Get.height * 0.005,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration:
                                                    BoxDecoration(color: AppColors.appYellowColor, borderRadius: BorderRadius.all(Radius.circular(5))),
                                                child: Center(
                                                    child: Text(
                                                  homeController.submissionsData[index].date!,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: Get.height * 0.016,
                                                  ),
                                                )),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.005,
                                              ),
                                              AppText(
                                                  text: "Damages",
                                                  height: 0.020,
                                                  fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                  fontWeight: FontWeight.w400),
                                              SizedBox(
                                                height: Get.height * 0.005,
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child:(homeController.submissionsData[index].kioskComponents!.length>0)? Container(
                                                  width: Get.width * 0.5,
                                                  child: Wrap(
                                                    spacing: 4.0,
                                                    runSpacing: -2,
                                                    children: List<Widget>.generate(homeController.submissionsData[index].kioskComponents!.length,
                                                        (int innerIndex) {
                                                      return AppText(
                                                          text:
                                                              homeController.submissionsData[index].kioskComponents![innerIndex].name!+((innerIndex == homeController.submissionsData[index].kioskComponents!.length) ? "" : ","),
                                                          height: 0.016,
                                                          color: CommonFunctions.getThemeColor(
                                                              light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                                          fontFamily: ConstantStrings.fontFamilyMontserrat,
                                                          fontWeight: FontWeight.w400);
                                                    }),
                                                  ),
                                                ):
                                                AppText( text:
                                                "No Damage",
                                                    height: 0.016,
                                                    color: CommonFunctions.getThemeColor(
                                                        light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                                    fontFamily: ConstantStrings.fontFamilyMontserrat,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              // Container(
                                              //   width: Get.width*0.55,
                                              //   child: AppText(text: homeController.homeScreen[index].title4!,
                                              //       height: 0.016,
                                              //       color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                              //       fontFamily: ConstantStrings.fontFamilyMontserrat,
                                              //       fontWeight: FontWeight.w400),
                                              // )
                                            ],
                                          ),
                                          (homeController.submissionsData[index].iconName == "wrench")
                                              ? SvgPicture.asset(
                                                  (Get.isDarkMode) ? ImageString.darkSubmissionIcon1 : ImageString.submissionIcon1,
                                                  height: Get.height * 0.070,
                                                )
                                              : (homeController.submissionsData[index].iconName == "home")
                                                  ? SvgPicture.asset(
                                                      (Get.isDarkMode) ? ImageString.darkSubmissionIcon2 : ImageString.lockDoorHome,
                                                      height: Get.height * 0.070,
                                                    )
                                                  : (homeController.submissionsData[index].iconName == "tick")
                                                      ? SvgPicture.asset(
                                                          (Get.isDarkMode) ? ImageString.darkSubmissionIcon3 : ImageString.submitTick,
                                                          height: Get.height * 0.070,
                                                        )
                                                      : Container()

                                          // SvgPicture.asset(homeController.homeScreen[index].image!,
                                          // height: Get.height*0.070,
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ):
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: Get.height/2.8,),
                       Center(child: Text("No Data Found of Previous Submission",style: TextStyle(
                        fontSize: Get.height*0.020,
                         fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                         fontWeight: FontWeight.w500,
                         color: (Get.isDarkMode)?Colors.white:Colors.black
                      ),),),
                    ],
                  ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
