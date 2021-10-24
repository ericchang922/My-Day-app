// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'change_password_personal.dart';

const PrimaryColor = const Color(0xFFF86D67);

class PersonalInformationPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  PersonalInformation createState() => new PersonalInformation();
}

class PersonalInformation extends State<PersonalInformationPage> {
  get child => null;
  get left => null;

  String name = '林依依';
  String email = '1083@gmail.com';
  // ignore: non_constant_identifier_names
  TextEditingController get _NameController =>TextEditingController(text: name);
  // ignore: non_constant_identifier_names
  TextEditingController get _EmailController =>TextEditingController(text: email);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _leadingL = _height * 0.02;
    double _listPaddingH = _width * 0.08;
    double _subtitleT = _height * 0.005;

    double _appBarSize = _width * 0.052;
    double _pSize = _height * 0.023;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _iconWidth = _width * 0.05;
    double _borderRadius = _height * 0.03;
    double _textLBR = _height * 0.02;
    double _textFied = _height * 0.045;
    double _inkwellH = _height * 0.06;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    Future settingsUpdateNameDialog(BuildContext context) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
            contentPadding: EdgeInsets.only(top: _height * 0.02),
            content: Container(
              width: _width * 0.2,
              height: _height * 0.24,
              child: GestureDetector(
                // 點擊空白處釋放焦點
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "更改姓名",
                                style: TextStyle(fontSize: _pSize),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: _textLBR,
                                right: _textLBR,
                                bottom: _textLBR,
                                top: _height * 0.015),
                            child: Text('姓名名稱：',
                                style: TextStyle(fontSize: _pSize)),
                          ),
                          Container(
                              height: _textFied,
                              margin: EdgeInsets.only(
                                left: _textLBR,
                                right: _textLBR,
                              ),
                              child: new TextField(
                                style: TextStyle(fontSize: _pSize),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: _height * 0.01,
                                        vertical: _height * 0.01),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(_height * 0.01)),
                                      borderSide: BorderSide(
                                        color: _textFiedBorder,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(_height * 0.01)),
                                      borderSide: BorderSide(color: _bule),
                                    )),
                                controller: _NameController,
                                onChanged: (text) {
                                  name = text;
                                },
                              )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Container(
                              height: _inkwellH,
                              padding: EdgeInsets.only(
                                  top: _height * 0.015,
                                  bottom: _height * 0.015),
                              decoration: BoxDecoration(
                                color: _light,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(_borderRadius),
                                ),
                              ),
                              child: Text(
                                "取消",
                                style: TextStyle(
                                    fontSize: _subtitleSize,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                              child: Container(
                                height: _inkwellH,
                                padding: EdgeInsets.only(
                                    top: _height * 0.015,
                                    bottom: _height * 0.015),
                                decoration: BoxDecoration(
                                  color: _color,
                                  borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(_borderRadius)),
                                ),
                                child: Text(
                                  "確認",
                                  style: TextStyle(
                                      fontSize: _subtitleSize,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onTap: () async {
                                if (_NameController.text.isEmpty) {
                                  setState(() {
                                    name = name;
                                    Navigator.of(context).pop();
                                  });
                                } else {
                                  setState(() {
                                    _NameController.text = name;
                                    Navigator.of(context).pop();
                                  });
                                }
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    Future settingsUpdateEmailDialog(BuildContext context) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
            contentPadding: EdgeInsets.only(top: _height * 0.02),
            content: Container(
              width: _width * 0.2,
              height: _height * 0.24,
              child: GestureDetector(
                // 點擊空白處釋放焦點
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "電子郵件",
                                style: TextStyle(fontSize: _pSize),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: _textLBR,
                                right: _textLBR,
                                bottom: _textLBR,
                                top: _height * 0.015),
                            child: Text('電子郵件名稱：',
                                style: TextStyle(fontSize: _pSize)),
                          ),
                          Container(
                              height: _textFied,
                              margin: EdgeInsets.only(
                                left: _textLBR,
                                right: _textLBR,
                              ),
                              child: new TextField(
                                style: TextStyle(fontSize: _pSize),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: _height * 0.01,
                                        vertical: _height * 0.01),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(_height * 0.01)),
                                      borderSide: BorderSide(
                                        color: _textFiedBorder,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(_height * 0.01)),
                                      borderSide: BorderSide(color: _bule),
                                    )),
                                controller: _EmailController,
                                onChanged: (text) {
                                  email = text;
                                },
                              )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Container(
                              height: _inkwellH,
                              padding: EdgeInsets.only(
                                  top: _height * 0.015,
                                  bottom: _height * 0.015),
                              decoration: BoxDecoration(
                                color: _light,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(_borderRadius),
                                ),
                              ),
                              child: Text(
                                "取消",
                                style: TextStyle(
                                    fontSize: _subtitleSize,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                              child: Container(
                                height: _inkwellH,
                                padding: EdgeInsets.only(
                                    top: _height * 0.015,
                                    bottom: _height * 0.015),
                                decoration: BoxDecoration(
                                  color: _color,
                                  borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(_borderRadius)),
                                ),
                                child: Text(
                                  "確認",
                                  style: TextStyle(
                                      fontSize: _subtitleSize,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onTap: () async {
                                if (_EmailController.text.isEmpty) {
                                  setState(() {
                                    email = email;
                                    Navigator.of(context).pop();
                                  });
                                } else {
                                  setState(() {
                                    _EmailController.text = email;
                                    Navigator.of(context).pop();
                                  });
                                }
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('個人資料', style: TextStyle(fontSize: 20)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, right: 170),
            child: SizedBox(
                height: 100,
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape:
                          CircleBorder(side: BorderSide(color: Colors.black)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {})),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
              margin: EdgeInsets.only(top: 20, left: 30),
              child: ListTile(
                title: Text('姓名', style: TextStyle(fontSize: _titleSize)),
                subtitle: Container(
                    margin: EdgeInsets.only(top: _subtitleT),
                    child:
                        Text(name, style: TextStyle(fontSize: _subtitleSize))),
                onTap: () async {
                  await settingsUpdateNameDialog(context);
                },
              )),
          Container(
            margin: EdgeInsets.only(top: 20),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
              margin: EdgeInsets.only(top: 20, left: 30),
              child: ListTile(
                title: Text('電子郵件', style: TextStyle(fontSize: _titleSize)),
                subtitle: Container(
                    margin: EdgeInsets.only(top: _subtitleT),
                    child:
                        Text(email, style: TextStyle(fontSize: _subtitleSize))),
                onTap: () async {
                  await settingsUpdateEmailDialog(context);
                },
              )),
          
          Container(
            margin: EdgeInsets.only(top: 20),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, right: 180),
            child: SizedBox(
                height: 40,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangepwPersonalPage()));
                  },
                  child: Text(
                    '更改密碼',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
        ],
      ),
    ));
  }
}
