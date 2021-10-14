import 'package:flutter/material.dart';

import 'package:My_Day_app/account/register_fail.dart';
import 'package:My_Day_app/public/account_request/register.dart';

var primaryColor = Color(0xffF86D67);
var primaryColorLight = Color(0xffFFAAA6);

class RegisterPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: Scaffold(resizeToAvoidBottomInset: false)));
  }

  @override
  RegisterWidget createState() => new RegisterWidget();
}

class RegisterWidget extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('註冊', style: TextStyle(color: Colors.white, fontSize: 22)),
        backgroundColor: primaryColor,
      ),
      body: _Register(),
    ));
  }
}

class _Register extends StatelessWidget {
  get direction => null;
  get border => null;
  get decoration => null;
  get child => null;
  get btnCenterClickEvent => null;
  get appBar => null;

  final registeruid = TextEditingController();
  final registeruserName = TextEditingController();
  final registerpw = TextEditingController();
  final confirmpw = TextEditingController();
  String _alertTitle = '註冊失敗';
  String _alertTxt = '請確認是否有填寫欄位';
  String _alertTitlepw = '註冊失敗';
  String _alertTxtpw = '請確認密碼是否相同';
  BuildContext get context => null;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _iconWidth = _width * 0.05;
    _submit() async {
      String uid = registeruid.text;
      String userName = registeruserName.text;
      String password = registerpw.text;

      var submitWidget;
      _submitWidgetfunc() async {
        return Register(uid: uid, userName: userName, password: password);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
                // 點擊空白處釋放焦點
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 22, 35, 0),
                      child: ListTile(
                        title: Text('帳號：', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
                      child: TextField(
                        controller: registeruid,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: ('請輸入電子信箱'),
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)), //设置边框四个角的弧度
                            borderSide: BorderSide(
                              //用来配置边框的样式
                              color: Colors.red, //设置边框的颜色
                              width: 2.0, //设置边框的粗细
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                      child: ListTile(
                        title: Text('姓名：', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
                      child: TextField(
                        controller: registeruserName,
                        obscureText: false,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)), //设置边框四个角的弧度
                            borderSide: BorderSide(
                              //用来配置边框的样式
                              color: Colors.red, //设置边框的颜色
                              width: 2.0, //设置边框的粗细
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                      child: ListTile(
                        title: Text('密碼：', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
                      child: TextField(
                        controller: registerpw,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)), //设置边框四个角的弧度
                            borderSide: BorderSide(
                              //用来配置边框的样式
                              color: Colors.red, //设置边框的颜色
                              width: 2.0, //设置边框的粗细
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                      child: ListTile(
                        title: Text('再次輸入密碼：', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
                      child: TextField(
                        controller: confirmpw,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)), //设置边框四个角的弧度
                            borderSide: BorderSide(
                              //用来配置边框的样式
                              color: Colors.red, //设置边框的颜色
                              width: 2.0, //设置边框的粗细
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            bottomNavigationBar: Container(
                child: Row(children: <Widget>[
              Expanded(
                // ignore: deprecated_member_use
                child: SizedBox(
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: primaryColorLight,
                      ),
                      child: Image.asset(
                        'assets/images/cancel.png',
                        width: _iconWidth,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
              ),
              Expanded(
                // ignore: deprecated_member_use
                child: SizedBox(
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: primaryColor,
                      ),
                      child: Image.asset(
                        'assets/images/confirm.png',
                        width: _iconWidth,
                      ),
                      onPressed: () async {
                        if (registeruid.text.isNotEmpty &&
                            registeruserName.text.isNotEmpty &&
                            registerpw.text.isNotEmpty &&
                            confirmpw.text.isNotEmpty) {
                          if (registerpw.text == confirmpw.text) {
                            if (await _submit() != true) {
                              Navigator.of(context).pop();
                            }
                          } else {
                            bool action = await registerfailDialog(
                                context, _alertTitlepw, _alertTxtpw);
                          }
                        } else {
                          bool action = await registerfailDialog(
                              context, _alertTitle, _alertTxt);
                        }
                        
                      },
                    )),
              ),
            ]))));
  }
}
