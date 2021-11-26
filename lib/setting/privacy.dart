// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:My_Day_app/friend/friends_privacy_settings.dart';
import 'package:My_Day_app/setting/open_class_schedule.dart';
import 'package:flutter/material.dart';


const PrimaryColor = const Color(0xFFF86D67);


class PrivacyPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        body: Privacy(),
      
    ));
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
    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;
    double _listPaddingH = _width * 0.06;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _pSize = _height * 0.023;
    Color _color = Theme.of(context).primaryColor;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar( 
        backgroundColor: Color(0xffF86D67),
        title:Text('隱私',style: TextStyle(fontSize: _appBarSize)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ) 
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
            // ignore: deprecated_member_use
            child: SizedBox(
              height: _bottomHeight,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => OpenClassSchedulePage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '公開課表',
                    style: TextStyle(fontSize: _appBarSize,
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
            // ignore: deprecated_member_use
            child: SizedBox(
              height: _bottomHeight,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => FriendsPrivacySettingsPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '好友隱私設定',
                    style: TextStyle(fontSize: _appBarSize,
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
    ));
  }
}
