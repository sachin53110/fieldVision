import 'package:field_vision/services/prefs.dart';
import 'package:flutter/material.dart';

class ThemeService {
     //var value= Prefs.setBool("theme", false);
  bool checks() {
    bool accessToken = Prefs.getBool('theme') ?? false;
    return accessToken;
  }
  ThemeMode get theme => checks()? ThemeMode.dark : ThemeMode.light;
}