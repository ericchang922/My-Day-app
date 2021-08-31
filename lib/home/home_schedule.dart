import 'package:My_Day_app/public/type_color.dart';
import 'package:flutter/material.dart';

Positioned homeSchedule(BuildContext context,
    {double top,
    double left,
    double right,
    double bottom,
    double height,
    int typeId}) {
  Size _size = MediaQuery.of(context).size;
  double _width = _size.width;
  double _btnWidth = _width * 0.035;

  return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      width: _btnWidth,
      child: TextButton(
        child: Text(''),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(typeColor(1))),
        onPressed: () {},
      ));
}
