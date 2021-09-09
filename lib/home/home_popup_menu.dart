import 'package:My_Day_app/home/homeUpdate.dart';
import 'package:My_Day_app/setting/settings.dart';
import 'package:My_Day_app/timetable/timetable_%20receive.dart';
import 'package:My_Day_app/timetable/timetable_action_list.dart';
import 'package:My_Day_app/timetable/timetable_choose_share.dart';
import 'package:flutter/material.dart';

Widget homePopupMenu(BuildContext context) {
  Size _size = MediaQuery.of(context).size;
  double _height = _size.height;
  double _width = _size.width;
  double _greyFontSize = _height * 0.015;
  double _itemsSize = _height * 0.037;
  Color _homePageGrey = Color(0xffCCCCCC);

  Color _itemsColor(String value) {
    Color _thisColor;
    if (HomeInherited.of(context).selectedScheduleType == value)
      _thisColor = Color(0xffEFB208);
    else
      _thisColor = Colors.black;
    return _thisColor;
  }

  return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_width * 0.05))),
      padding: EdgeInsets.all(_width * 0.005),
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'manage':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TimetableActionListPage()));
            break;
          case 'share':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TimetableChooseSharePage()));
            break;
          case 'accept':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TimetableReceivePage()));
            break;
          default:
            HomeInherited.of(context).updateSelected(value);
        }
      },
      itemBuilder: (context) => [
            PopupMenuItem(
                padding: EdgeInsets.only(left: _width * 0.18),
                child: Container(
                  width: _width * 0.2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      },
                      icon: Icon(
                        Icons.settings,
                        color: _homePageGrey,
                      ),
                    ),
                  ),
                )),
            PopupMenuItem(
              enabled: false,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '行事曆',
                      style: TextStyle(
                          color: _homePageGrey, fontSize: _greyFontSize),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Divider(
                      color: _homePageGrey,
                      thickness: 1,
                    ),
                  )
                ],
              ),
            ),
            PopupMenuItem(
              child: Text('所有', style: TextStyle(color: _itemsColor('all'))),
              value: 'all',
              height: _itemsSize,
            ),
            PopupMenuItem(
              child:
                  Text('個人', style: TextStyle(color: _itemsColor('personal'))),
              value: 'personal',
              height: _itemsSize,
            ),
            PopupMenuItem(
              child: Text('群組', style: TextStyle(color: _itemsColor('group'))),
              value: 'group',
              height: _itemsSize,
            ),
            PopupMenuItem(
              enabled: false,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '課表',
                      style: TextStyle(
                          color: _homePageGrey, fontSize: _greyFontSize),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Divider(
                      color: _homePageGrey,
                      thickness: 1,
                    ),
                  )
                ],
              ),
            ),
            PopupMenuItem(
              child: Text('管理課表'),
              height: _itemsSize,
              value: 'manage',
            ),
            PopupMenuItem(
              child: Text('分享課表'),
              height: _itemsSize,
              value: 'share',
            ),
            PopupMenuItem(
              child: Text('接收課表'),
              height: _itemsSize,
              value: 'accept',
            ),
          ]);
}
