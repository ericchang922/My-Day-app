import 'package:My_Day_app/timetable/timetable_choose_past.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget createPopMenu(BuildContext context) {
  Size _size = MediaQuery.of(context).size;
  double _height = _size.height;
  double _itemsSize = _height * 0.037;
  double _width = _size.width;

  return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_width * 0.05))),
      padding: EdgeInsets.all(_width * 0.005),
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'clear':
            null;
            break;
          case 'import':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TimetableChoosePastPage()));
            break;
          default:
            break;
        }
      },
      itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('清空課程'),
              height: _itemsSize,
              value: 'clear',
            ),
            PopupMenuItem(
              child: Text('匯入歷年課表'),
              height: _itemsSize,
              value: 'import',
            ),
          ]);
}
