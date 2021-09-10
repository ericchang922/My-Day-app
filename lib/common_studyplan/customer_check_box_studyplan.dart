import 'package:flutter/material.dart';

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
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    Color _yellow = Color(0xffEFB208);

    return InkWell(
      child: Container(
        width: _width * 0.08,
        height: _width * 0.08,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: widget.value ? _yellow : Color(0xff999999)),
            color: widget.value ? _yellow : Colors.white,
            borderRadius: BorderRadius.circular(_height * 0.01)),
        child: widget.value
            ? Icon(
                Icons.check,
                size: _width * 0.06,
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
