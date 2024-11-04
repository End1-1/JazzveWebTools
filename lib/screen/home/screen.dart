import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jazzve_web/screen/base/screen.dart';
import 'package:jazzve_web/tools/acheckbox.dart';
import 'package:jazzve_web/tools/bloc.dart';
import 'package:jazzve_web/tools/prefs.dart';
import 'package:jazzve_web/tools/structs.dart';

part 'screen.part.dart';

class HomeScreen extends Screen {
  double _totalAmount = 0;
  double _totalQtn = 0;
  double _avgOrder = 0;
  double _totalAmountp = 0;
  double _totalQtnp = 0;
  double _avgOrderp = 0;
  double _totalAmounto = 0;
  double _totalQtno = 0;
  double _avgOrdero = 0;
  var _includeOpenOrders = true;

  static const cellDecorationWithTop = BoxDecoration(
      border: Border.fromBorderSide(BorderSide(color: Colors.black26)));
  static const cellHeaderStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12);
  static const cellDecoration = BoxDecoration(
      border: Border(
          bottom: BorderSide(color: Colors.black26),
          left: BorderSide(color: Colors.black26),
          right: BorderSide(color: Colors.black26)));

  HomeScreen({super.key}) {
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
              children: [Text(locale().revenue)]),
          rowSpace(),
          Row(children: [
            ACheckBox(_includeOpenOrders, locale().includeOpenOrder,
                _changeOpenOrderState)
          ]),
          rowSpace(),
          Expanded(child: SingleChildScrollView(child: _cafeList()))
        ],
      ),
    ]);
  }

  Widget _cafeList() {
    return BlocBuilder<ABloc, ASBase>(
        buildWhen: (p, c) => c is ASQueryCafeList,
        builder: (context, state) {
          if (state is ASQueryCafeList) {
            final l = CafeRecordList.fromJson(jsonDecode(state.body));
            _totalAmount = l.totalAmount();
            _totalQtn = l.totalOrders();
            _avgOrder = l.avgOrders();
            _totalAmountp = l.totalAmountp();
            _totalQtnp = l.totalOrdersp();
            _avgOrderp = l.avgOrdersp();
            _totalAmounto = l.totalAmounto();
            _totalQtno = l.totalOrderso();
            _avgOrdero = l.avgOrderso();
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _header(),
                  for (final c in l.list) ...[_cafeRow(c)],
                  _totalRow(),
                  const Divider(),
                  rowSpace(),
                  rowSpace(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(locale().openOrders)]),
                  _header(),
                  for (final c in l.list) ...[_cafeRowO(c)],
                  _totalRowO(),
                  const Divider(),
                  rowSpace(),
                  rowSpace(),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                        '${locale().previousDay} ${DateFormat('dd/MM/yyyy').format(date1.add(const Duration(days: -1)))}')
                  ]),
                  _header(),
                  for (final c in l.list) ...[_cafeRowPrev(c)],
                  _totalRowPrev(),
                  rowSpace(),
                ]);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget _header() {
    return Row(children: [
      Container(
          decoration: cellDecorationWithTop,
          width: 100,
          child: Text(locale().branch,
              style: cellHeaderStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis)),
      Container(
          decoration: cellDecorationWithTop,
          width: 50,
          child: Text(locale().orders,
              style: cellHeaderStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis)),
      Container(
          decoration: cellDecorationWithTop,
          width: 80,
          child: Text(locale().avgOrder,
              style: cellHeaderStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis)),
      Container(
          decoration: cellDecorationWithTop,
          width: 80,
          child: Text(locale().total,
              style: cellHeaderStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis)),
    ]);
  }

  Widget _cafeRow(CafeRecord cr) {
    NumberFormat nf = NumberFormat.decimalPattern('hy');
    return Row(children: [
      Container(decoration: cellDecoration, width: 100, child: Text(cr.ALIAS)),
      Container(
          decoration: cellDecoration,
          width: 50,
          child: Text(nf.format(cr.QNT))),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(cr.AVGORDER))),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(cr.AMOUNT))),
      columnSpace(),
    ]);
  }

  Widget _totalRow() {
    NumberFormat nf = NumberFormat.decimalPattern('hy');
    return Row(children: [
      Container(
          decoration: cellDecoration,
          width: 100,
          child: Text(locale().total, style: cellHeaderStyle)),
      Container(
          decoration: cellDecoration,
          width: 50,
          child: Text(nf.format(_totalQtn), style: cellHeaderStyle)),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(_avgOrder), style: cellHeaderStyle)),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(_totalAmount), style: cellHeaderStyle))
    ]);
  }

  Widget _cafeRowPrev(CafeRecord cr) {
    NumberFormat nf =
        NumberFormat.simpleCurrency(locale: 'hy', name: '', decimalDigits: 0);
    return Row(children: [
      Container(decoration: cellDecoration, width: 100, child: Text(cr.ALIAS)),
      Container(
          decoration: cellDecoration,
          width: 50,
          child: Text(nf.format(cr.QNTP))),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(cr.AVGORDERP))),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(cr.AMOUNTP))),
      columnSpace(),
    ]);
  }

  Widget _totalRowPrev() {
    NumberFormat nf =
        NumberFormat.simpleCurrency(locale: 'hy', name: '', decimalDigits: 0);
    return Row(children: [
      Container(
          decoration: cellDecoration,
          width: 100,
          child: Text(locale().total, style: cellHeaderStyle)),
      Container(
          decoration: cellDecoration,
          width: 50,
          child: Text(nf.format(_totalQtnp), style: cellHeaderStyle)),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(_avgOrderp), style: cellHeaderStyle)),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(_totalAmountp), style: cellHeaderStyle))
    ]);
  }

  Widget _cafeRowO(CafeRecord cr) {
    NumberFormat nf =
        NumberFormat.simpleCurrency(locale: 'hy', name: '', decimalDigits: 0);
    return Row(children: [
      Container(decoration: cellDecoration, width: 100, child: Text(cr.ALIAS)),
      Container(
          decoration: cellDecoration,
          width: 50,
          child: Text(nf.format(cr.QNTO))),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(cr.AVGORDERO))),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(cr.AMOUNTO))),
      columnSpace(),
    ]);
  }

  Widget _totalRowO() {
    NumberFormat nf =
        NumberFormat.simpleCurrency(locale: 'hy', name: '', decimalDigits: 0);
    return Row(children: [
      Container(
          decoration: cellDecoration,
          width: 100,
          child: Text(locale().total, style: cellHeaderStyle)),
      Container(
          decoration: cellDecoration,
          width: 50,
          child: Text(nf.format(_totalQtno), style: cellHeaderStyle)),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(_avgOrdero), style: cellHeaderStyle)),
      Container(
          decoration: cellDecoration,
          width: 80,
          child: Text(nf.format(_totalAmounto), style: cellHeaderStyle))
    ]);
  }
}
