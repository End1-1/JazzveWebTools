import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jazzve_web/screen/dish_removal_request/screen.dart';
import 'package:jazzve_web/screen/home/screen.dart';
import 'package:jazzve_web/screen/order_removal_request/screen.dart';
import 'package:jazzve_web/tools/bloc.dart';
import 'package:jazzve_web/tools/prefs.dart';
import 'package:jazzve_web/tools/which_platform_fail.dart' if (dart.library.html)  'package:jazzve_web/tools/which_platform.dart';

part 'screen.dates.dart';
part 'screen.menu.dart';
part 'screen.part.dart';

abstract class Screen extends StatelessWidget {
  var date1 = DateTime.now();
  var date2 = DateTime.now();
  var tempDate = DateTime.now();
  late Function getDateFunction;
  late Function(DateTime) setDateFunction;

  double _menuPos = 0;
  static String currentPageName = '';

  Screen({super.key}) {
    date1 = DateTime(date1.year, date1.month, date1.day);
    date2 = date1;
    getDateFunction = getDate1;
    setDateFunction = setDate1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Column(children: [
            menuHeader(context),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(10), child: body(context)))
          ]),
          loading(context),
          dialog(context),
          menu(context),
          dates()
        ],
      )),
    );
  }

  Widget body(BuildContext context);

  Widget loading(BuildContext context) {
    return BlocBuilder<ABloc, ASBase>(builder: (builder, state) {
      if (!state.loading) {
        return Container();
      }
      return Container(
        color: Colors.white,
        child: Column(children: [
          Expanded(child: Center(child: CircularProgressIndicator()))
        ]),
      );
    });
  }

  Widget dialog(BuildContext context) {
    return BlocBuilder<ABloc, ASBase>(builder: (builder, state) {
      if (state.message.isEmpty) {
        return Container();
      }
      return Container(
        color: Colors.black38,
        alignment: Alignment.center,
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.5,
                maxWidth: MediaQuery.sizeOf(context).width * 0.7),
            child: Column(
              children: [
                Expanded(child: Container()),
                SingleChildScrollView(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Expanded(
                          child:
                              Text(state.message, textAlign: TextAlign.center))
                    ])),
                rowSpace(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextButton(onPressed: dialogOk, child: Text('OK'))
                ]),
                Expanded(child: Container()),
              ],
            )),
      );
    });
  }

  Widget rowSpace() {
    return const SizedBox(height: 10);
  }

  Widget columnSpace() {
    return const SizedBox(width: 10);
  }

  Widget dates() {
    return BlocConsumer<AnimBloc, ASAnim>(listener: (builder, state) {
      if (state is ASAnimForward) {
        if (Platform.isWindows || Platform.isMacOS || (kIsWeb && !isWebMobile())) {
          showDatePicker(
            context: prefs.context(),
            initialDate: getDateFunction(),
            firstDate: getDateFunction().add(const Duration(days: -3600)),
            lastDate: getDateFunction().add(const Duration(days: 3600)),
          ).then((value) {
            if (value != null) {
              setDateFunction(value);
            }
          });
        }
      }
    }, builder: (builder, state) {
      if (Platform.isWindows || Platform.isMacOS) {
        return Container();
      }
      if (kIsWeb) {
        if (!isWebMobile()) {
          return Container();
        }
      }
      return AnimatedPositioned(
          bottom: state is ASAnimForward ? 0 : -500,
          duration: const Duration(milliseconds: 400),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                border:
                    Border.fromBorderSide(BorderSide(color: Colors.black38))),
            width: MediaQuery.sizeOf(prefs.context()).width,
            child: Column(
              children: [
                Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    alignment: Alignment.center,
                    child: Text('Date'.toUpperCase(),
                        style: const TextStyle(color: Colors.white))),
                const SizedBox(height: 10),
                Container(
                  height: 180,
                  child: _dateWidget(),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                    onPressed: () {
                      setDateFunction(tempDate);
                    },
                    child: Text('OK')),
                const SizedBox(height: 10)
              ],
            ),
          ));
    });
  }

  Widget _dateWidget() {
    return CupertinoDatePicker(
        initialDateTime: getDateFunction(),
        mode: CupertinoDatePickerMode.date,
        //minimumDate: dt.isBefore(DateTime.now()) ? dt : DateTime.now(),
        onDateTimeChanged: (val) {
          tempDate = val;
        });
  }
}
