// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'main.dart';
import 'notes.dart';
import 'readplan.dart';
import 'home.dart';
const PrimaryColor = const Color(0xFFF86D67);

class LearnPage extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          platform: TargetPlatform.iOS,
        ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Learn(),
      ),
    );
  }
}

class Learn extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar( 
        backgroundColor: Color(0xffF86D67),
        title:Text('讀書',style: TextStyle(fontSize: 20)),
        
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReadPlan()));
                
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '讀書計畫',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xffE3E3E3),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            )),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => App()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '筆記',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xffE3E3E3),
                  )
                ],
              ),
            ),
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
    );
  }
}

