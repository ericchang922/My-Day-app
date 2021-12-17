import 'package:My_Day_app/home/home_Update.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/home.dart';
import 'package:My_Day_app/account/forget_password.dart';
import 'package:My_Day_app/account/login_fail.dart';
import 'package:My_Day_app/account/register.dart';
import 'package:My_Day_app/public/account_request/login.dart';
import 'package:My_Day_app/public/sizing.dart';

class LoginPage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new Home(),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  _Login createState() => new _Login();
}

class _Login extends State {
  get direction => null;
  get border => null;
  get decoration => null;
  get child => null;
  get btnCenterClickEvent => null;
  get appBar => null;

  String _alertTitle = '登入失敗';
  String _alertTxt = '請確認帳號和密碼是否正確';

  final myuid = TextEditingController();
  final mypw = TextEditingController();

  BuildContext get context => null;

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listLR = _sizing.height(5);
    double _listB = _sizing.height(18);
    double _borderRadius = _sizing.height(1);
    double _bottomHeight = _sizing.height(6);
    double _titleSize = _sizing.height(2.5);
    double _appBarSize = _sizing.width(5.2);

    Color _bule = Color(0xff7AAAD8);
    Color _color = Color(0xffF86D67);

    _submit() async {
      String uid = myuid.text;
      String password = mypw.text;

      var submitWidget;
      _submitWidgetfunc() async {
        return Login(context: context, uid: uid, password: password);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          color: _color,
          child: SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    title: Text("登入",
                        style: TextStyle(
                            color: Colors.white, fontSize: _appBarSize)),
                    backgroundColor: _color,
                  ),
                  body: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              left: _listLR,
                              top: _sizing.height(10),
                              right: _listLR,
                            ),
                            child: ListTile(
                              title: Text('帳號：',
                                  style: TextStyle(fontSize: _titleSize)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: _sizing.height(7),
                              top: _sizing.height(0.01),
                              right: _sizing.height(7),
                            ),
                            child: TextField(
                              controller: myuid,
                              obscureText: false,
                              decoration: InputDecoration(
                                filled: true,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: _sizing.height(1.5),
                                    vertical: _sizing.height(1.5)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(_borderRadius)),
                                  borderSide: BorderSide(color: _bule),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: _listLR,
                              top: _sizing.height(2),
                              right: _listLR,
                            ),
                            child: ListTile(
                              title: Text('密碼：',
                                  style: TextStyle(fontSize: _titleSize)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: _sizing.height(7),
                              top: _sizing.height(0.01),
                              right: _sizing.height(7),
                            ),
                            child: TextField(
                              controller: mypw,
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: Color(0xfff3f3f4),
                                filled: true,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: _sizing.height(1.5),
                                    vertical: _sizing.height(1.5)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(_borderRadius)),
                                  borderSide: BorderSide(color: _bule),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: _sizing.height(7),
                              top: _sizing.height(5),
                              right: _sizing.height(7),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: _sizing.height(7),
                              top: _sizing.height(5),
                              right: _sizing.height(7),
                            ),
                            child: SizedBox(
                                height: _bottomHeight,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                _borderRadius)),
                                        backgroundColor: _color),
                                    child: Text(
                                      '登入',
                                      style: TextStyle(fontSize: _titleSize),
                                    ),
                                    onPressed: () async {
                                      if (myuid.text.isNotEmpty &&
                                          mypw.text.isNotEmpty &&
                                          await _submit() != true) {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString('uid', myuid.text);

                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeUpdate(
                                                            child: Home())),
                                                (route) => false);
                                      }
                                    })),
                          ),
                        ],
                      )),
                  bottomNavigationBar: Container(
                      color: Colors.white,
                      child: SafeArea(
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: _listLR,
                                bottom: _listB,
                              ),
                              child: SizedBox(
                                  height: _bottomHeight,
                                  child: TextButton(
                                    child: Text('忘記密碼',
                                        style: TextStyle(
                                            fontSize: _sizing.height(2))),
                                    style: TextButton.styleFrom(
                                      primary: _color,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                    ),
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.remove('uid');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgetpwPage()));
                                    },
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                right: _listLR,
                                bottom: _listB,
                              ),
                              child: SizedBox(
                                  height: _bottomHeight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: _color,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                    ),
                                    child: Text(
                                      '我要註冊',
                                      style: TextStyle(
                                          fontSize: _sizing.height(2)),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage()));
                                    },
                                  )),
                            ),
                          ),
                        ]),
                      )))),
        ));
  }
}
