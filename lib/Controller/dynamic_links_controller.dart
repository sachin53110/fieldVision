import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

import '../RouteHelper/route_helper.dart';

class AppDynamicLinksController{

 static FirebaseDynamicLinks dynamicLinks=FirebaseDynamicLinks.instance;


  static Future<void> initDynamicLinks()async{


    dynamicLinks.onLink.listen((dynamicLinkData) async{

      print("dynamicLinkData  ------------ > $dynamicLinks ${dynamicLinkData.link} ");
      // final Uri uri=dynamicLinkData.link;
      // final queryParams=uri.queryParameters;
      // if(queryParams.isNotEmpty){
    //  await Future.delayed(Duration(seconds: 3));

        Get.toNamed(RouteHelper.changePassword);
      // }
      // else{
      //   Get.toNamed(RouteHelper.login);
      // }
    }).onError((error){

      Get.toNamed(RouteHelper.splash);
    });
  }



}