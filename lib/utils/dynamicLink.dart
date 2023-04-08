// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:get/get.dart';
//
// import '../RouteHelper/route_helper.dart';
//
// class FirebaseDynamicLinkServices{
//
//   static Future<void> initDynamicLinks()async{
//     final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
//     if(initialLink!=null){
//
//     }
//     else{
//
//     }
//      FirebaseDynamicLinks.instance.onLink.listen( (dynamicLinkData) {
//       Get.toNamed(RouteHelper.login);
//       // final Uri uri=dynamicLinkData.link;
//       // final queryParams=uri.queryParameters;
//       // if(queryParams.isNotEmpty){
//       //   Get.toNamed(RouteHelper.login);
//       // }
//       // else{
//       //   Get.toNamed(RouteHelper.signUp);
//       // }
//     }).onError((error){
//       Get.toNamed(RouteHelper.signUp);
//     });
//   }
// }