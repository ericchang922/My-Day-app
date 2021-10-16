// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:My_Day_app/public/setting_request/theme.dart';

const PrimaryColor = const Color(0xFFF86D67);

class ThemePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ThemeWidget(),
    ));
  }
}

class ThemeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThemeWidget();
}

class _ThemeWidget extends State<ThemeWidget> {
  get child => null;
  get left => null;
  bool _hasBeenPressed = true;
  String id = 'lili123';
  int themesId = 1;
  @override
  Widget build(BuildContext context) {
    _submit() async {
      String uid = id;
      int themeId = themesId;

      var submitWidget;
      _submitWidgetfunc() async {
        return Themes(uid: uid, themeId: themeId);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor:
              _hasBeenPressed ? Color(0xff29527A) : Color(0xffF86D67),
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
              margin: EdgeInsets.only(left: 10.0, right: 20, top: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    TextButton.icon(
                      icon: Icon(Icons.circle_sharp,
                          color: Color(0xffF86D67), size: 40),
                      label: Text(
                        '  活力紅',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    SizedBox(
                      height: 40,
                      width: 20,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: _hasBeenPressed
                                ? Colors.white
                                : Color(0xffF86D67),
                            shape: _hasBeenPressed
                                ? CircleBorder(
                                    side: BorderSide(color: Colors.black),
                                  )
                                : CircleBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_hasBeenPressed = false) {
                                if ( _submit() != true) {
                                  _hasBeenPressed = true;
                                  
                                } else {
                                  _hasBeenPressed = false;
                                }
                              }
                            });
                          }),
                    )
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
              margin: EdgeInsets.only(left: 10.0, right: 20, top: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    TextButton.icon(
                      icon: Icon(Icons.circle_sharp,
                          color: Color(0xff29527A), size: 40),
                      label: Text(
                        '  深夜藍',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    SizedBox(
                      height: 40,
                      width: 20,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: _hasBeenPressed
                                ? Color(0xffF86D67)
                                : Colors.white,
                            shape: _hasBeenPressed
                                ? CircleBorder()
                                : CircleBorder(
                                    side: BorderSide(color: Colors.black),
                                  ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_hasBeenPressed = true) {
                                if ( _submit() != true) {
                                  _hasBeenPressed = true;
                                  
                                } else {
                                  _hasBeenPressed = false;
                                  
                                }
                              }
                            });
                          }),
                    )
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
    ));
  }
}
