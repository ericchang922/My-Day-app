import 'package:My_Day_app/account/change_password.dart';
import 'package:My_Day_app/account/login_fail.dart';
import 'package:My_Day_app/public/account_request/forget_pw.dart';
import 'package:My_Day_app/public/account_request/send_code.dart';
import 'package:flutter/material.dart';

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
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _appBarSize = _width * 0.052;
    double _leadingL = _height * 0.02;

    Color _color = Color(0xffF86D67);

    return Container(
      color: _color,
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('忘記密碼',
              style: TextStyle(color: Colors.white, fontSize: _appBarSize)),
          backgroundColor: _color,
          leading: Container(
            margin: EdgeInsets.only(left: _leadingL),
            child: GestureDetector(
              child: Icon(Icons.chevron_left),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: Forgetpw(),
      )),
    );
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
  String _alertTxtforget = '請確認資料是否正確';
  String _alertTitlecode = '發送失敗';
  String _alertTxtcode = '請確認是否有填電子信箱';

  @override
  Widget build(BuildContext context) {
    _submitforget() async {
      String uid = forgetuid.text;
      String verificationCode = forgetcode.text;

      var submitWidget;
      _submitWidgetfunc() async {
        return ForgetPw(uid: uid, verificationCode: verificationCode);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    _submitcode() async {
      String uid = forgetuid.text;

      var submitWidget;
      _submitWidgetfunc() async {
        return Sendcode(uid: uid);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _listLR = _height * 0.05;
    double _listB = _height * 0.01;
    double _textFied = _height * 0.045;
    double _borderRadius = _height * 0.01;
    double _iconWidth = _width * 0.05;
    double _listPaddingH = _width * 0.06;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;
    double _titleSize = _height * 0.025;
    double _pSize = _height * 0.023;
    double _subtitleSize = _height * 0.02;
    double _appBarSize = _width * 0.052;

    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);
    Color _color = Color(0xffF86D67);
    Color _light = Color(0xffFFAAA6);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
              // 點擊空白處釋放焦點
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: _listLR,
                      bottom: _listB,
                      top: _height * 0.05,
                      right: _listLR,
                    ),
                    child: ListTile(
                      title:
                          Text('電子信箱：', style: TextStyle(fontSize: _titleSize)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: _height * 0.07,
                      bottom: _listB,
                      top: _height * 0.0001,
                      right: _height * 0.07,
                    ),
                    child: TextField(
                      controller: forgetuid,
                      obscureText: false,
                      decoration: InputDecoration(
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _height * 0.015,
                            vertical: _height * 0.015),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(_borderRadius)),
                          borderSide: BorderSide(color: _bule),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: _height * 0.25,
                      right: _height * 0.07,
                    ),
                    child: SizedBox(
                        height: _bottomHeight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: _color,
                          ),
                          child: Text(
                            '發送驗證碼',
                            style: TextStyle(fontSize: _height * 0.02),
                          ),
                          onPressed: () async {
                            if (forgetuid.text.isNotEmpty) {
                              if (await _submitcode() != true) {}
                            } else {
                              await codefailDialog(
                                  context, _alertTitlecode, _alertTxtcode);
                            }
                          },
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: _listLR,
                      bottom: _listB,
                      top: _height * 0.01,
                      right: _listLR,
                    ),
                    child: ListTile(
                      title:
                          Text('驗證碼：', style: TextStyle(fontSize: _titleSize)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: _height * 0.07,
                      bottom: _listB,
                      top: _height * 0.0005,
                      right: _height * 0.07,
                    ),
                    child: TextField(
                      controller: forgetcode,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: '大小寫需一致',
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _height * 0.015,
                            vertical: _height * 0.015),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(_borderRadius)),
                          borderSide: BorderSide(color: _bule),
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
                  height: _bottomHeight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      backgroundColor: _light,
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
                  height: _bottomHeight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      backgroundColor: _color,
                    ),
                    child: Image.asset(
                      'assets/images/confirm.png',
                      width: _iconWidth,
                    ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangepwPage()));
                    },
                  )),
            ),
          ]))),
    );
  }
}
