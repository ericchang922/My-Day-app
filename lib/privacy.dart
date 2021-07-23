// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'main.dart';
import 'notes.dart';
import 'readplan.dart';
import 'learn.dart';
import 'settings.dart';
const PrimaryColor = const Color(0xFFF86D67);

void main() {runApp(MyApp());}

class PrivacyPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new HomePageWidget(),
  
        '/learn' : (BuildContext context) => new LearnPage(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Privacy(),
      ),
    );
  }
}

class Privacy extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Color(0xffF86D67),
        title:Text('隱私',style: TextStyle(fontSize: 20)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        ) 
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
                MaterialPageRoute(builder: (context) => ReadPlanPage()));
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
                MaterialPageRoute(builder: (context) => NotesPage()));
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
