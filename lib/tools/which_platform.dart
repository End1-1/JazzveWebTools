import 'dart:js' as js;

String getUserAgent() {
  return js.context.callMethod('getUserAgent') as String;
}

bool isWebMobile() {
  String userAgent = getUserAgent().toLowerCase();
  return userAgent.contains('mobile') ||
      userAgent.contains('android') ||
      userAgent.contains('iphone');
}