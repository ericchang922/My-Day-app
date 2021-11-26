import 'package:My_Day_app/account/login.dart';
import 'package:My_Day_app/friend/friends.dart';
import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/setting/get_location.dart';
import 'package:My_Day_app/public/setting_request/get_location.dart';
import 'package:My_Day_app/public/setting_request/privacy_location.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'personal_information.dart';

import 'notice.dart';
import 'privacy.dart';
import 'theme.dart';

const PrimaryColor = const Color(0xFFF86D67);

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Settings();
  }
}

class Settings extends State {
  GetLocationModel _location;
  get child => null;
  get left => null;
  bool _isCheck;
  bool location;
  String id = "lili123";
  @override
  void initState() {
    super.initState();
    _getLocationRequest();
    if (location == null) {
       _isCheck = false;

      // ignore: unrelated_type_equality_checks
    } else if (location == 1) {
      _isCheck = true;
    } else {
      _isCheck = false;
    }
      
    
  }

  _getLocationRequest() async {
    // var response = await rootBundle.loadString('assets/json/group_list.json');
    // var responseBody = json.decode(response);

    GetLocationModel _request = await GetLocation(uid: id).getData();

    setState(() {
      _location = _request;
      location = _location.location;
      print(_location.location);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;
    double _appBarSize = _width * 0.052;
    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;
    double _listPaddingH = _width * 0.06;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _pSize = _height * 0.023;
    Color _color = Theme.of(context).primaryColor;
    _submit() async {
      String uid = id;
      bool isLocation = _isCheck;

      var submitWidget;
      _submitWidgetfunc() async {
        return PrivacyLocation(uid: uid, isLocation: isLocation);
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
        backgroundColor: Color(0xffF86D67),
        title: Text('設定', style: TextStyle(fontSize: _appBarSize)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
            // ignore: deprecated_member_use
            child: SizedBox(
                height: _bottomHeight,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '定位',
                        style: TextStyle(
                          fontSize: _appBarSize,
                        ),
                      ),
                      Switch(
                        value: _isCheck,
                        onChanged: (value) async {
                          if (await _submit() != true) {
                            setState(() {
                              _isCheck = value;
                              print(_isCheck);
                            });
                          }
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Color(0xffF86D67),
                        // inactiveThumbColor: Color(0xffF86D67),
                        // inactiveTrackColor: Color(0xffF86D67),
                      ),
                    ],
                  ),
                )),
          ),
           Container(
        margin: EdgeInsets.only(top: _height * 0.001),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
            // ignore: deprecated_member_use
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
                            builder: (context) => PersonalInformationPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '個人資料',
                        style: TextStyle(
                          fontSize: _appBarSize,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xffE3E3E3),
                      )
                    ],
                  ),
                )),
          ),
           Container(
        margin: EdgeInsets.only(top: _height * 0.001),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
            // ignore: deprecated_member_use
            child: SizedBox(
                height: _bottomHeight,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FriendPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '好友',
                        style: TextStyle(
                          fontSize: _appBarSize,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xffE3E3E3),
                      )
                    ],
                  ),
                )),
          ),
           Container(
        margin: EdgeInsets.only(top: _height * 0.001),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
          Container(
           margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
            // ignore: deprecated_member_use
            child: SizedBox(
                height: _bottomHeight,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NoticePage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '通知',
                        style: TextStyle(
                          fontSize: _appBarSize,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xffE3E3E3),
                      )
                    ],
                  ),
                )),
          ),
           Container(
        margin: EdgeInsets.only(top: _height * 0.001),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
            // ignore: deprecated_member_use
            child: SizedBox(
                height: _bottomHeight,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ThemePage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '主題',
                        style: TextStyle(
                          fontSize: _appBarSize,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xffE3E3E3),
                      )
                    ],
                  ),
                )),
          ),
           Container(
        margin: EdgeInsets.only(top: _height * 0.001),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
            // ignore: deprecated_member_use
            child: SizedBox(
                height: _bottomHeight,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '小幫手',
                        style: TextStyle(
                          fontSize: _appBarSize,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xffE3E3E3),
                      )
                    ],
                  ),
                )),
          ),
           Container(
        margin: EdgeInsets.only(top: _height * 0.001),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
            // ignore: deprecated_member_use
            child: SizedBox(
                height: _bottomHeight,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PrivacyPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '隱私',
                        style: TextStyle(
                          fontSize: _appBarSize,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xffE3E3E3),
                      )
                    ],
                  ),
                )),
          ),
           Container(
        margin: EdgeInsets.only(top: _height * 0.001),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
          Container(
            margin: EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
            // ignore: deprecated_member_use
            child: SizedBox(
                height: _bottomHeight,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () async{
                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.remove('TestString_Key');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '登出',
                        style: TextStyle(
                          fontSize: _appBarSize,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
           Container(
        margin: EdgeInsets.only(top: _height * 0.001),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
        ],
      ),
    ));
  }

  void _changed(isCheck) {
    setState(() {
      _isCheck = isCheck;
    });
  }
}
