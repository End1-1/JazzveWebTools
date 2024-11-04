import 'package:flutter/material.dart';

const middleBoldText = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
const smallBoldText = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
const smallBoldHeader = TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white);

Widget TableHeader(String text, double width) {
  return Container(
    decoration: const BoxDecoration(
      color: Color(0xff544848),
      border: Border.fromBorderSide(BorderSide(color: Colors.black45))
    ),
    height: 40,
    width: width,
    padding: const EdgeInsets.all(2),
    child: Text(text, textAlign: TextAlign.center, style: smallBoldHeader),
  );
}

Widget TableDataCell(String text, double width) {
  return Container(
    decoration: const BoxDecoration(
        color: Color(0xffffffff),
        border: Border.fromBorderSide(BorderSide(color: Colors.black45))
    ),
    height: 40,
    width: width,
    padding: const EdgeInsets.all(2),
    child: Text(text, textAlign: TextAlign.center, style: smallBoldText),
  );
}