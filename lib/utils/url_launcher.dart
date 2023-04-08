import 'package:url_launcher/url_launcher.dart';

class MapUtils{
  MapUtils._();
  static Future<void> openUrlLink(String link)async{

    if(await canLaunch(link)){
      await launch(link);
    }else{
      throw 'Could not open the gmail';
    }
  }
}