// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'main.dart';
import 'home.dart';
import 'settings.dart';
import 'learn.dart';
import 'change_password_personal.dart';

const PrimaryColor = const Color(0xFFF86D67);

class PersonalInformationPage extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersonalInformation(),
      
    );
  }
}

class PersonalInformation extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Color(0xffF86D67),
        title:Text('個人資料',style: TextStyle(fontSize: 20)),
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
            margin: EdgeInsets.only(top: 20,right:170),
            child:FlatButton(
              height: 100,
              color: Colors.white ,
              shape: CircleBorder(side: BorderSide(color: Colors.black)),
              onPressed: () {}
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 20,left:60),
            child:Text('姓名',
              style: TextStyle(fontSize: 20)
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10,left:60),
            child:Text('林依依',
              style: TextStyle(fontSize: 20, color: Color(0xffB4B4B4))
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 20,left:60),
            child:Text('電子郵件',
              style: TextStyle(fontSize: 20)
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10,left:60),
            child:Text('1083@gmail.com',
              style: TextStyle(fontSize: 20, color: Color(0xffB4B4B4))
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 10,right: 190),
            child:FlatButton(
              height: 40,
              minWidth: double.infinity,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChangepwPersonalPage()));
              },
              child: Text('更改密碼',
                style: TextStyle(fontSize: 20,),
              ),
            ),
          ),
           Container(
              margin: EdgeInsets.only(top: 10),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
          ),
        ],
      ),
    );
  }
}
