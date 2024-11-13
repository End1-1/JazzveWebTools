import 'dart:js' as js;

import 'package:flutter/cupertino.dart';
import 'package:jazzve_web/tools/prefs.dart';

String getUserAgent() {
  return js.context.callMethod('getUserAgent') as String;
}

bool isWebMobile() {
  print('Media width: ${MediaQuery.sizeOf(prefs.context()).width}');
  return MediaQuery.sizeOf(prefs.context()).width < 700;
  // String userAgent = getUserAgent().toLowerCase();
  // return userAgent.contains('mobile') ||
  //     userAgent.contains('android') ||
  //     userAgent.contains('iphone');
}