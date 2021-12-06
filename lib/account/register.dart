import 'package:flutter/material.dart';

import 'package:My_Day_app/account/register_fail.dart';
import 'package:My_Day_app/public/account_request/register.dart';
import 'package:My_Day_app/public/sizing.dart';

class RegisterPage extends StatefulWidget {
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
    Sizing _sizing = Sizing(context);
    double _appBarSize = _sizing.width(5.2);
    double _leadingL = _sizing.height(2);

    Color _color = Color(0xffF86D67);

    return Container(
      color: _color,
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('註冊',
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
        body: _Register(),
      )),
    );
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
    Sizing _sizing = Sizing(context);

    double _listLR = _sizing.height(5);
    double _listB = _sizing.height(1);
    double _textFied = _sizing.height(4.5);
    double _borderRadius = _sizing.height(1);
    double _iconWidth = _sizing.width(5);
    double _listPaddingH = _sizing.width(6);
    double _textL = _sizing.height(3);
    double _textBT = _sizing.height(2);
    double _leadingL = _sizing.height(2);
    double _bottomHeight = _sizing.height(7);
    double _titleSize = _sizing.height(2.5);
    double _pSize = _sizing.height(2.3);
    double _subtitleSize = _sizing.height(2);
    double _appBarSize = _sizing.width(5.2);

    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);
    Color _color = Color(0xffF86D67);
    Color _light = Color(0xffFFAAA6);

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

    return Container(
      color: _color,
      child: SafeArea(
          child: Scaffold(
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
                          top: _sizing.height(5),
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
                          bottom: _listB,
                          top: _sizing.height(0.01),
                          right: _sizing.height(7),
                        ),
                        child: TextField(
                          controller: registeruid,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: ('請輸入電子信箱'),
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: _sizing.height(1.5),
                                vertical: _sizing.height(1.5)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_borderRadius)), //设置边框四个角的弧度
                              borderSide: BorderSide(color: _bule),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: _listLR,
                          bottom: _listB,
                          right: _listLR,
                        ),
                        child: ListTile(
                          title: Text('姓名：',
                              style: TextStyle(fontSize: _titleSize)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: _sizing.height(7),
                          bottom: _listB,
                          top: _sizing.height(0.01),
                          right: _sizing.height(7),
                        ),
                        child: TextField(
                          controller: registeruserName,
                          obscureText: false,
                          decoration: InputDecoration(
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: _sizing.height(1.5),
                                vertical: _sizing.height(1.5)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_borderRadius)), //设置边框四个角的弧度
                              borderSide: BorderSide(color: _bule),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: _listLR,
                          bottom: _listB,
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
                          bottom: _listB,
                          top: _sizing.height(0.01),
                          right: _sizing.height(7),
                        ),
                        child: TextField(
                          controller: registerpw,
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
                                  Radius.circular(_borderRadius)), //设置边框四个角的弧度
                              borderSide: BorderSide(color: _bule),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: _listLR,
                          bottom: _listB,
                          right: _listLR,
                        ),
                        child: ListTile(
                          title: Text('再次輸入密碼：',
                              style: TextStyle(fontSize: _titleSize)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: _sizing.height(7),
                          bottom: _listB,
                          top: _sizing.height(0.01),
                          right: _sizing.height(7),
                        ),
                        child: TextField(
                          controller: confirmpw,
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
                                  Radius.circular(_borderRadius)), //设置边框四个角的弧度
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
                          if (registeruid.text.isNotEmpty &&
                              registeruserName.text.isNotEmpty &&
                              registerpw.text.isNotEmpty &&
                              confirmpw.text.isNotEmpty) {
                            if (registerpw.text == confirmpw.text) {
                              if (await _submit() != true) {
                                Navigator.of(context).pop();
                              }
                            } else {
                              await registerfailDialog(
                                  context, _alertTitlepw, _alertTxtpw);
                            }
                          } else {
                            await registerfailDialog(
                                context, _alertTitle, _alertTxt);
                          }
                        },
                      )),
                ),
              ])))),
    );
  }
}
