import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jazzve_web/onlinestore/consts.dart' as Const;
import 'package:jazzve_web/onlinestore/goodsdriver.dart';
import 'package:jazzve_web/onlinestore/screens/filter/screen.dart';
import 'package:jazzve_web/tools/app_websocket.dart';
import 'package:jazzve_web/tools/prefs.dart';

class DashboardModel {
  GoodsList goodsList = GoodsList();
  GoodsList proxyGoodsList = GoodsList();
  TextEditingController searchInGoodsController = TextEditingController();
  final gridController = StreamController();

  var object = Const.cafeNames[0];
  var store = Const.storeNames[0];
  var month = _currentMonthName();
  var year = _currentYearName();

  void filter() {
    Navigator.push(prefs.context(),
            MaterialPageRoute(builder: (builder) => StoreFilter(this)))
        .then((value) {
      if (value != null && value) {
        showStore();
      }
    });
  }

  void showStore() async {
    gridController.add(true);
    final params = {
      "key": "adsfgjlsdkajfkskadfj",
      "command":"jzstore",
      "handler":"jzstore",
      "request": "store",
      "cafe": Const.cafeIds[Const.cafeNames.indexOf(object)],
      "store": Const.storeIds[Const.storeNames.indexOf(store)],
      "month": Const.months.indexOf(month),
      "year": Const.years.indexOf(year)
    };
    AppWebSocket.instance.sendMessage(jsonEncode(params), (body) {
      if ((body['errorCode']  ?? 1) > 0) {
        print('Error');
        return;
      }
      goodsList = GoodsList.fromJson(body['goods']);
      proxyGoodsList.goods.clear();
      proxyGoodsList.goods.addAll(goodsList.goods);
      gridController.add(1);
      gridController.add(body);
    });
  }

  void searchInGoods(String s) {
    proxyGoodsList.goods.clear();
    for (Goods g in goodsList.goods) {
      if (g.name.toLowerCase().contains(s.toLowerCase())) {
        proxyGoodsList.goods.add(g);
      }
    }
    gridController.add(1);
  }

  void clearSearch() {
    searchInGoodsController.clear();
    proxyGoodsList.goods.clear();
    proxyGoodsList.goods.addAll(goodsList.goods);
  }

  static String _currentMonthName() {
    var now = DateTime.now();
    return Const.months[now.month - 1];
  }

  static String _currentYearName() {
    var now = DateTime.now();
    return now.year.toString();
  }
}
