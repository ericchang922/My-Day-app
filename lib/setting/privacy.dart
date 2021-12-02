import 'package:flutter/material.dart';

import 'package:My_Day_app/friend/friends_privacy_settings.dart';
import 'package:My_Day_app/setting/open_class_schedule.dart';

const PrimaryColor = const Color(0xFFF86D67);

class PrivacyPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Privacy();
  }
}

class Privacy extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;
    double _appBarSize = _width * 0.052;
    double _bottomHeight = _height * 0.07;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('隱私', style: TextStyle(fontSize: _appBarSize)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
              child: SizedBox(
                  height: _bottomHeight,
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OpenClassSchedulePage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '公開課表',
                          style: TextStyle(
                            fontSize: _appBarSize,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xffE3E3E3),
                        )
                      ],
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: _height * 0.001),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
              margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
              child: SizedBox(
                  height: _bottomHeight,
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FriendsPrivacySettingsPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '好友隱私設定',
                          style: TextStyle(
                            fontSize: _appBarSize,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xffE3E3E3),
                        )
                      ],
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: _height * 0.001),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}
