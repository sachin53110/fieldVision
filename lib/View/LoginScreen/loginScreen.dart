import 'package:field_vision/RouteHelper/route_helper.dart';
import 'package:field_vision/View/LoginScreen/forgotPasswordScreen.dart';
import 'package:field_vision/View/LoginScreen/signUpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../Constants/ColorConstant.dart';
import '../../Constants/ConstantStrings.dart';
import '../../Constants/ImageConstant.dart';
import '../../Controller/authController.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/appBarWidget.dart';
import '../../widgets/appText.dart';
import '../../widgets/appTextField.dart';
import '../../widgets/appYellowButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController=Get.put(AuthController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late Box box;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBox();
  }
  void createBox() async{
   box=await Hive.openBox("loginData");
    getData();
  }
  getData(){
    if(box.get("email")!=null){
      authController.loginEmail.text=box.get("email");
      authController.checkBoxValue = true.obs;
      setState(() {

      });
    }
    if(box.get("pass")!=null){
      authController.loginPassword.text=box.get("pass");
      authController.checkBoxValue = true.obs;
      setState(() {

      });
    }
  }
  rememberMe(){
    if(authController.checkBoxValue==true.obs){
      box.put("email", authController.loginEmail.text );
      box.put("pass",  authController.loginPassword.text);
    }else{
      box.clear();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                // style: DefaultTextStyle.of(context).style,
                children:  <TextSpan>[
                  TextSpan(text: ConstantStrings.dontHaveAccount, style: TextStyle(
                      fontFamily: ConstantStrings.fontFamilyMontserrat
                      ,fontWeight: FontWeight.w500,
                      fontSize: Get.height*0.018,
                      color: CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor))),
                  TextSpan(text: ConstantStrings.signUp,style: TextStyle(
                    fontFamily: ConstantStrings.fontFamilyMontserratSemiBold
                    ,fontWeight: FontWeight.w500,
                    fontSize: Get.height*0.020,
                    color: CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white)  ,decoration: TextDecoration.underline,),
                      recognizer:  TapGestureRecognizer()
                        ..onTap = (){
                          Get.toNamed(RouteHelper.getSignUpPage());
                        }),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height*0.040,),
        ],
      ),
      body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset((Get.isDarkMode)?ImageString.darkTopLoginDesign: ImageString.topLoginDesign,)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppBarWidget(text: "",),
                      SizedBox(height: Get.height*0.1,),
                      Form(
                        key: loginFormKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: ConstantStrings.login,
                                height: 0.040,
                                fontFamily: ConstantStrings.fontFamilyMontserratBold,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: Get.height*0.015,),
                              AppText(
                                text: ConstantStrings.signUpDetail,
                                height: 0.018,
                                fontFamily: ConstantStrings.fontFamilyMontserrat,
                                fontWeight: FontWeight.w500,
                                  color:  CommonFunctions.getThemeColor(
                                      light: AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor)
                              ),
                              SizedBox(height: Get.height*0.030,),
                              AppTextField(
                                validator: (value){
                                  return authController.validationEmail(value!);
                                },
                                hintText: ConstantStrings.email,
                                textColor: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                                prefixIcon: SvgPicture.asset(ImageString.email,
                                  fit: BoxFit.scaleDown,
                                  color:  CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),
                                textController: authController.loginEmail,
                              ),
                              SizedBox(height: Get.height*0.020,),
                            Obx(()=>  AppTextField(
                              validator: (value){
                                return authController.validationLoginPassword(value!);
                              },
                              minChar: 15,
                                textColor: CommonFunctions.getThemeColor(light: AppColors.placeHolderColor, dark: AppColors.darkDotsIndicatorColor),
                                hintText: ConstantStrings.password,
                                obscureText: authController.loginPasswordShow!.value,
                                callbackSuffix: (){
                                  authController.loginPasswordShow!.value = !authController.loginPasswordShow!.value;
                                },
                                suffix:  SvgPicture.asset((authController.loginPasswordShow!.value)?ImageString.eyeClose:ImageString.passEyeIcon,fit: BoxFit.scaleDown,color: CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),height: Get.height*0.020,),
                                prefixIcon: SvgPicture.asset(ImageString.lock,fit: BoxFit.scaleDown,
                                  color:  CommonFunctions.getThemeColor(light: Colors.black, dark: AppColors.darkDotsIndicatorColor),),

                                textController: authController.loginPassword,
                              )),
                              SizedBox(height: Get.height*0.025,),
                              Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.030,
                                    width: Get.width * 0.070,
                                    child: Checkbox(
                                      checkColor: Colors.black,
                                      activeColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      side: MaterialStateBorderSide.resolveWith(
                                            (states) => BorderSide(
                                              color:  CommonFunctions.getThemeColor(light:Colors.black, dark: Colors.white),
                                          width: 1.0,
                                        ),
                                      ),
                                      value: authController.checkBoxValue!.value,
                                      onChanged: (bool? value) {
                                          authController.checkBoxValue!.value = value!;
                                          setState(() {

                                          });
                                      },
                                    ),
                                  ),
                                  AppText(
                                      text: ConstantStrings.rememberMe,
                                      height: 0.018,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: ConstantStrings.fontFamilyMontserrat,
                                      color:  CommonFunctions.getThemeColor(light:AppColors.grayColor, dark: AppColors.darkDotsIndicatorColor)
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(RouteHelper.getForgotPasswordScreen());
                                        },
                                        child:  AppText(
                                            text: ConstantStrings.forgotPasswordWithQuestionMark,
                                            height: 0.018,
                                          fontFamily: ConstantStrings.fontFamilyMontserrat,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.end,
                                        ),
                                    ),
                                  )
                                ],
                              )),
                              SizedBox(height: Get.height*0.040,),
                              GestureDetector(
                                onTap: (){
                                rememberMe();
                                  if (loginFormKey.currentState!
                                      .validate()){
                                   // authController.rememberMe();
                                    authController.login(context,authController.loginEmail.text, authController.loginPassword.text);
                                    //Get.toNamed(RouteHelper.getHomeSubmissionsScreen());
                                  }

                                },
                                child: AppYellowButton(
                                  height: 0.075,
                                  width: Get.width,
                                  textColor: Colors.black,
                                  borderRadius: 15,
                                  fontSize: 0.025,
                                  text: ConstantStrings.login,
                                  color:  AppColors.appYellowColor,
                                  borderWidth: 0,
                                  borderColor:  CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackgroundColor),
                                ),
                              ),
                            ],
                          ),
                      ),

                      SizedBox(height: Get.height*0.035,),

                    ],
                  ),
                ),
              ),
            ),


          ],
        ),

    );
  }
}
