import 'dart:io';

import 'package:field_vision/Controller/drawer_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appText.dart';
import '../../widgets/appTextField.dart';
import '../../widgets/appYellowButton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final drawerController=Get.put(DrawerControllers());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    drawerController.createBox();
    drawerController.checkEditSave!.value=false;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => drawerController.profile());
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: drawerController.profileFormKey,
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.050),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(()=>
                  GestureDetector(
                    onTap: (){
                      drawerController.checkEditSave!.value = !drawerController.checkEditSave!.value;
                      if(drawerController.checkEditSave!.value==false){
                        if(drawerController.profileFormKey.currentState!.validate()){
                          drawerController.updateProfile(drawerController.profileName.text, drawerController.profileEmail.text, drawerController.profilePassword.text
                          ,File(drawerController.selectedImagePath.value)
                          );
                        }else{
                          drawerController.checkEditSave!.value=true;
                        }
                      }
                    },
                    child: AppYellowButton(
                      height: 0.075,
                      width: Get.width,
                      fontSize: 0.022,
                      textColor: Colors.black,
                      borderRadius: Get.height*0.060,
                      text: (drawerController.checkEditSave!.value)?ConstantStrings.save:ConstantStrings.editProfile,
                      color:  AppColors.appYellowColor,
                      borderWidth: 0,
                      borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                    ),
                  ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(left:  Get.width*0.050,right: Get.width*0.050),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height*0.15,),
                     Obx(()=> Container(

                        padding:  EdgeInsets.all(Get.height * 0.015),
                        decoration: BoxDecoration(
                          color: AppColors.dottedBorderColor,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            (drawerController.selectedImagePath.value !='')?
                            CircleAvatar(
                              radius: Get.height*0.070,
                              child: ClipOval(child:
                              Image.file(File(drawerController.selectedImagePath.value),
                                height: Get.height * 0.14,
                                width: Get.width * 0.28,fit: BoxFit.fill ,)
                              ),
                            ):(drawerController.profileImage.value !="")?
                            ClipOval(child: Image.network(ConstantStrings.profileImageUrl+ drawerController.profileImage.value,  height: Get.height * 0.13,
                              width: Get.width * 0.25,fit: BoxFit.fill ,)):
                            SvgPicture.asset(ImageString.drawerDemoProfile,),
                            Positioned(
                              right: -5.0,
                              bottom: -5.0,
                              child: GestureDetector(
                                onTap: () {
                                 drawerController.imagePickerOption();
                                },
                                child: (drawerController.checkEditSave!.value)?SvgPicture.asset(ImageString.cameraIcon):Container()
                              ),
                            )
                          ],
                        ),
                      )),
                      SizedBox(height: Get.height*0.010,),

                     Obx(()=> AppText(text: drawerController.userName!.value,
                          fontFamily: ConstantStrings.fontFamilyMontserratBold,
                          height: 0.020, fontWeight: FontWeight.w500)),
                      SizedBox(height: Get.height*0.005,),
                    Obx(()=>  AppText(text: drawerController.userEmail!.value,
                        fontFamily: ConstantStrings.fontFamilyMontserrat,
                        height: 0.018, fontWeight: FontWeight.w500
                      ,color:  CommonFunctions.getThemeColor(light:
                        AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor)
                        ,)),
                      SizedBox(height: Get.height*0.040,),
                     Obx(()=> AppTextField(
                       validator: (value){
                        return drawerController.validationName(value!);
                       },
                        readOnly: (drawerController.checkEditSave!.value)?false:true,
                        textColor: CommonFunctions.getThemeColor(light: Colors.grey, dark: AppColors.darkDotsIndicatorColor),
                        hintText: "Name",
                       textFieldLight: (drawerController.checkEditSave!.value)?Colors.black:Colors.grey,
                       textFieldDark: (drawerController.checkEditSave!.value)?Colors.black:Colors.grey,
                       textBorderColor: (drawerController.checkEditSave!.value)?Colors.blue:Colors.grey,
                        prefixIcon: SvgPicture.asset(ImageString.drawerProfile,fit: BoxFit.scaleDown,color:  CommonFunctions.getThemeColor(light: ( drawerController.checkEditSave!.value)? Colors.black:Colors.grey, dark: AppColors.darkDotsIndicatorColor),),
                        textController: drawerController.profileName,
                      )),
                      SizedBox(height: Get.height*0.020,),
                    AppTextField(
                      validator: (value){
                       return drawerController.validationEmail(value!);
                      },
                        readOnly:true,
                        textColor: CommonFunctions.getThemeColor(light:  Colors.grey, dark: AppColors.darkDotsIndicatorColor),
                        hintText: "",
                      textFieldLight: Colors.grey,
                      textFieldDark: Colors.grey,
                        textBorderColor: Colors.grey,
                        prefixIcon: SvgPicture.asset(ImageString.email,fit: BoxFit.scaleDown,color:  CommonFunctions.getThemeColor(light: Colors.grey, dark: AppColors.darkDotsIndicatorColor),),
                        textController: drawerController.profileEmail,
                      ),
                     // SizedBox(height: Get.height*0.020,),
                     // Obx(()=> AppTextField(
                     //   validator: (value){
                     //   return  drawerController.validationPassword(value!);
                     //   },
                     //   readOnly: (drawerController.checkEditSave!.value)?false:true,
                     //    textColor: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                     //    hintText: "********",
                     //    obscureText: drawerController.drawerPasswordShow!.value,
                     //    callbackSuffix: (){
                     //      drawerController.drawerPasswordShow!.value = !drawerController.drawerPasswordShow!.value;
                     //    },
                     //    suffix:  SvgPicture.asset((drawerController.drawerPasswordShow!.value)?ImageString.eyeClose:ImageString.passEyeIcon,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),height: Get.height*0.020,),
                     //    suffixIcon: SvgPicture.asset(ImageString.passEyeIcon,fit: BoxFit.scaleDown,color:  CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),
                     //    prefixIcon: SvgPicture.asset(ImageString.lock,fit: BoxFit.scaleDown,color:  CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),
                     //    textController: drawerController.profilePassword,
                     // )),


                    ],

                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
