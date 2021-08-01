// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'home.dart';
import 'main.dart';
import 'friends.dart';
import 'learn.dart';
const PrimaryColor = const Color(0xFFF86D67);

void main() {runApp(MyApp());}

class FriendInvitationPage extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          platform: TargetPlatform.iOS,
        ),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new Home(),
        
        '/learn' : (BuildContext context) => new LearnPage(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FriendInvitation(),
      ),
    );
  }
}

class FriendInvitation extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar( 
        backgroundColor: Color(0xffF86D67),
        title:Text('交友邀請',style: TextStyle(fontSize: 20)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FriendsPage()));
                
          },
        ) 
      ),
      body: ListView(
        children: <Widget>[
      
        ],
      ),
    );
  }
}
