import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/Constants/ConstantStrings.dart';
import 'package:field_vision/utils/CommonFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextField extends StatelessWidget {

  final TextEditingController textController;
  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Color textColor;
  final bool? obscureText;
  final VoidCallback? callbackSuffix;
  final FormFieldValidator<String>? validator;
  bool? readOnly;
  int? minChar;
  final ValueChanged<String>? onChanged;
  final Color? textBorderColor;
  final Color? textFieldLight;
  final Color? textFieldDark;
  AppTextField({Key? key,
    required this.textController, required this.hintText, required this.prefixIcon,this.suffixIcon,
  required this.textColor,this.obscureText,this.callbackSuffix,this.suffix,this.validator,this.readOnly,this.minChar,
  this.onChanged,this.textBorderColor ,this.textFieldLight,this.textFieldDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
          readOnly: readOnly??false,
          textAlign: TextAlign.start,
          maxLength: minChar,
          validator: validator,
         onChanged: onChanged,
          obscureText:obscureText ?? false,
          controller: textController,
          style: TextStyle(
            fontFamily: ConstantStrings.fontFamilyMontserrat,
              color: CommonFunctions.getThemeColor(light: textFieldLight?? Colors.black, dark:textFieldDark?? Colors.white),),
          decoration: InputDecoration(
            focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide( color: textBorderColor ?? Colors.blue ),
            ),
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: CommonFunctions.getThemeColor(light: AppColors.grayColor, dark: AppColors.darkBackButtonColor),), //<-- SEE HERE
            ),
            filled: true, //<-- SEE HERE
            fillColor: CommonFunctions.getThemeColor(light: Colors.white, dark: AppColors.darkBackButtonColor),
            hintText:
             hintText,
            hintStyle: TextStyle(
                fontFamily: ConstantStrings.fontFamilyMontserrat,
              color:  textColor,
              fontSize: Get.height*0.020
            ),
            prefixIcon: prefixIcon,
             suffixIcon: IconButton(
               hoverColor: Colors.transparent,
               icon: suffix ?? Container(),
               onPressed: callbackSuffix,
             ),

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
        );

  }
}
