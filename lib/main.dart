import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jazzve_web/screen/home/screen.dart';
import 'package:jazzve_web/screen/login/screen.dart';
import 'package:jazzve_web/screen/splash/screen.dart';
import 'package:jazzve_web/tools/bloc.dart';
import 'package:jazzve_web/tools/prefs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => ABloc(ASBase())),
    BlocProvider(create: (_) => AnimBloc(ASAnim()))
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Tools.navigatorKey,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      locale: const Locale('hy'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('hy'), // Spanish
      ],
      home: FutureBuilder<Object?>(future: load(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        return prefs.isLogged() ? HomeScreen() : LoginScreen();
      }),
    );
  }

  Future<Object?> load() async {
    if (!Tools.prefsIsInitialized) {
      prefs = await SharedPreferences.getInstance();
      Tools.prefsIsInitialized = true;
      final packageInfo = await PackageInfo.fromPlatform();
        String appName = packageInfo.appName;
        prefs.setString('appname', appName);
        //String packageName = packageInfo.packageName;
        String version = packageInfo.version;
        String buildNumber = packageInfo.buildNumber;
        prefs.setString('appversion', '$version.$buildNumber');

    }
     if ((prefs.getString('bearer') ?? '').isNotEmpty) {
       final response = await http
           .post(Uri.https(prefs.webHost(), 'engine/index.php'),
           headers: {
             HttpHeaders.authorizationHeader:
             'Bearer ${prefs.getString('bearer')}',
           },
           body: {'task': 'CheckBearer'})
           .timeout(const Duration(seconds: 20), onTimeout: () {
         return http.Response('Timeout', 408);
       });
       if (kDebugMode) {
         print('CheckBearer: ${response.statusCode} ${utf8.decode(response.bodyBytes)}');
       }
       prefs.setBool('islogged', response.statusCode < 299);
       if (response.statusCode > 299) {
         prefs.setString('bearer', '');
       }
     }
  }
}

