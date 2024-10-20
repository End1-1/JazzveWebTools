import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jazzve_web/screen/base/screen.dart';
import 'package:jazzve_web/screen/home/screen.dart';
import 'package:jazzve_web/screen/tools/acheckbox.dart';
import 'package:jazzve_web/screen/tools/bloc.dart';
import 'package:jazzve_web/screen/tools/prefs.dart';

part 'screen.part.dart';

class LoginScreen extends Screen {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  var _rememberMeCheck = false;

  LoginScreen({super.key});

  @override
  Widget body(BuildContext context) {
    return BlocConsumer<ABloc, ASBase>(listener: (context, state) {
      if (state is ASQueryDone && state.message.isEmpty) {
        final data = jsonDecode(state.body);
        prefs.setString('fname', data['FNAME']);
        prefs.setString('lname', data['LNAME']);
        prefs.setString('bearer', data['bearer']);
        prefs.setBool('rememberme', _rememberMeCheck);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => HomeScreen()),
            (_) => false);
      }
    }, builder: (builder, state) {
      return Center(
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset('assets/icon.png', height: 50)]),
            rowSpace(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: TextFormField(
                      controller: _loginController,
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: locale().login,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)))))
            ]),
            rowSpace(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      onFieldSubmitted: _enter2,
                      decoration: InputDecoration(
                          hintText: locale().password,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)))))
            ]),
            rowSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ACheckBox(
                    _rememberMeCheck, locale().rememberMe, _checkRememberMe)
              ],
            ),
            rowSpace(),
            OutlinedButton(onPressed: _enter, child: Text(locale().enter))
          ],
        ),
      );
    });
  }
}
