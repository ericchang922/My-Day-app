// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:My_Day_app/studyplan/1%20copy.dart';
import 'package:My_Day_app/studyplan/1.dart';
import 'package:flutter/material.dart';

import 'notes.dart';
import 'readplan.dart';


AppBar learnAppBar = AppBar(
  backgroundColor: Color(0xffF86D67),
  title: Text('讀書', style: TextStyle(fontSize: 20)),
);

class LearnPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        platform: TargetPlatform.iOS,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
        body: Learn(),
      ),
    ));
  }
}



class Learn extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  ReadPlan()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '讀書計畫',
                    style: TextStyle(
                      fontSize: 20,
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
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => App()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '筆記',
                    style: TextStyle(
                      fontSize: 20,
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

