import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jazzve_web/screen/tools/bloc.dart';
import 'package:jazzve_web/screen/tools/prefs.dart';


class ScreenDate extends StatelessWidget {
  late DateTime dt;
  final Function(DateTime) func;
  ScreenDate(this.dt, this.func, {super.key}) ;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimBloc, ASAnim>(builder: (builder, state) {
      return AnimatedPositioned(
          bottom: state is ASAnimForward ? 0 : -500,
          duration: const Duration(milliseconds: 400),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20)),
                border: Border.fromBorderSide(BorderSide(color: Colors.black38))
            ),
            width: MediaQuery.sizeOf(context).width,
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
                    child: Text('Date'.toUpperCase(), style: const TextStyle(color: Colors.white))),
                const SizedBox(height: 10),
                Container(
                  height: 180,
                  child: CupertinoDatePicker(
                      initialDateTime: dt,
                      mode: CupertinoDatePickerMode.date,
                      //minimumDate: dt.isBefore(DateTime.now()) ? dt : DateTime.now(),
                      onDateTimeChanged: (val) {
                        dt = val;
                      }),
                ),
                const SizedBox(height: 10),
                OutlinedButton(onPressed: (){
                  BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimBackward()));
                  func(dt);
                }, child: Text('OK')),
                const SizedBox(height: 10)
              ],
            ),
          ));});
  }

}