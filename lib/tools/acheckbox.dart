import 'package:flutter/material.dart';

class ACheckBox extends StatefulWidget {
  bool initialValue;
  final String title;
  final Function(bool?) func;

  ACheckBox(this.initialValue, this.title, this.func, {super.key});

  @override
  State<StatefulWidget> createState() => _ACheckBox();
}

class _ACheckBox extends State<ACheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
          value: widget.initialValue,
          onChanged: (v) {
            widget.initialValue = v ?? false;
            widget.func(v);
            setState(() {});
          }),
      const SizedBox(width: 10),
      Text(widget.title)
    ]);
  }
}
