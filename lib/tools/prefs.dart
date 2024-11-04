
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tools {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static bool prefsIsInitialized = false;
}

extension SharedPreferencesExt on SharedPreferences {
  bool isLogged() {
    return getBool('islogged') ?? false;
  }

  BuildContext context() {
    return Tools.navigatorKey.currentContext!;
  }

  String webHost() {
    return 'office.jazzve.am';
  }
}

late final SharedPreferences prefs;