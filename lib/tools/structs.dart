import 'package:freezed_annotation/freezed_annotation.dart';

part 'structs.freezed.dart';
part 'structs.g.dart';

@freezed
class CafeRecord with _$CafeRecord {
  const factory CafeRecord(
      {required int ID,
      required String ALIAS,
      required String WEB,
      required int QNT,
      required int AVGORDER,
      required int AMOUNT,
      required int QNTP,
      required int AVGORDERP,
      required int AMOUNTP,
      required int QNTO,
      required int AVGORDERO,
      required int AMOUNTO}) = _CafeRecord;

  factory CafeRecord.fromJson(Map<String, dynamic> json) =>
      _$CafeRecordFromJson(json);
}

@freezed
class CafeRecordList with _$CafeRecordList {
  const CafeRecordList._();

  const factory CafeRecordList({required List<CafeRecord> list}) =
      _CafeRecordList;

  factory CafeRecordList.fromJson(Map<String, dynamic> json) =>
      _$CafeRecordListFromJson(json);

  double totalAmount() {
    double t = 0;
    for (final c in list) {
      t += c.AMOUNT;
    }
    return t;
  }

  double totalOrders() {
    double t = 0;
    for (final c in list) {
      t += c.QNT;
    }
    return t;
  }

  double avgOrders() {
    double t1 = 0;
    for (final c in list) {
      t1 += c.AMOUNT;
    }
    double t2 = 0;
    for (final c in list) {
      t2 += c.QNT;
    }
    if (t2 > 0) {
      return t1 / t2;
    }
    return 0;
  }

  double totalAmountp() {
    double t = 0;
    for (final c in list) {
      t += c.AMOUNTP;
    }
    return t;
  }

  double totalOrdersp() {
    double t = 0;
    for (final c in list) {
      t += c.QNTP;
    }
    return t;
  }

  double avgOrdersp() {
    double t1 = 0;
    for (final c in list) {
      t1 += c.AMOUNTP;
    }
    double t2 = 0;
    for (final c in list) {
      t2 += c.QNTP;
    }
    if (t2 > 0) {
      return t1 / t2;
    }
    return 0;
  }

  double totalAmounto() {
    double t = 0;
    for (final c in list) {
      t += c.AMOUNTO;
    }
    return t;
  }

  double totalOrderso() {
    double t = 0;
    for (final c in list) {
      t += c.QNTO;
    }
    return t;
  }

  double avgOrderso() {
    double t1 = 0;
    for (final c in list) {
      t1 += c.AMOUNTO;
    }
    double t2 = 0;
    for (final c in list) {
      t2 += c.QNTO;
    }
    if (t2 > 0) {
      return t1 / t2;
    }
    return 0;
  }
}

@freezed
class OrderRemovalRecord with _$OrderRemovalRecord {
  const factory OrderRemovalRecord({
    required String ID,
    required int STATE_ID,
    required String DATE_OPEN,
    required String DATE_CLOSE,
    required double AMOUNT,
    required int CANCELREQUEST
}) = _OrderRemovalRecord;
  factory OrderRemovalRecord.fromJson(Map<String, dynamic> json) => _$OrderRemovalRecordFromJson(json);
}

@freezed
class OrderRemovalRecordList with _$OrderRemovalRecordList {
  const factory OrderRemovalRecordList({
    required String CAFE,
    required List<OrderRemovalRecord> DATA
})=_OrderRemovalRecordList;
  factory OrderRemovalRecordList.fromJson(Map<String, dynamic> json) => _$OrderRemovalRecordListFromJson(json);
}