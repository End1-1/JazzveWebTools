import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jazzve_web/screen/dish_removal_request/screen.dart';
import 'package:jazzve_web/screen/home/screen.dart';
import 'package:jazzve_web/screen/order_removal_request/screen.dart';
import 'package:jazzve_web/screen/tools/bloc.dart';
import 'package:jazzve_web/screen/tools/prefs.dart';

part 'screen.part.dart';
part 'screen.menu.dart';

abstract class Screen extends StatelessWidget {
  double _menuPos = 0;
  static String currentPageName = '';
  Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        
          child: Stack(
        children: [
          Column(children: [
            menuHeader(context),
           Expanded(child: Container(
             padding: const EdgeInsets.all(10),
               child:  body(context)))]),
          loading(context), dialog(context),
          menu(context)
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
                SingleChildScrollView(child:  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: Text(state.message, textAlign: TextAlign.center))
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
}
