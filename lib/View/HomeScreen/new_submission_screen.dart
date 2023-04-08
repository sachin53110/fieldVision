import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/Controller/new_submission_controller.dart';
import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/View/HomeScreen/confirm_code_screen.dart';
import 'package:field_vision/widgets/appText.dart';
import 'package:field_vision/widgets/appTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../Controller/home_page_controller.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appYellowButton.dart';

class NewSubmissionScreen extends StatefulWidget {
  const NewSubmissionScreen({Key? key}) : super(key: key);

  @override
  State<NewSubmissionScreen> createState() => _NewSubmissionScreenState();
}

class _NewSubmissionScreenState extends State<NewSubmissionScreen> {

  final newSubmissionController=Get.put(NewSubmissionController());
  String _scanBarcode = 'Unknown';
  String? code="";
  String? brand="";
  String? location="";
  String? time="";
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if(barcodeScanRes !="-1"){
        List<String> result = barcodeScanRes.split('\n');
        if(result.length==1){
           code=result[0];
           brand="";
           location="";
           time="";
        }else{
           code=result[0];
           brand=result[1];
           location=result[2];
           time=result[3];
        }
        newSubmissionController.getKioskDetails(context, code!,brand!,location!,time!);
      }
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SingleChildScrollView(
        child: Obx(()=> Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(   (Get.isDarkMode)?ImageString.darkHomeTopIcon: ImageString.homeTopIcon,)),
            SizedBox(height: Get.height*0.020,),
            (newSubmissionController.checkCameraAndManualScan==false)?
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
                          AppText(text: ConstantStrings.scanQrCode,
                              height: 0.032,
                              fontFamily: ConstantStrings.fontFamilyMontserratBold,
                              fontWeight: FontWeight.w700),
                          SizedBox(height: Get.height*0.010,),
                          AppText(text: ConstantStrings.scanDescriptionText,
                              height: 0.021,
                            fontFamily: ConstantStrings.fontFamilyMontserrat,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500,
                              color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                          ),
                          SizedBox(height: Get.height*0.040,),
                          GestureDetector(
                              onTap: (){
                                scanQR();
                              },
                              child: SvgPicture.asset(ImageString.qR,height: Get.height*0.3,))
                        ],
                      )),
                  GestureDetector(
                    onTap: (){
                      newSubmissionController.checkCameraAndManualScan!.value=true;
                    },
                    child: AppYellowButton(
                      height: 0.075,
                      width: Get.width,
                      fontSize: 0.022,
                      borderRadius: Get.height*0.060,
                      textColor: Colors.black,
                      text: ConstantStrings.manualEnterQRCode,
                      color:  AppColors.appYellowColor,
                      borderWidth: 0,
                      borderColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ):
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
                          SvgPicture.asset((Get.isDarkMode)?ImageString.darkEnterQrCode: ImageString.enterQrCode),
                          SizedBox(height: Get.height*0.020,),
                          AppText(text: ConstantStrings.enterQrCode,
                              height: 0.032,
                              fontFamily: ConstantStrings.fontFamilyMontserratBold,
                              fontWeight: FontWeight.w700),
                          SizedBox(height: Get.height*0.010,),
                          AppText(text: ConstantStrings.enterQrCodeDescription,
                            height: 0.021,
                            fontFamily: ConstantStrings.fontFamilyMontserrat,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                            color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),
                          ),
                          SizedBox(height: Get.height*0.030,),
                         Obx(()=> TextFormField(

                        controller:  newSubmissionController.qrCode.value,
                        onChanged: (val){
                         newSubmissionController.qrCodeValue!.value=val;

                        },

                        style: TextStyle(
                            color:   CommonFunctions.getThemeColor(light: Colors.black, dark:Colors.white)),
                        decoration: InputDecoration(
                           // focusedBorder: OutlineInputBorder(
                           //     borderRadius: BorderRadius.circular(10),
                           //     borderSide: BorderSide(width: 1, color: AppColors.grayColor)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),), //<-- SEE HERE
                          ),
                          filled: true, //<-- SEE HERE
                          fillColor: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackButtonColor),
                          hintText:ConstantStrings.qRCode,

                          hintStyle: TextStyle(
                            fontSize: Get.height*0.020   ,
                            color: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                            fontFamily: ConstantStrings.fontFamilyMontserrat,
                          ),
                          prefixIcon: SvgPicture.asset( ImageString.qrPrefixIcon,

                          fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor),),
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
                          SizedBox(height: Get.height*0.025,),
                        ],
                      )),
                  Obx(()=>  GestureDetector(
                    onTap: (){
                    //  homeController.checkCameraAndManualScan!.value=false;
                      if(newSubmissionController.qrCodeValue!.value.isEmpty){
                        newSubmissionController.checkCameraAndManualScan!.value=false;
                       }
                       else{
                        newSubmissionController.getKioskDetails(context, newSubmissionController.qrCode.value.text,"","","");
                       }
                    },
                    child:AppYellowButton(
                      height: 0.075,
                      width: Get.width,
                      borderRadius: Get.height*0.060,
                      fontSize: 0.022,
                      textColor: Colors.black,
                      text: (newSubmissionController.qrCodeValue!.value.isEmpty)?ConstantStrings.scanQrCode:ConstantStrings.submit,
                      color:  AppColors.appYellowColor,
                      borderWidth: 0,
                      borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                    ),
                    )),
                ],
              ),
            )

          ],
        ),
        )),
    );
  }
}
