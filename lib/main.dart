import 'package:field_vision/Controller/dynamic_links_controller.dart';
import 'package:field_vision/services/app_theme.dart';
import 'package:field_vision/services/prefs.dart';
import 'package:field_vision/services/theme_service.dart';
import 'package:field_vision/utils/dynamicLink.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'RouteHelper/route_helper.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'View/HomeScreen/Inspect_kiosk_screen.dart';
import 'View/LoginScreen/splashScreen.dart';


void main() async{
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   // options: DefaultFirebaseConfig.platformOptions,
  );
  await Prefs.init(); // initialize here ! important
  AppDynamicLinksController.initDynamicLinks(

  );

//   FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
//     print("dynamicLinkData  ------------ > $dynamicLinkData ${dynamicLinkData.link} ");
//
// // Get.toNamed(RouteHelper.login);
// // final Uri uri=dynamicLinkData.link;
// // final queryParams=uri.queryParameters;
// // if(queryParams.isNotEmpty){
// //   Get.toNamed(RouteHelper.login);
// // }
// // else{
// //   Get.toNamed(RouteHelper.signUp);
// // }
//   }).onError((error){
// // Get.toNamed(RouteHelper.signUp);
//   });
  runApp(const MyApp());
}







class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: (){
       //  AppDynamicLinksController.initDynamicLinks();

      },
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.getSplash(),
      getPages: RouteHelper.routes,
     // home: const InspectScreen(),
    );
  }
}

