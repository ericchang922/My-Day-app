import 'package:My_Day_app/account/register_fail.dart';
import 'package:My_Day_app/public/account_request/register.dart';
import 'package:flutter/material.dart';

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
                          top: _height * 0.05,
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
                          bottom: _listB,
                          top: _height * 0.0001,
                          right: _height * 0.07,
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
                                horizontal: _height * 0.015,
                                vertical: _height * 0.015),
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
                          left: _height * 0.07,
                          bottom: _listB,
                          top: _height * 0.0001,
                          right: _height * 0.07,
                        ),
                        child: TextField(
                          controller: registeruserName,
                          obscureText: false,
                          decoration: InputDecoration(
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: _height * 0.015,
                                vertical: _height * 0.015),
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
                          left: _height * 0.07,
                          bottom: _listB,
                          top: _height * 0.0001,
                          right: _height * 0.07,
                        ),
                        child: TextField(
                          controller: registerpw,
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
                          left: _height * 0.07,
                          bottom: _listB,
                          top: _height * 0.0001,
                          right: _height * 0.07,
                        ),
                        child: TextField(
                          controller: confirmpw,
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
