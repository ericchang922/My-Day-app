import 'package:flutter/material.dart';

import 'package:My_Day_app/public/sizing.dart';

class CheckBoxStudyplan extends StatefulWidget {
  CheckBoxStudyplan({Key key, @required this.value, @required this.onTap})
      : super(key: key);

  final bool value;
  final onTap;
  @override
  State<StatefulWidget> createState() {
    return _CheckBoxStudyplan();
  }
}

class _CheckBoxStudyplan extends State<CheckBoxStudyplan> {
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    Color _yellow = Color(0xffEFB208);

    return InkWell(
      child: Container(
        width: _sizing.width(8),
        height: _sizing.width(8),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: widget.value ? _yellow : Color(0xff999999)),
            color: widget.value ? _yellow : Colors.white,
            borderRadius: BorderRadius.circular(_sizing.height(1))),
        child: widget.value
            ? Icon(
                Icons.check,
                size: _sizing.width(6),
                color: Colors.white,
              )
            : null,
      ),
      onTap: () {
        widget.onTap(!widget.value);
      },
    );
  }
}
