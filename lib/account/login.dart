import 'package:My_Day_app/account/forget_password.dart';
import 'package:My_Day_app/account/login_fail.dart';
import 'package:My_Day_app/account/register.dart';
import 'package:My_Day_app/home.dart';
import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/public/account_request/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _listLR = _height * 0.05;
    double _listB = _height * 0.18;
    double _borderRadius = _height * 0.01;
    double _bottomHeight = _height * 0.06;
    double _titleSize = _height * 0.025;
    double _appBarSize = _width * 0.052;

    Color _bule = Color(0xff7AAAD8);
    Color _color = Color(0xffF86D67);

    _submit() async {
      String uid = myuid.text;
      String password = mypw.text;

      var submitWidget;
      _submitWidgetfunc() async {
        return Login(uid: uid, password: password);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MaterialApp(
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
                          // 點擊空白處釋放焦點
                          behavior: HitTestBehavior.translucent,
                          onTap: () =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          child: ListView(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                  left: _listLR,
                                  top: _height * 0.1,
                                  right: _listLR,
                                ),
                                child: ListTile(
                                  title: Text('帳號：',
                                      style: TextStyle(fontSize: _titleSize)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: _height * 0.07,
                                  top: _height * 0.0001,
                                  right: _height * 0.07,
                                ),
                                child: TextField(
                                  controller: myuid,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: _height * 0.015,
                                        vertical: _height * 0.015),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              _borderRadius)), //设置边框四个角的弧度
                                      borderSide: BorderSide(color: _bule),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: _listLR,
                                  top: _height * 0.02,
                                  right: _listLR,
                                ),
                                child: ListTile(
                                  title: Text('密碼：',
                                      style: TextStyle(fontSize: _titleSize)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: _height * 0.07,
                                  top: _height * 0.0001,
                                  right: _height * 0.07,
                                ),
                                child: TextField(
                                  controller: mypw,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: _height * 0.015,
                                        vertical: _height * 0.015),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              _borderRadius)), //设置边框四个角的弧度
                                      borderSide: BorderSide(color: _bule),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: _height * 0.07,
                                  top: _height * 0.05,
                                  right: _height * 0.07,
                                ),
                                child: SizedBox(
                                    height: _bottomHeight,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        _borderRadius)),
                                            backgroundColor: _color),
                                        child: Text(
                                          '登入',
                                          style:
                                              TextStyle(fontSize: _titleSize),
                                        ),
                                        onPressed: () async {
                                          if (myuid.text.isNotEmpty &&
                                              mypw.text.isNotEmpty) {
                                            if (await _submit() != true) {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setString(
                                                  'TestString_Key', myuid.text);

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeWidget()));
                                            } else {
                                              await loginfailDialog(context,
                                                  _alertTitle, _alertTxt);
                                            }
                                          } else {
                                            await loginfailDialog(context,
                                                _alertTitle, _alertTxt);
                                          }
                                        })),
                              ),
                            ],
                          )),
                      bottomNavigationBar: Container(
                          child: Row(children: <Widget>[
                        Expanded(
                          // ignore: deprecated_member_use
                          child: Container(
                            margin: EdgeInsets.only(
                              left: _listLR,
                              bottom: _listB,
                            ),
                            child: SizedBox(
                                height: _bottomHeight,
                                child: TextButton(
                                  child: Text('忘記密碼',
                                      style:
                                          TextStyle(fontSize: _height * 0.02)),
                                  style: TextButton.styleFrom(
                                    primary: _color,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0)),
                                  ),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.remove('TestString_Key');
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
                          // ignore: deprecated_member_use
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
                                        borderRadius: BorderRadius.circular(0)),
                                  ),
                                  child: Text(
                                    '我要註冊',
                                    style: TextStyle(fontSize: _height * 0.02),
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
                      ])))),
            )));
  }
}
