import 'package:My_Day_app/account/login_fail.dart';
import 'package:My_Day_app/public/account_request/change_pw.dart';
import 'package:flutter/material.dart';
import 'login.dart';

var primaryColor = Color(0xffF86D67);
var primaryColorLight = Color(0xffFFAAA6);

class ChangepwPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false);
  }

  @override
  ChangepwWidget createState() => new ChangepwWidget();
}

class ChangepwWidget extends State<ChangepwPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            Text('更改密碼', style: TextStyle(color: Colors.white, fontSize: 22)),
        backgroundColor: primaryColor,
      ),
      body: _Changepw(),
    ));
  }
}

class _Changepw extends StatelessWidget {
  get direction => null;
  get border => null;
  get decoration => null;
  get child => null;
  get btnCenterClickEvent => null;
  get appBar => null;
  String _alertTitle = '更改失敗';
  String _alertTxt = '請確認密碼是否相同';

  final newpw = TextEditingController();
  final confirmpw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _iconWidth = _width * 0.05;
    String id = 'lili123';
    _submit() async {
      String uid = id;
      String password = newpw.text;

      var submitWidget;
      _submitWidgetfunc() async {
        return ChangePw(uid: uid, password: password);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: GestureDetector(
                    // 點擊空白處釋放焦點
                    behavior: HitTestBehavior.translucent,
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(35, 50, 35, 0),
                          child: ListTile(
                            title: Text('新密碼：', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
                          child: TextField(
                            controller: newpw,
                            obscureText: false,
                            decoration: InputDecoration(
                              filled: true,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
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
                            title:
                                Text('再次輸入密碼：', style: TextStyle(fontSize: 20)),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
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
                              backgroundColor: primaryColorLight),
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
                          if (newpw.text.isNotEmpty &&
                              confirmpw.text.isNotEmpty) {
                            if (newpw.text == confirmpw.text) {
                              if (await _submit() != true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              } else {
                                bool action = await changefailDialog(
                                    context, _alertTitle, _alertTxt);
                              }
                            } else {
                              bool action = await changefailDialog(
                                  context, _alertTitle, _alertTxt);
                            }
                          } else {
                            bool action = await changefailDialog(
                                context, _alertTitle, _alertTxt);
                          }
                        }),
                  )),
                ])))));
  }
}
