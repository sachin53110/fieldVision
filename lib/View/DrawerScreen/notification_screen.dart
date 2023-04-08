import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/Controller/home_page_controller.dart';
import 'package:field_vision/widgets/appText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../Model/notificationModel.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/common_popup.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final homeController=Get.put(HomePageController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => homeController.notification());
  }
  // List<NotificationModel> notificationList=[
  //   NotificationModel(newItem: "New",title: "Lorem ipsum",title1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus eget."),
  //   NotificationModel(newItem: "New",title: "Lorem ipsum",title1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus eget."),
  //   NotificationModel(newItem: "",title: "Lorem ipsum",title1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus eget."),
  //   NotificationModel(newItem: "",title: "Lorem ipsum",title1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus eget."),
  //   NotificationModel(newItem: "",title: "Lorem ipsum",title1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus eget."),
  //   NotificationModel(newItem: "",title: "Lorem ipsum",title1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus eget."),
  //   NotificationModel(newItem: "",title: "Lorem ipsum",title1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus eget."),
  //   NotificationModel(newItem: "",title: "Lorem ipsum",title1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus eget."),
  //
  // ];
  Future refresh() async {
    await homeController.notification();
  }
  willCall(){
    homeController.markNotification();
    WidgetsBinding.instance.addPostFrameCallback((_) => homeController.submission());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>willCall(),
      child: Scaffold(
        backgroundColor:context.theme.backgroundColor,
        body: Padding(
          padding:  EdgeInsets.only(left:  Get.width*0.055,right: Get.width*0.055),
          child:   Obx(()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkHomeTopIcon: ImageString.homeTopIcon,)),
              SizedBox(height: Get.height*0.020,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      homeController.markNotification();
                      homeController.submission();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(color: context.theme.buttonColor,
                        shape: BoxShape.circle,
                      ),
                      child:SvgPicture.asset((Get.isDarkMode)?ImageString.darkBackIcon: ImageString.leftArrow),
                    ),
                  ),

                  AppText(text:  ConstantStrings.notifications,
                      fontFamily: ConstantStrings.fontFamilyMontserratBold,
                      height: 0.025,
                      fontWeight: FontWeight.w600),
                  SizedBox(width: 35,)
                ],
              ),
              SizedBox(height: Get.height*0.020,),
              (homeController.notificationsData.length>0)?
             Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeController.notificationsData.length,
                        itemBuilder: (context, index) {
                          return    Slidable(
                            endActionPane: ActionPane(
                              motion: BehindMotion(),
                              openThreshold: 0.15,
                              extentRatio: 0.35,
                              children: [
                                MediaQuery.removePadding(
                                  context:context,
                                  removeRight: true,
                                  child: GestureDetector(
                                    onTap: (){
                                      commonPopup(context,ImageString.redRemove,
                                          CommonFunctions.getThemeColor(light: AppColors.deleteTextColor, dark:  Colors.white),
                                          ConstantStrings.deleteNotificationMsg,
                                              (){
                                            Get.back();
                                            homeController.deleteNotification(homeController.notificationsData[index].id.toString());
                                          });

                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(bottom: 10,left: 10),

                                      width: Get.width*0.23,
                                      decoration: BoxDecoration(
                                          color: AppColors.deleteRedColor,
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(ImageString.redRemove),
                                            SizedBox(height: 5,),
                                            AppText(text: "Remove",
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height*0.010,),
                                Container(
                                  padding: EdgeInsets.all(10),

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor) ,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: context.theme.backgroundColor,
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                          ),
                                          child: SvgPicture.asset(ImageString.notificationBell)),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: AppText(
                                                  text: ( homeController.notificationsData[index].status==0)?"new":"",
                                                  height: 0.018,
                                                   fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AppText(text: homeController.notificationsData[index].title!,
                                                      height: 0.020,
                                                      fontFamily:( homeController.notificationsData[index].status==0)?
                                                      ConstantStrings.fontFamilyMontserratSemiBold:
                                                      //(notificationList[index].newItem! =="")?
                                                      ConstantStrings.fontFamilyMontserrat,
                                                          //: ConstantStrings.fontFamilyMontserratSemiBold,
                                                      fontWeight:( homeController.notificationsData[index].status==0)?
                                                      FontWeight.w700:
                                                      //(notificationList[index].newItem! =="")?
                                                      FontWeight.w500),
                                                          //: FontWeight.w700),
                                                 SizedBox(height: Get.height*0.005,),
                                                  AppText(text:homeController.notificationsData[index].body!,
                                                      height: 0.016,
                                                      fontFamily:( homeController.notificationsData[index].status==0)?
                                                      ConstantStrings.fontFamilyMontserratSemiBold:
                                                      //(notificationList[index].newItem! =="")?
                                                      ConstantStrings.fontFamilyMontserrat,
                                                        //  :ConstantStrings.fontFamilyMontserratSemiBold,
                                                      color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                                                      fontWeight:
                                                    //  (notificationList[index].newItem! =="")?
                                                      FontWeight.w500)
                                                          //: FontWeight.w700),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height*0.010,),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ):
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageString.notificationEmpty),
                      SizedBox(height: Get.height*0.020,),
                      AppText(text: "Nothing here!!!",
                          height: 0.030,
                          fontWeight: FontWeight.w700),
                      SizedBox(height: Get.height*0.010,),
                      AppText(text: "Tap the notification settings button below and check again",
                          height: 0.022,
                          color: AppColors.grayColor,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500),
                      SizedBox(height: Get.height*0.3,),
                      AppText(text: ConstantStrings.notificationSettings,
                          height: 0.022,

                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                ),
              ),

            ],
          ),
          )),
      ),
    );
  }
}
