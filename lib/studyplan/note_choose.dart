// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';



const PrimaryColor = const Color(0xFFF86D67);



class ReadPlanChoose extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SwitchDemo(),
    
    );
  }
}

class SwitchDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Theme();
}

class Theme extends State {
  get child => null;
  get left => null;
  bool _hasBeenPressed = false;
  bool hasBeenPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('選擇筆記', style: TextStyle(fontSize: 20)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 30, right: 10.0, top: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                     Text(
                        '國文 1~3 課',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    
                    // ignore: deprecated_member_use
                    FlatButton(
                        height: 20,
                        minWidth: 10,
                        color:
                          _hasBeenPressed ?Color(0xffF86D67):Colors.white,
                        shape: _hasBeenPressed? 
                          CircleBorder():CircleBorder(side: BorderSide(color: Colors.black),),
                        onPressed: () {
                          setState(() {
                            _hasBeenPressed = !_hasBeenPressed;
                          });
                        }),
                  ])),
          Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
         
          Container(
              margin: EdgeInsets.only(left: 30, right: 10.0, top: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    Text(
                        '數學 1~3 課',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                  
                    // ignore: deprecated_member_use
                    FlatButton(
                        height: 20,
                        minWidth: 10,
                        color:
                            hasBeenPressed ? Color(0xffF86D67) : Colors.white,
                        shape: hasBeenPressed
                            ? CircleBorder()
                            : CircleBorder(
                                side: BorderSide(color: Colors.black),
                              ),
                        onPressed: () {
                          setState(() {
                            hasBeenPressed = !hasBeenPressed;
                          });
                        }),
                  ])),
           Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
        ],
        
      ),
      bottomNavigationBar: Container(
        child: Row(children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Text(
                '取消',
                style: TextStyle(fontSize: 18),
              ),
              color: Color(0xffFFAAA6),
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Text(
                '確認',
                style: TextStyle(fontSize: 18),
              ),
              color: Color(0xffF86D67),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
    ])));
  }
}
