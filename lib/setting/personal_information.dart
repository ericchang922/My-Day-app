// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:My_Day_app/models/profile/profile_list.dart';
import 'package:My_Day_app/public/profile/edit_profile.dart';
import 'package:My_Day_app/public/profile/profile_list.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'change_password_personal.dart';

import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PersonalInformationPage extends StatefulWidget {
  @override
  _PersonalInformationWidget createState() => new _PersonalInformationWidget();
}

class _PersonalInformationWidget extends State<PersonalInformationPage> {
  get child => null;
  get left => null;

  String _name = '';
  TextEditingController get _NameController =>
      TextEditingController(text: _name);

  GetProfileListModel _getProfileList;
  String id = 'lili123';
  String photo;
  File _photo;
  String photoBase64;
  File imageResized;

  @override
  void initState() {
    super.initState();
    _getProfileListRequest();
  }

  _getProfileListRequest() async {
    // var response = await rootBundle.loadString('assets/json/group_list.json');
    // var responseBody = json.decode(response);

    GetProfileListModel _request = await GetProfileList(uid: id).getData();

    setState(() {
      _getProfileList = _request;
      _name = _getProfileList.userName;
      print(_name);
    });
  }

  getImage(String imageString) {
    bool isGetImage;

    const Base64Codec base64 = Base64Codec();
    Image image = Image.memory(
      base64.decode(imageString),
    );
    var resolve = image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      isGetImage = true;
    }, onError: (Object exception, StackTrace stackTrace) {
      isGetImage = false;
      print('error');
    }));

    if (isGetImage == null) {
      return image;
    } else {
      return Center(
        child: Text('無法讀取'),
      );
    }
  }

  /*图片控件*/
  Widget _ImageView(_photo) {
    if (_photo == null) {
      return Center(
        child: Text(""),
      );
    } else {
      return Image.file(
        _photo,
      );
    }
  }

  Future _getImage(ImageSource source) async {
    var photo = await ImagePicker.pickImage(source: source);

    setState(() {
      _photo = photo;

      List<int> imageBytes = photo.readAsBytesSync();
      photoBase64 = base64Encode(imageBytes);
      print(photoBase64);
    });
  }

  void _incrementCounter() {
    _getImage(ImageSource.gallery);
  }

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
    double _bottomHeight = _height * 0.07;
    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    _submit() async {
      String uid = id;
      var submitWidget;
      _submitWidgetfunc() async {
        return EditProfile(uid: uid, userName: _name, photo: photo);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

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
                                  _name = text;
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
                                  if (await _submit() != true) {
                                    setState(() {
                                      _name = _name;
                                      Navigator.of(context).pop();
                                    });
                                  }
                                } else {
                                  if (await _submit() != true) {
                                    setState(() {
                                      _NameController.text = _name;
                                      Navigator.of(context).pop();
                                    });
                                  }
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

    // Future settingsUpdateEmailDialog(BuildContext context) async {
    //   return showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         backgroundColor: Colors.white,
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
    //         contentPadding: EdgeInsets.only(top: _height * 0.02),
    //         content: Container(
    //           width: _width * 0.2,
    //           height: _height * 0.24,
    //           child: GestureDetector(
    //             // 點擊空白處釋放焦點
    //             behavior: HitTestBehavior.translucent,
    //             onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
    //             child: Column(
    //               children: <Widget>[
    //                 Expanded(
    //                   child: ListView(
    //                     shrinkWrap: true,
    //                     physics: NeverScrollableScrollPhysics(),
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: <Widget>[
    //                           Text(
    //                             "電子郵件",
    //                             style: TextStyle(fontSize: _pSize),
    //                             textAlign: TextAlign.center,
    //                           ),
    //                         ],
    //                       ),
    //                       Container(
    //                         margin: EdgeInsets.only(
    //                             left: _textLBR,
    //                             right: _textLBR,
    //                             bottom: _textLBR,
    //                             top: _height * 0.015),
    //                         child: Text('電子郵件名稱：',
    //                             style: TextStyle(fontSize: _pSize)),
    //                       ),
    //                       Container(
    //                           height: _textFied,
    //                           margin: EdgeInsets.only(
    //                             left: _textLBR,
    //                             right: _textLBR,
    //                           ),
    //                           child: new TextField(
    //                             style: TextStyle(fontSize: _pSize),
    //                             decoration: InputDecoration(
    //                                 contentPadding: EdgeInsets.symmetric(
    //                                     horizontal: _height * 0.01,
    //                                     vertical: _height * 0.01),
    //                                 border: OutlineInputBorder(
    //                                   borderRadius: BorderRadius.all(
    //                                       Radius.circular(_height * 0.01)),
    //                                   borderSide: BorderSide(
    //                                     color: _textFiedBorder,
    //                                   ),
    //                                 ),
    //                                 focusedBorder: OutlineInputBorder(
    //                                   borderRadius: BorderRadius.all(
    //                                       Radius.circular(_height * 0.01)),
    //                                   borderSide: BorderSide(color: _bule),
    //                                 )),
    //                             controller: _EmailController,
    //                             onChanged: (text) {
    //                               email = text;
    //                             },
    //                           )),
    //                     ],
    //                   ),
    //                 ),
    //                 Row(
    //                   children: [
    //                     Expanded(
    //                       child: InkWell(
    //                         child: Container(
    //                           height: _inkwellH,
    //                           padding: EdgeInsets.only(
    //                               top: _height * 0.015,
    //                               bottom: _height * 0.015),
    //                           decoration: BoxDecoration(
    //                             color: _light,
    //                             borderRadius: BorderRadius.only(
    //                               bottomLeft: Radius.circular(_borderRadius),
    //                             ),
    //                           ),
    //                           child: Text(
    //                             "取消",
    //                             style: TextStyle(
    //                                 fontSize: _subtitleSize,
    //                                 color: Colors.white),
    //                             textAlign: TextAlign.center,
    //                           ),
    //                         ),
    //                         onTap: () {
    //                           Navigator.of(context).pop();
    //                         },
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: InkWell(
    //                           child: Container(
    //                             height: _inkwellH,
    //                             padding: EdgeInsets.only(
    //                                 top: _height * 0.015,
    //                                 bottom: _height * 0.015),
    //                             decoration: BoxDecoration(
    //                               color: _color,
    //                               borderRadius: BorderRadius.only(
    //                                   bottomRight:
    //                                       Radius.circular(_borderRadius)),
    //                             ),
    //                             child: Text(
    //                               "確認",
    //                               style: TextStyle(
    //                                   fontSize: _subtitleSize,
    //                                   color: Colors.white),
    //                               textAlign: TextAlign.center,
    //                             ),
    //                           ),
    //                           onTap: () async {
    //                             if (_EmailController.text.isEmpty) {
    //                               setState(() {
    //                                 email = email;
    //                                 Navigator.of(context).pop();
    //                               });
    //                             } else {
    //                               setState(() {
    //                                 _EmailController.text = email;
    //                                 Navigator.of(context).pop();
    //                               });
    //                             }
    //                           }),
    //                     )
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('個人資料', style: TextStyle(fontSize: _appBarSize)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () async {
              if (await _submit() != true) {
                photo = photoBase64;
                Navigator.of(context).pop();
              }
            },
          )),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: _height * 0.02, right: _height * 0.2),
              child: InkWell(
                onTap: () async {
                  _incrementCounter();
                },
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      child: (_photo != null)
                          ? Image.file(
                              _photo,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            )
                          : Image.asset('assets/images/search.png')
                      // :  getImage(_getProfileList.photo),
                      ),
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
              margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.05),
              child: ListTile(
                title: Text('姓名', style: TextStyle(fontSize: _titleSize)),
                subtitle: Container(
                    margin: EdgeInsets.only(top: _subtitleT),
                    child:
                        Text(_name, style: TextStyle(fontSize: _subtitleSize))),
                onTap: () async {
                  await settingsUpdateNameDialog(context);
                },
              )),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
              margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.05),
              child: ListTile(
                title: Text('電子郵件', style: TextStyle(fontSize: _titleSize)),
                subtitle: Container(
                    margin: EdgeInsets.only(top: _subtitleT),
                    child: Text(id, style: TextStyle(fontSize: _subtitleSize))),
                onTap: () async {
                  return null;
                },
              )),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01, right: _height * 0.2),
            child: SizedBox(
                height: _bottomHeight,
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
                      fontSize: _appBarSize,
                    ),
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: _height * 0.005),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
        ],
      ),
    ));
  }
}

class MyClipper extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromCircle(center: Offset(200, 200), radius: 200);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
