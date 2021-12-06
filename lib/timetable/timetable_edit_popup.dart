import 'package:flutter/material.dart';

import 'package:My_Day_app/timetable/timetable_choose_past.dart';
import 'package:My_Day_app/timetable/timetable_information.dart';
import 'package:My_Day_app/public/sizing.dart';

Widget editPopMenu(BuildContext context) {
  Sizing _sizing = Sizing(context);
  double _itemsSize = _sizing.height(3.7);

  return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_sizing.width(5)))),
      padding: EdgeInsets.all(_sizing.width(0.5)),
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'clear':
            null;
            break;
          case 'import':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TimetableChoosePastPage()));
            break;
          case 'information':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TimetableInformationPage()));
            break;
          case 'delete':
            null;
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
            PopupMenuItem(
              child: Text('課表資訊'),
              height: _itemsSize,
              value: 'information',
            ),
            PopupMenuItem(
              child: Text('刪除課表'),
              height: _itemsSize,
              value: 'delete',
            ),
          ]);
}
