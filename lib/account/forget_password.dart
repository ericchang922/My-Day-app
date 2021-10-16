import 'package:My_Day_app/account/change_password.dart';
import 'package:My_Day_app/account/login_fail.dart';
import 'package:My_Day_app/public/account_request/forget_pw.dart';
import 'package:My_Day_app/public/account_request/send_code.dart';
import 'package:flutter/material.dart';

var primaryColor = Color(0xffF86D67);
var primaryColorLight = Color(0xffFFAAA6);

class ForgetpwPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false);
  }

  @override
  ForgetpwWidget createState() => new ForgetpwWidget();
}

class ForgetpwWidget extends State<ForgetpwPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            Text('忘記密碼', style: TextStyle(color: Colors.white, fontSize: 22)),
        backgroundColor: primaryColor,
      ),
      body: Forgetpw(),
    ));
  }
}

class Forgetpw extends StatelessWidget {
  get direction => null;
  get border => null;
  get decoration => null;
  get child => null;
  get btnCenterClickEvent => null;
  get appBar => null;

  final forgetuid = TextEditingController();
  final forgetcode = TextEditingController();
  String _alertTitle = '驗證失敗';
  String _alertTxt = '請確認是否有漏填欄位';
  String _alertTitlecode = '發送失敗';
  String _alertTxtcode = '請確認是否有填電子信箱';
  @override
  Widget build(BuildContext context) {
    // _submit() async {
    //   String uid = forgetuid.text;
    //   String verificationCode = forgetcode.text;

    //   var submitWidget;
    //   _submitWidgetfunc() async {
    //     return ForgetPw(uid: uid, verificationCode: verificationCode);
    //   }

    //   submitWidget = await _submitWidgetfunc();
    //   if (await submitWidget.getIsError())
    //     return true;
    //   else
    //     return false;
    // }

    _submit() async {
      String uid = forgetuid.text;

      var submitWidget;
      _submitWidgetfunc() async {
        return Sendcode(uid: uid);
      }

      submitWidget = await _submitWidgetfunc();
      if ( await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _iconWidth = _width * 0.05;

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
                            title:
                                Text('電子信箱：', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
                          child: TextField(
                            controller: forgetuid,
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
                          padding: EdgeInsets.fromLTRB(155, 0, 45, 0),
                          child: SizedBox(
                              height: 40,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                ),
                                child: Text(
                                  '發送驗證碼',
                                  style: TextStyle(fontSize: 15),
                                ),
                                onPressed: () async {
                                  if (forgetuid.text.isNotEmpty) {
                                    if (await _submit() != true) {
                                      print(_submit());
                                    }
                                  }else{
                                    bool action = await codefailDialog(
                                    context, _alertTitlecode, _alertTxtcode);
                                  }
                                },
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                          child: ListTile(
                            title: Text('驗證碼：', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
                          child: TextField(
                            controller: forgetcode,
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
                            // if (forgetuid.text.isNotEmpty &&
                            //   forgetcode.text.isNotEmpty) {
                            //     if (await _submit() != true) {
                            //           print(_submit()); 
                            //         }
                            // } else {
                            //   bool action = await forgetfailDialog(
                            //       context, _alertTitle, _alertTxt);
                            // }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangepwPage()));
                          },
                        )),
                  ),
                ])))));
  }
}
