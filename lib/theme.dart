// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'main.dart';
import 'settings.dart';
import 'learn.dart';

const PrimaryColor = const Color(0xFFF86D67);



class ThemePage extends StatelessWidget {
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
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: _hasBeenPressed?Color(0xff29527A):Color(0xffF86D67),
          title: Text('主題', style: TextStyle(fontSize: 20)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    FlatButton.icon(
                      icon: Icon(Icons.circle_sharp,
                          color: Color(0xffF86D67), size: 40),
                      label: Text(
                        '  活力紅',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                        height: 20,
                        minWidth: 10,
                        color:
                            _hasBeenPressed ? Colors.white : Color(0xffF86D67),
                        shape: _hasBeenPressed
                            ? CircleBorder(
                                side: BorderSide(color: Colors.black),
                              )
                            : CircleBorder(),
                        onPressed: () {
                          setState(() {
                            _hasBeenPressed = !_hasBeenPressed;
                          });
                        }),
                  ])),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    FlatButton.icon(
                      icon: Icon(Icons.circle_sharp,
                          color: Color(0xff29527A), size: 40),
                      label: Text(
                        '  深夜藍',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                        height: 20,
                        minWidth: 10,
                        color:
                            _hasBeenPressed ? Color(0xffF86D67) : Colors.white,
                        shape: _hasBeenPressed
                            ? CircleBorder()
                            : CircleBorder(
                                side: BorderSide(color: Colors.black),
                              ),
                        onPressed: () {
                          setState(() {
                            _hasBeenPressed = !_hasBeenPressed;
                          });
                        }),
                  ])),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
