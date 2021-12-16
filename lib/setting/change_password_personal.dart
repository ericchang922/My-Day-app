import 'package:flutter/material.dart';
import 'package:My_Day_app/account/login_fail.dart';
import 'package:My_Day_app/public/account_request/change_pw.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

var primaryColor = Color(0xffF86D67);
var primaryColorLight = Color(0xffFFAAA6);

class ChangepwPersonalPage extends StatefulWidget {
  @override
  _Changepw createState() => new _Changepw();
}

class _Changepw extends State<ChangepwPersonalPage> {
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
  String id;
  _uid() async {
    id = await loadUid();
  }

  @override
  Widget build(BuildContext context) {
    _uid();
    Sizing _sizing = Sizing(context);
    double _appBarSize = _sizing.width(5.2);
    double _leadingL = _sizing.height(2);
    double _listLR = _sizing.height(5);
    double _listB = _sizing.height(1);
    double _borderRadius = _sizing.height(1);
    double _iconWidth = _sizing.width(5);
    double _bottomHeight = _sizing.height(7);
    double _titleSize = _sizing.height(2.5);

    Color _bule = Color(0xff7AAAD8);

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
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('更改密碼',
            style: TextStyle(color: Colors.white, fontSize: _appBarSize)),
          backgroundColor: primaryColor,
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
        body: SafeArea(
          child: GestureDetector(
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
                      title:
                          Text('新密碼：', style: TextStyle(fontSize: _titleSize)),
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
                      controller: newpw,
                      obscureText: true,
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
                      bottom: _listB,
                      top: _sizing.height(1),
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
                      top: _sizing.height(0.05),
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
                              Radius.circular(_borderRadius)), 
                          borderSide: BorderSide(color: _bule),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).bottomAppBarColor,
          child: SafeArea(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                      height: _bottomHeight,
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
                    child: SizedBox(
                  height: _bottomHeight,
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
                        if (newpw.text.isNotEmpty && confirmpw.text.isNotEmpty) {
                          if (newpw.text == confirmpw.text) {
                            if (await _submit() != true) {
                              Navigator.of(context).pop();
                            } else {
                              await changefailDialog(
                                  context, _alertTitle, _alertTxt);
                            }
                          } else {
                            await changefailDialog(
                                context, _alertTitle, _alertTxt);
                          }
                        } else {
                          await changefailDialog(context, _alertTitle, _alertTxt);
                        }
                      }),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
