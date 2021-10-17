import 'package:My_Day_app/timetable/timetable_share_friend.dart';
import 'package:My_Day_app/timetable/timetable_share_group.dart';
import 'package:flutter/material.dart';

Future<bool> timetableShare(
    BuildContext context, String sharecode, int timetableNo) async {
  Size size = MediaQuery.of(context).size;
  double _width = size.width;
  double _height = size.height;

  double _borderRadius = _height * 0.03;
  double _inkwellH = _height * 0.06;

  double _pSize = _height * 0.023;
  double _subtitleSize = _height * 0.02;

  double _iconSize = _height * 0.075;

  Color _color = Theme.of(context).primaryColor;
  Color _light = Theme.of(context).primaryColorLight;

  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
          contentPadding: EdgeInsets.only(top: _height * 0.02),
          content: Container(
            width: _width * 0.2,
            height: _height * 0.28,
            child: (ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01),
                  child: Text(
                    "分享課表",
                    style: TextStyle(fontSize: _pSize),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: _height * 0.02),
                Container(
                  margin: EdgeInsets.only(
                      left: _width * 0.15, right: _width * 0.15),
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
                  margin: EdgeInsets.only(left: _width * 0.05),
                  child: Text(
                    '分享碼',
                    style: TextStyle(fontSize: _height * 0.02),
                  ),
                ),
                SizedBox(height: _height * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: _width * 0.5,
                      decoration: new BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius:
                            BorderRadius.all(Radius.circular(_height * 0.01)),
                      ),
                      margin: EdgeInsets.only(left: _width * 0.05),
                      child: Padding(
                        padding: EdgeInsets.all(_height * 0.01),
                        child: Text(
                          sharecode,
                          style: TextStyle(fontSize: _height * 0.02),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/copy.png'),
                      iconSize: _height * 0.03,
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
