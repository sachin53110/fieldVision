import 'package:field_vision/Constants/ColorConstant.dart';
import 'package:field_vision/Constants/ImageConstant.dart';
import 'package:field_vision/View/LoginScreen/introduction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constants/ConstantStrings.dart';
import '../../Controller/dynamic_links_controller.dart';
import '../../RouteHelper/route_helper.dart';
import '../../services/prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateHome();
    AppDynamicLinksController.initDynamicLinks();

  }

  _navigateHome() async{
    await Future.delayed(const Duration(milliseconds: 3000),(){
      String? userStatus= Prefs.getString(ConstantStrings.userLogin)??"";
      if(userStatus.isNotEmpty){
        return Get.offAllNamed(RouteHelper.getHomeSubmissionsScreen());
      }
      return Get.offAllNamed(RouteHelper.getIntroScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     color: AppColors.appYellowColor,
     child: Center(
       child: SvgPicture.asset(ImageString.splashImage,
        fit: BoxFit.scaleDown,
       ),
     ),
    );
  }
}
