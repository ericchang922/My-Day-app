import 'package:flutter/material.dart';

import 'package:My_Day_app/account/change_password.dart';
import 'package:My_Day_app/account/login_fail.dart';
import 'package:My_Day_app/public/account_request/forget_pw.dart';
import 'package:My_Day_app/public/account_request/send_code.dart';
import 'package:My_Day_app/public/sizing.dart';

class ForgetpwPage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false);
  }

  @override
  Forgetpw createState() => new Forgetpw();
}

class Forgetpw extends State<ForgetpwPage> {
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
        return Sendcode(context: context, uid: uid);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    Sizing _sizing = Sizing(context);

    double _listLR = _sizing.height(5);
    double _listB = _sizing.height(1);
    double _borderRadius = _sizing.height(1);
    double _iconWidth = _sizing.width(5);
    double _leadingL = _sizing.height(2);
    double _bottomHeight = _sizing.height(7);
    double _titleSize = _sizing.height(2.5);
    double _appBarSize = _sizing.width(5.2);

    Color _bule = Color(0xff7AAAD8);
    Color _color = Color(0xffF86D67);
    Color _light = Color(0xffFFAAA6);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        
        body: GestureDetector(
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
                  )),
                  Container(
                    margin: EdgeInsets.only(
                      left: _sizing.height(7),
                      bottom: _listB,
                      top: _sizing.height(0.01),
                      right: _sizing.height(7),
                    ),
                    child: TextField(
                      controller: forgetuid,
                      obscureText: false,
                      decoration: InputDecoration(
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _sizing.height(1.5),
                            vertical: _sizing.height(1.5)),
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
                      left: _sizing.height(25),
                      right: _sizing.height(7),
                    ),
                    child: SizedBox(
                        height: _bottomHeight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: _color,
                          ),
                          child: Text(
                            '發送驗證碼',
                            style: TextStyle(fontSize: _sizing.height(2)),
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
                      top: _sizing.height(1),
                      right: _listLR,
                    ),
                    child: ListTile(
                      title:
                          Text('驗證碼：', style: TextStyle(fontSize: _titleSize)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: _sizing.height(7),
                      bottom: _listB,
                      top: _sizing.height(0.05),
                      right: _sizing.height(7),
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
                            horizontal: _sizing.height(1.5),
                            vertical: _sizing.height(1.5)),
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
                    
                    if (forgetuid.text.isNotEmpty &&
                            forgetcode.text.isNotEmpty) {
                              if (await _submitforget() != true) {
                                Navigator.push( context,
                                  MaterialPageRoute(builder: (context) => ChangepwPage(forgetuid.text)));
                                  }else{
                                    bool action = await forgetfailDialog(
                                      context, _alertTitle, _alertTxtforget);
                                  }
                          } else {
                            bool action = await forgetfailDialog(
                                context, _alertTitle, _alertTxt);
                          }
                  },
                )),
          ),
        ]))),
    );
  }
}
