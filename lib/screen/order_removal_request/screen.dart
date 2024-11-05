import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jazzve_web/screen/base/screen.dart';
import 'package:jazzve_web/tools/bloc.dart';
import 'package:jazzve_web/tools/prefs.dart';
import 'package:jazzve_web/tools/styles.dart';

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
          Expanded(
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: _report())))
        ],
      ),
    ]);
  }

  Widget _report() {
    return BlocBuilder<ABloc, ASBase>(
        buildWhen: (p, c) => c is ASQueryOrderRemovalRequests,
        builder: (builder, state) {
          if (state is ASQueryOrderRemovalRequests) {
            return Column(children: [
              for (final e in jsonDecode(state.body)) ...[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(e['CAFE'], style: middleBoldText),
                ]),
                if (e['DATA'].isNotEmpty)
                  Row(children: [
                    TableHeader(locale().orderNum, 100),
                    TableHeader(locale().state, 100),
                    TableHeader(locale().dateOpen, 100),
                    TableHeader(locale().table, 100),
                    TableHeader(locale().amount, 100),
                    TableHeader(locale().action, 100),
                  ]),
                _orders(e['DATA'], e['CAFEID']),
                const Divider(thickness: 2)
              ]
            ]);
          }
          return Container();
        });
  }

  Widget _orders(dynamic d, int cafeid) {
    return Column(children: [
      for (final e in d) ...[
        Row(children: [
          TableDataCell(e['ID'], 100),
          TableDataCell(e['STATE_NAME'], 100),
          TableDataCell(e['DATE_OPEN'], 100),
          TableDataCell(e['TABLE_NAME'], 100),
          TableDataCell('${e['AMOUNT']}', 100),
          Container(
              decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                  border:
                      Border.fromBorderSide(BorderSide(color: Colors.black45))),
              height: 40,
              width: 100,
              child: Row(children: [
                IconButton(
                    onPressed: () {
                      _openOrder(e['ID'], cafeid);
                    },
                    icon: const Icon(Icons.folder_open_rounded)),
                columnSpace(),
                if (e['STATE_ID'] == 1 || e['STATE_ID'] ==2)
                IconButton(
                    onPressed: () {
                      _accept(e['ID'], cafeid);
                    },
                    icon: const Icon(Icons.change_circle_rounded))
              ]))
        ]),
      ]
    ]);
  }
}
