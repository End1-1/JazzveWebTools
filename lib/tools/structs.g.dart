// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'structs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CafeRecordImpl _$$CafeRecordImplFromJson(Map<String, dynamic> json) =>
    _$CafeRecordImpl(
      ID: (json['ID'] as num).toInt(),
      ALIAS: json['ALIAS'] as String,
      WEB: json['WEB'] as String,
      QNT: (json['QNT'] as num).toInt(),
      AVGORDER: (json['AVGORDER'] as num).toInt(),
      AMOUNT: (json['AMOUNT'] as num).toInt(),
      QNTP: (json['QNTP'] as num).toInt(),
      AVGORDERP: (json['AVGORDERP'] as num).toInt(),
      AMOUNTP: (json['AMOUNTP'] as num).toInt(),
      QNTO: (json['QNTO'] as num).toInt(),
      AVGORDERO: (json['AVGORDERO'] as num).toInt(),
      AMOUNTO: (json['AMOUNTO'] as num).toInt(),
    );

Map<String, dynamic> _$$CafeRecordImplToJson(_$CafeRecordImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'ALIAS': instance.ALIAS,
      'WEB': instance.WEB,
      'QNT': instance.QNT,
      'AVGORDER': instance.AVGORDER,
      'AMOUNT': instance.AMOUNT,
      'QNTP': instance.QNTP,
      'AVGORDERP': instance.AVGORDERP,
      'AMOUNTP': instance.AMOUNTP,
      'QNTO': instance.QNTO,
      'AVGORDERO': instance.AVGORDERO,
      'AMOUNTO': instance.AMOUNTO,
    };

_$CafeRecordListImpl _$$CafeRecordListImplFromJson(Map<String, dynamic> json) =>
    _$CafeRecordListImpl(
      list: (json['list'] as List<dynamic>)
          .map((e) => CafeRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CafeRecordListImplToJson(
        _$CafeRecordListImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

_$OrderRemovalRecordImpl _$$OrderRemovalRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderRemovalRecordImpl(
      ID: json['ID'] as String,
      STATE_ID: (json['STATE_ID'] as num).toInt(),
      DATE_OPEN: json['DATE_OPEN'] as String,
      DATE_CLOSE: json['DATE_CLOSE'] as String,
      AMOUNT: (json['AMOUNT'] as num).toDouble(),
      CANCELREQUEST: (json['CANCELREQUEST'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderRemovalRecordImplToJson(
        _$OrderRemovalRecordImpl instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'STATE_ID': instance.STATE_ID,
      'DATE_OPEN': instance.DATE_OPEN,
      'DATE_CLOSE': instance.DATE_CLOSE,
      'AMOUNT': instance.AMOUNT,
      'CANCELREQUEST': instance.CANCELREQUEST,
    };

_$OrderRemovalRecordListImpl _$$OrderRemovalRecordListImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderRemovalRecordListImpl(
      CAFE: json['CAFE'] as String,
      DATA: (json['DATA'] as List<dynamic>)
          .map((e) => OrderRemovalRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OrderRemovalRecordListImplToJson(
        _$OrderRemovalRecordListImpl instance) =>
    <String, dynamic>{
      'CAFE': instance.CAFE,
      'DATA': instance.DATA,
    };
