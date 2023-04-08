import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Controller/home_page_controller.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../Constants/ColorConstant.dart';
import '../../Constants/ImageConstant.dart';
import '../../RouteHelper/route_helper.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/bottom_sheet.dart';

class InspectKioskScreen extends StatefulWidget {
  String? serialNumber;
   InspectKioskScreen({Key? key,this.serialNumber}) : super(key: key);

  @override
  State<InspectKioskScreen> createState() => _InspectKioskScreenState();
}

class _InspectKioskScreenState extends State<InspectKioskScreen> {
  final homeController = Get.put(HomePageController());
  pickImageMiddle(ImageSource image) async{
    try {
      var photo = await ImagePicker().pickImage(source: image);
      if (photo != null ) {
        homeController.selectedImagePath3S = photo.path;
        // selectedImageSize3.value = (File(selectedImagePath3.value).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";
         Prefs.setString("imageMiddle", homeController.selectedImagePath3S);
        var now = new DateTime.now();
        var formatter = new DateFormat('dd-MM-yyyy, hh:mm a');
        dateMiddleImage = formatter.format(now);
        Get.back();
        checkImage();

      } else {
        Get.snackbar("Error", 'No image Selected', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
  pickImageLeft(ImageSource image)async{
    try {
      final photo = await ImagePicker().pickImage(source: image);
      if (photo != null ) {
       homeController.selectedImagePath2S = photo.path;
        // selectedImageSize2.value = (File(selectedImagePath2.value).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";
         Prefs.setString("imageLeft", homeController.selectedImagePath2S);
       var now = new DateTime.now();
       var formatter = new DateFormat('dd-MM-yyyy, hh:mm a');
       dateLeftImage = formatter.format(now);
        Get.back();
        checkImage();

      } else {
        Get.snackbar("Error", 'No image Selected', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
  checkImage(){
    String? rightImage=Prefs.getString("imageRight");
    String? imageLeft=Prefs.getString("imageLeft");
    String? imageMiddle=Prefs.getString("imageMiddle");
    if (homeController.selectedImagePath2S !="" && homeController.selectedImagePath1S != "" && homeController.selectedImagePath3S != "") {
      Get.toNamed(RouteHelper.getDamageReportScreen());
    }
  }




  pickImageRight(ImageSource image, ) async{
    try {
      final photo = await ImagePicker().pickImage(source: image);
      if (photo != null ) {
        homeController.selectedImagePath1S = photo.path;
        // selectedImagePath1.value = photo.path;
       // selectedImageSize1.value = (File(selectedImagePath1.value).lengthSync() / 1024 / 1024).toStringAsFixed(2) + " Mb";
        Prefs.setString("imageRight", homeController.selectedImagePath1S);
        var now = new DateTime.now();
        var formatter = new DateFormat('dd-MM-yyyy, hh:mm a');
        dateRightImage = formatter.format(now);
        Get.back();
        checkImage();
      } else {
        Get.snackbar("Error", 'No image Selected', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }


  String kioskSerialNumber="";
  String? dateRightImage="";
  String? dateLeftImage="";
  String? dateMiddleImage="";
  @override
  void initState() {
    homeController.reset();
    super.initState();
    kioskSerialNumber= Prefs.getString("kioskSerialNumber")??"";

  //  print(formattedDate);
  }

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
              Expanded(child: SingleChildScrollView(child:


             Column(
                children: [
                  SizedBox(height: Get.height*0.040,),
                  Align(
                      alignment: Alignment.center,
                      child:(Get.isDarkMode)? SvgPicture.asset(ImageString.darkConifmKioskIcon):Image.asset(ImageString.kisokImage,height: Get.height*0.12,)),
                  SizedBox(height: Get.height*0.020,),
                  AppText(text: "Inspect Kiosk",
                      fontFamily: ConstantStrings.fontFamilyMontserratBold,
                      height: 0.035, fontWeight: FontWeight.w700),
                  SizedBox(height: Get.height*0.010,),
                  Container(
                    width: Get.width*0.8,
                    child: AppText(text: "Take a photo of the front, left, and right sides of the kiosk",
                        fontFamily: ConstantStrings.fontFamilyMontserrat,
                        height: 0.021,textAlign: TextAlign.center, color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: Get.height*0.040,),
                  GestureDetector(
                    onTap: (){
                      homeController.checkImageSelectBox=1;
                      bottomSheet(1, cameraClick:() async{

                          await pickImageRight(ImageSource.camera);
                          setState(() {

                          });

                          print('images====>>${homeCon.selectedImagePath1S}');
                      } , galleryClick: ()async{
                        await pickImageRight(ImageSource.gallery);
                        setState(() {

                        });
                      }  );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor), borderRadius: BorderRadius.all(Radius.circular(20))),
                          height: Get.height * 0.22,
                          width: Get.width,
                          child: DottedBorder(
                            color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: Colors.black),
                            dashPattern: [10, 10],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(20),
                            child: Center(
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ( homeController.selectedImagePath1S.isNotEmpty)?
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          homeController.checkImageSelectBox=1;
                                          bottomSheet(1, cameraClick:() async{
                                            await pickImageRight(ImageSource.camera);
                                            setState(() {

                                            });
                                            print('images====>>${homeCon.selectedImagePath1S}');
                                          } , galleryClick: ()async{
                                            await pickImageRight(ImageSource.gallery);
                                            setState(() {

                                            });
                                          }  );
                                        },
                                        child:Stack(
                                          children: [
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                              child: Image.file(File( homeController.selectedImagePath1S),fit: BoxFit.fill,height: Get.height*0.18,width: Get.width,)),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 5,top: 5),
                                                  child: Align(
                                                      alignment: Alignment.topRight,
                                                      child: SvgPicture.asset(
                                                        (Get.isDarkMode)?ImageString.darkEditImageIcon: ImageString.editImageIcon,
                                                        fit: BoxFit.scaleDown,

                                                        height: Get.height*0.060,width: Get.width*0.040, )),
                                                ),
                                            // Container(
                                            //   margin: EdgeInsets.only(left: Get.width*0.02,top: Get.height*0.002),
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.black,
                                            //     borderRadius: BorderRadius.all(Radius.circular(10))
                                            //   ),
                                            //
                                            //   padding: EdgeInsets.all(3),
                                            //   child: AppText(text: dateRightImage!,
                                            //       fontFamily: ConstantStrings.fontFamilyMontserrat,
                                            //       height: 0.016,textAlign: TextAlign.center,
                                            //       color: Colors.white,
                                            //       fontWeight: FontWeight.w500),
                                            // )
                                          ],
                                        ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.only(right: 10),
                                      //     child: Align(
                                      //         alignment: Alignment.topRight,
                                      //         child: SvgPicture.asset(ImageString.editImageIcon,fit: BoxFit.scaleDown,)),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //     height: Get.height*0.060,
                                      //     width: Get.width*0.15,
                                      //     child: Image.file(File( homeController.selectedImagePath1!.value))),
                                      ) ],
                                  )
                                      :SvgPicture.asset(ImageString.imageIcon,color: CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white),),
                                  SizedBox(height: Get.height*0.020,),
                                  ( homeController.selectedImagePath1S.isNotEmpty)? const Text(""): AppText(text: "Right Side",
                                      height: 0.020,
                                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.020,),
                  GestureDetector(
                    onTap: (){
                      homeController.checkImageSelectBox=2;
                      //bottomSheet(2);
                      bottomSheet(2, cameraClick:() async{

                        await pickImageLeft(ImageSource.camera);
                        setState(() {

                        });

                        print('images====>>${homeCon.selectedImagePath1S}');
                      } , galleryClick: ()async{
                        await pickImageLeft(ImageSource.gallery);
                        setState(() {

                        });
                      }  );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(color: CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor), borderRadius: BorderRadius.all(Radius.circular(20))),
                          height: Get.height * 0.22,
                          width: Get.width,
                          child: DottedBorder(
                            color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: Colors.black),
                            dashPattern: [10, 10],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),
                            child: Center(
                              child:   Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ( homeController.selectedImagePath2S.isNotEmpty)?
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          homeController.checkImageSelectBox=2;
                                        //  bottomSheet(2);
                                          bottomSheet(2, cameraClick:() async{

                                            await pickImageLeft(ImageSource.camera);
                                            setState(() {

                                            });

                                            print('images====>>${homeCon.selectedImagePath1S}');
                                          } , galleryClick: ()async{
                                            await pickImageLeft(ImageSource.gallery);
                                            setState(() {

                                            });
                                          }  );
                                        },
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                              child: Image.file(File( homeController.selectedImagePath2S),fit: BoxFit.fill,height: Get.height*0.18,width: Get.width,)),
                                            Padding(
                                              padding:const EdgeInsets.only(right: 5,top: 5),
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkEditImageIcon: ImageString.editImageIcon, fit: BoxFit.scaleDown,

                                                    height: Get.height*0.060,width: Get.width*0.040,)),
                                            ),
                                            // Container(
                                            //   margin: EdgeInsets.only(left: Get.width*0.02,top: Get.height*0.002),
                                            //   decoration: BoxDecoration(
                                            //       color: Colors.black,
                                            //       borderRadius: BorderRadius.all(Radius.circular(10))
                                            //   ),
                                            //
                                            //   padding: EdgeInsets.all(3),
                                            //   child: AppText(text: dateLeftImage!,
                                            //       fontFamily: ConstantStrings.fontFamilyMontserrat,
                                            //       height: 0.016,textAlign: TextAlign.center,
                                            //       color: Colors.white,
                                            //       fontWeight: FontWeight.w500),
                                            // )
                                          ],
                                        )
                                      //   Padding(
                                      //     padding: const EdgeInsets.only(right: 10),
                                      //     child: Align(
                                      //         alignment: Alignment.topRight,
                                      //         child: SvgPicture.asset(ImageString.editImageIcon,fit: BoxFit.scaleDown,)),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //     height: Get.height*0.060,
                                      //     width: Get.width*0.15,
                                      //     child: Image.file(File( homeController.selectedImagePath2!.value))),
                                      ) ],
                                  )
                                      :SvgPicture.asset(ImageString.imageIcon,color: CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white),),
                                  SizedBox(height: Get.height*0.020,),
                                  ( homeController.selectedImagePath2S.isNotEmpty)? Text(""): AppText(text: "Left Side",
                                      height: 0.020,
                                      fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.020,),
                  GestureDetector(
                    onTap: (){
                      homeController.checkImageSelectBox=3;
                  //    bottomSheet(3);
                      bottomSheet(3, cameraClick:() async{

                        await pickImageMiddle(ImageSource.camera);
                        setState(() {

                        });

                        print('images====>>${homeCon.selectedImagePath1S}');
                      } , galleryClick: ()async{
                        await pickImageMiddle(ImageSource.gallery);
                        setState(() {

                        });
                      }  );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(color:CommonFunctions.getThemeColor(light: AppColors.dottedBorderColor, dark: AppColors.darkBackButtonColor), borderRadius: BorderRadius.all(Radius.circular(20))),
                          height: Get.height * 0.22,
                          width: Get.width,
                          child: DottedBorder(
                            color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: Colors.black),
                            dashPattern: [10, 10],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),
                            child: Center(
                              child:     Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          (homeController.selectedImagePath3S.isNotEmpty)
                                              ? Column(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          homeController.checkImageSelectBox = 3;
                                                          //bottomSheet(3);
                                                          bottomSheet(3, cameraClick:() async{

                                                            await pickImageMiddle(ImageSource.camera);
                                                            setState(() {

                                                            });

                                                            print('images====>>${homeCon.selectedImagePath1S}');
                                                          } , galleryClick: ()async{
                                                            await pickImageMiddle(ImageSource.gallery);
                                                            setState(() {

                                                            });
                                                          }  );
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            ClipRRect(
                                                                borderRadius: BorderRadius.circular(20.0),
                                                                child: Image.file(
                                                                  File(homeController.selectedImagePath3S),
                                                                  fit: BoxFit.fill,
                                                                  height: Get.height * 0.18,
                                                                  width: Get.width,
                                                                )),
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 5, top: 5),
                                                              child: Align(
                                                                  alignment: Alignment.topRight,
                                                                  child: SvgPicture.asset(
                                                                    (Get.isDarkMode) ? ImageString.darkEditImageIcon : ImageString.editImageIcon,
                                                                    fit: BoxFit.scaleDown,
                                                                    height: Get.height * 0.060,
                                                                    width: Get.width * 0.040,
                                                                  )),
                                                            ),
                                                            // Container(
                                                            //   margin: EdgeInsets.only(left: Get.width*0.02,top: Get.height*0.002),
                                                            //   decoration: BoxDecoration(
                                                            //       color: Colors.black,
                                                            //       borderRadius: BorderRadius.all(Radius.circular(10))
                                                            //   ),
                                                            //
                                                            //   padding: EdgeInsets.all(3),
                                                            //   child: AppText(text: dateMiddleImage!,
                                                            //       fontFamily: ConstantStrings.fontFamilyMontserrat,
                                                            //       height: 0.016,textAlign: TextAlign.center,
                                                            //       color: Colors.white,
                                                            //       fontWeight: FontWeight.w500),
                                                            // )
                                                          ],
                                                        )
                                                        //   Padding(
                                                        //     padding: const EdgeInsets.only(right: 10),
                                                        //     child: Align(
                                                        //         alignment: Alignment.topRight,
                                                        //         child: SvgPicture.asset(ImageString.editImageIcon,fit: BoxFit.scaleDown,color:  CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white),)),
                                                        //   ),
                                                        //
                                                        // SizedBox(
                                                        //     height: Get.height*0.060,
                                                        //     width: Get.width*0.15,
                                                        //     child: Image.file(File( homeController.selectedImagePath3!.value))),
                                                        ),
                                                  ],
                                                )
                                              : SvgPicture.asset(
                                                  ImageString.imageIcon,
                                                  color: CommonFunctions.getThemeColor(light: Colors.black, dark: Colors.white),
                                                ),
                                          SizedBox(
                                            height: Get.height * 0.020,
                                          ),
                                          (homeController.selectedImagePath3S.isNotEmpty)
                                              ? Text("")
                                              : AppText(
                                                  text: "Middle",
                                                  height: 0.020,
                                                  fontFamily: ConstantStrings.fontFamilyMontserratSemiBold,
                                                  fontWeight: FontWeight.w600),
                                        ],
                                      ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height*0.020,),

                ],
              ),

              ))
            ])));
  }
}
