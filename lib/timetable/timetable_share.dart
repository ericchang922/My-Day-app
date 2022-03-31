import 'package:My_Day_app/public/timetable_request/get_sharecode.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/timetable/timetable_share_friend.dart';
import 'package:My_Day_app/timetable/timetable_share_group.dart';
import 'package:My_Day_app/public/sizing.dart';

Future<bool> timetableShare(
    BuildContext context, String sharecode, int timetableNo) async {
  Sizing _sizing = Sizing(context);

  double _borderRadius = _sizing.height(3);
  double _inkwellH = _sizing.height(6);

  double _pSize = _sizing.height(2.3);
  double _subtitleSize = _sizing.height(2);

  double _iconSize = _sizing.height(7.5);

  Color _color = Theme.of(context).primaryColor;
  Color _light = Theme.of(context).primaryColorLight;

  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
          contentPadding: EdgeInsets.only(top: _sizing.height(2)),
          content: Container(
            width: _sizing.width(20),
            height: _sizing.height(28),
            child: (ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _sizing.height(1)),
                  child: Text(
                    "分享課表",
                    style: TextStyle(fontSize: _pSize),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: _sizing.height(2)),
                Container(
                  margin: EdgeInsets.only(
                      left: _sizing.width(10), right: _sizing.width(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/friend_choose.png'),
                        iconSize: _iconSize,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TimetableShareFriendPage(timetableNo)));
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/images/group_choose.png'),
                        iconSize: _iconSize,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TimetableShareGroupPage(timetableNo)));
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: _sizing.width(5)),
                  child: Text(
                    '分享碼',
                    style: TextStyle(fontSize: _sizing.height(2)),
                  ),
                ),
                SizedBox(height: _sizing.height(0.5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.all(
                              Radius.circular(_sizing.height(1))),
                        ),
                        margin: EdgeInsets.only(left: _sizing.width(5)),
                        child: Padding(
                          padding: EdgeInsets.all(_sizing.height(1)),
                          child: Text(
                            sharecode,
                            style: TextStyle(fontSize: _sizing.height(2)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/copy.png'),
                      iconSize: _sizing.height(3),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            )),
          ),
        );
      });
}
