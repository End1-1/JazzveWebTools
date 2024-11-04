import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jazzve_web/screen/base/screen.dart';
import 'package:jazzve_web/tools/bloc.dart';
import 'package:jazzve_web/tools/prefs.dart';

part 'screen.part.dart';

class OrderRemovalRequestScreen extends Screen {
  OrderRemovalRequestScreen({super.key}) {
    _refresh();
  }

  @override
  Widget body(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          rowSpace(),
          BlocBuilder<AnimBloc, ASAnim>(builder: (builder, state) {
            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  onPressed: previousDay,
                  icon: const Icon(Icons.chevron_left, size: 30)),
              columnSpace(),
              InkWell(
                onTap: openDate1,
                child: Text(DateFormat('dd/MM/yyyy').format(date1)),
              ),
              const Text(" - "),
              InkWell(
                onTap: openDate2,
                child: Text(DateFormat('dd/MM/yyyy').format(date2)),
              ),
              columnSpace(),
              IconButton(
                  onPressed: nextDay,
                  icon: const Icon(Icons.chevron_right, size: 30)),
              columnSpace(),
              IconButton(
                  onPressed: _refresh, icon: const Icon(Icons.refresh_sharp))
            ]);
          }),
          rowSpace(),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(locale().orderRemovalRequest)]),
          rowSpace(),
          rowSpace(),
          Expanded(child: SingleChildScrollView(child: _report()))
        ],
      ),
    ]);
  }

  Widget _report() {
    return BlocBuilder<ABloc, ASBase>(
        buildWhen: (p, c) => c is ASQueryOrderRemovalRequests,
        builder: (builder, state) {
          print(state.body);
          return const Column(children: [

          ]);
        });
  }
}
