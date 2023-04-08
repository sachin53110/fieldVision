import 'dart:io';

import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/Model/profileModel.dart';
import 'package:field_vision/Model/updateProfileModel.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/error_model.dart';
import '../network/api_provider.dart';
import '../utils/app_loader.dart';
import '../utils/error_snackbar.dart';

class DrawerControllers extends GetxController{

  TextEditingController profileEmail=TextEditingController();
  TextEditingController profilePassword=TextEditingController();
  TextEditingController profileName=TextEditingController();

  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
   RxBool? checkEditSave=false.obs;

   RxBool? toggleCheck=false.obs;



   RxBool? drawerPasswordShow=false.obs;


  String? firstName;
  String? lastName;
  var userName ="".obs;
  var userEmail = "".obs;
  var profileImage="".obs;
  RxString? password="*********".obs;

  userProfile(){
    firstName=Prefs.getString(ConstantStrings.firstName);
    lastName=Prefs.getString(ConstantStrings.lastName);
    userName.value ="${firstName.toString()}${" "}${lastName.toString()}";
    userEmail.value=Prefs.getString(ConstantStrings.userEmail).toString();
    profileImage.value=Prefs.getString(ConstantStrings.imageShare).toString();
  }
  validationName(String value){
    if(value.isEmpty){
      return "Name is required";
    }
    return null;
  }
  validationEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid email";
    }
    return null;
  }
  validationPassword(String value) {
    if (value.length <= 7||value=="********"||value.isEmpty) {
      return "Password must be of 8 characters";
    }
    return null;
  }
  late Box box;
  void createBox() async{
    box=await Hive.openBox("imageStore");

  }


   profile() async{
   // CommanDialog.showLoading();
    try{
      var response = await ApiProvider().profile();
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
       // CommanDialog.hideLoading();
      } else {
        if ((response as ProfileModel).status != null){
        //  CommanDialog.hideLoading();
          Prefs.setString(ConstantStrings.firstName, response.data!.user!.firstName??"");
          Prefs.setString(ConstantStrings.lastName, response.data!.user!.lastName??"");
          Prefs.setString(ConstantStrings.userEmail, response.data!.user!.email.toString());
          Prefs.setString(ConstantStrings.imageShare, response.data!.user!.image??"");
          Prefs.setString(ConstantStrings.passwordSharePref, response.data!.user!.password.toString());
          //profilePassword.text=response.data!.user!.password.toString();
          profilePassword.text="********";
          profileEmail.text=response.data!.user!.email.toString();
          if(response.data!.user!.firstName!=null){
            profileName.text="${response.data!.user!.firstName??""}${" "}${response.data!.user!.lastName??""}";
          }
          userProfile();
        }
      }
    }
    catch(e){
      //CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  updateProfile(String name, String email,String password,File image) async{
    CommanDialog.showLoading();
    try{
      var response = await ApiProvider().updateProfile(name, email, password,image);
      if (response is ErrorMessage) {
        toastMessage(response.message!, );
        CommanDialog.hideLoading();
      } else {
        if ((response as UpdateProfileModel).status != null){
          CommanDialog.hideLoading();
          Prefs.setString(ConstantStrings.firstName, response.data!.user!.firstName??"");
          Prefs.setString(ConstantStrings.lastName, response.data!.user!.lastName??"");
          Prefs.setString(ConstantStrings.userEmail, response.data!.user!.email.toString());
          Prefs.setString(ConstantStrings.imageShare, response.data!.user!.image??"");
          Prefs.setString(ConstantStrings.passwordSharePref, response.data!.user!.password.toString());
          profilePassword.text="********";
          profileEmail.text=response.data!.user!.email.toString();
          if(response.data!.user!.firstName!=null){
            profileName.text="${response.data!.user!.firstName??""}${" "}${response.data!.user!.lastName??""}";
          }

         // profileName.text="${response.data!.user!.firstName??""}${" "}${response.data!.user!.lastName??""}";
          userProfile();
        }
      }
    }
    catch(e){
      CommanDialog.hideLoading();
      toastMessage(ApiProvider().handleError(e));
    }finally {}
  }

  var selectedImagePath="".obs;
  var selectedImageSize="".obs;
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo != null) {
          selectedImagePath.value=photo.path;
          final tempImage = File(photo.path);
          pickedImage=tempImage;
          box.put("profileImagePath", selectedImagePath.value);
          selectedImageSize.value=(File(selectedImagePath.value).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";
        Get.back();

      }else{
        Get.snackbar("Error", 'No image Selected',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  File? pickedImage;


void imagePickerOption() {
  Get.bottomSheet(
    SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: (Get.isDarkMode)?AppColors.darkBackgroundColor:Colors.white,
          height: Get.height*0.33,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Pic Image From",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                 SizedBox(
                  height: Get.height*0.010,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.appYellowColor,
                      ),
                  icon: const Icon(Icons.camera,color: Colors.black,),
                  label: const Text("CAMERA",style: TextStyle(color: Colors.black),),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.appYellowColor,
                  ),
                  icon: const Icon(Icons.image,color: Colors.black,),
                  label: const Text("GALLERY",style: TextStyle(color: Colors.black),),
                ),
                 SizedBox(
                  height: Get.height*0.010,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.appYellowColor,
                  ),
                  icon: const Icon(Icons.close,color: Colors.black,),
                  label: const Text("CANCEL",style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

}