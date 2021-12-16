import 'package:flutter/material.dart';

import 'package:My_Day_app/friend/friends_privacy_settings.dart';
import 'package:My_Day_app/setting/open_class_schedule.dart';
import 'package:My_Day_app/public/sizing.dart';

const PrimaryColor = const Color(0xFFF86D67);

class PrivacyPage extends StatelessWidget {
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
    Sizing _sizing = Sizing(context);
    double _appBarSize = _sizing.width(5.2);
    double _bottomHeight = _sizing.height(7);

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
              margin: EdgeInsets.only(
                  top: _sizing.height(1), left: _sizing.height(1.8)),
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
              margin: EdgeInsets.only(top: _sizing.height(0.1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: _sizing.height(1), left: _sizing.height(1.8)),
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
              margin: EdgeInsets.only(top: _sizing.height(0.1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}
