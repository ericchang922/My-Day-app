import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/models/profile/profile_list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/profile/edit_profile.dart';
import 'package:My_Day_app/public/profile/profile_list.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/setting/change_password_personal.dart';

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
  String uid = '';
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getProfileListRequest();
  }

  String photo;
  File _photo;
  String photoBase64;
  File imageResized;

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _getProfileListRequest() async {
    print(uid + 'profile ===================================');
    GetProfileListModel _request =
        await GetProfileList(context: context, uid: uid).getData();

    setState(() {
      _getProfileList = _request;
      _name = _getProfileList.userName;
      print(_name);
    });
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
    Sizing _sizing = Sizing(context);
    double _subtitleT = _sizing.height(0.5);
    double _appBarSize = _sizing.width(5.2);
    double _pSize = _sizing.height(2.3);
    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);
    double _borderRadius = _sizing.height(3);
    double _textLBR = _sizing.height(2);
    double _textFied = _sizing.height(4.5);
    double _inkwellH = _sizing.height(6);
    double _bottomHeight = _sizing.height(7);
    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    GetImage _getImage = GetImage(context);

    _submit() async {
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
            contentPadding: EdgeInsets.only(top: _sizing.height(2)),
            content: Container(
              width: _sizing.width(20),
              height: _sizing.height(24),
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
                                top: _sizing.height(1.5)),
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
                                        horizontal: _sizing.height(1),
                                        vertical: _sizing.height(1)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(_sizing.height(1))),
                                      borderSide: BorderSide(
                                        color: _textFiedBorder,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(_sizing.height(1))),
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
                                  top: _sizing.height(1.5),
                                  bottom: _sizing.height(1.5)),
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
                                    top: _sizing.height(1.5),
                                    bottom: _sizing.height(1.5)),
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

    return Scaffold(
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
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(
                    top: _sizing.height(2), right: _sizing.height(20)),
                child: InkWell(
                  onTap: () async {
                    _incrementCounter();
                  },
                  child: ClipOval(
                      child: _getImage.personal(_getProfileList.photo)),
                )),
            Container(
              margin: EdgeInsets.only(top: _sizing.height(1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: _sizing.height(1), left: _sizing.height(5)),
                child: ListTile(
                  title: Text('姓名', style: TextStyle(fontSize: _titleSize)),
                  subtitle: Container(
                      margin: EdgeInsets.only(top: _subtitleT),
                      child: Text(_name,
                          style: TextStyle(fontSize: _subtitleSize))),
                  onTap: () async {
                    await settingsUpdateNameDialog(context);
                  },
                )),
            Container(
              margin: EdgeInsets.only(top: _sizing.height(1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: _sizing.height(1), left: _sizing.height(5)),
                child: ListTile(
                  title: Text('電子郵件', style: TextStyle(fontSize: _titleSize)),
                  subtitle: Container(
                      margin: EdgeInsets.only(top: _subtitleT),
                      child:
                          Text(uid, style: TextStyle(fontSize: _subtitleSize))),
                  onTap: () async {
                    return null;
                  },
                )),
            Container(
              margin: EdgeInsets.only(top: _sizing.height(1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: _sizing.height(1), right: _sizing.height(20)),
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
              margin: EdgeInsets.only(top: _sizing.height(0.5)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ],
        ),
      ),
    );
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
