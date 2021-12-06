// flutter
import 'package:flutter/material.dart';
// my day
import 'package:My_Day_app/public/type_color.dart';
import 'package:My_Day_app/public/sizing.dart';

Positioned homeSchedule(BuildContext context,
    {double top,
    double left,
    double right,
    double bottom,
    double height,
    int scheduleNum,
    int typeId = 1,
    int count = 0}) {
  Sizing _sizing = Sizing(context);
  double _btnWidth = _sizing.width(12.5) * 0.26;
  double btnRightPadding = _sizing.width(12.5) * 0.05;
  if (count >= 4) {
    _btnWidth -= btnRightPadding;
    btnRightPadding = 0;
  }

  return Positioned(
    top: top,
    left: left,
    right: right,
    bottom: bottom,
    width: _btnWidth,
    height: height,
    child: Padding(
      padding: EdgeInsets.only(right: btnRightPadding),
      child: SizedBox(
        child: TextButton(
          child: Text(''),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(typeColor(typeId))),
          onPressed: () {
            print('home_schedule -- $scheduleNum');
          },
        ),
      ),
    ),
  );
}
