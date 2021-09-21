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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar( 
        backgroundColor: Color(0xffF86D67),
        title:Text('隱私',style: TextStyle(fontSize: 20)),
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
            margin: EdgeInsets.only(right: 5, left: 28),
            // ignore: deprecated_member_use
            child: SizedBox(
              height: 60,
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
                    style: TextStyle(fontSize: 20,
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
          Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  margin: EdgeInsets.only(top: 4.0),
                  color: Color(0xffE3E3E3),
                  constraints: BoxConstraints.expand(height: 1.0),
                )),
          Container(
            margin: EdgeInsets.only(right: 5, left: 28),
            // ignore: deprecated_member_use
            child: SizedBox(
              height: 60,
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
                    style: TextStyle(fontSize: 20,
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
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            )),
        ],
      ),
    ));
  }
}
