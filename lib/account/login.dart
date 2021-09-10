import 'package:My_Day_app/account/login_fail.dart';
import 'package:My_Day_app/friend/friends_add.dart';
import 'package:My_Day_app/home.dart';
import 'package:My_Day_app/main.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'forget_password.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: <String, WidgetBuilder>{
      '/login': (BuildContext context) => new LoginPage(),
      '/home': (BuildContext context) => new Home(),
    }, debugShowCheckedModeBanner: false, home: LoginWidget());
  }
}

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('登入', style: TextStyle(color: Colors.white, fontSize: 22)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Login(),
        bottomNavigationBar: Container(
            child: Row(children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 150),
              child: FlatButton(
                height: 60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Text(
                  '忘記密碼',
                  style: TextStyle(fontSize: 15),
                ),
                textColor: Color(0xffF86D67),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForgetpwPage()));
                },
              ),
            ),
          ),
          Expanded(
            // ignore: deprecated_member_use
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 150),
              child: FlatButton(
                height: 60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Text(
                  '我要註冊',
                  style: TextStyle(fontSize: 15),
                ),
                textColor: Color(0xffF86D67),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
              ),
            ),
          ),
        ])));
  }
}

class Login extends StatelessWidget {
  get direction => null;
  get border => null;
  get decoration => null;
  get child => null;
  get btnCenterClickEvent => null;
  get appBar => null;
  String uid = 'lili123';
  String pw = '123';
  String _alertTitle = '登入失敗';
  String _alertTxt = '請確認帳號和密碼是否正確';
  
  
 
  final TextEditingController myuid = new TextEditingController();
  final TextEditingController mypw = new TextEditingController();

  BuildContext get context => null;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 150, 35, 0),
                  child: ListTile(
                    title: Text('帳號：', style: TextStyle(fontSize: 20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
                  child: TextField(
                    controller: myuid,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      isCollapsed: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
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
                    controller: mypw,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                      isCollapsed: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
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
                  padding: EdgeInsets.fromLTRB(55, 25, 55, 0),
                  child: FlatButton(
                      height: 40,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        '登入',
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Color(0xffF86D67),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (uid == myuid.text && pw == mypw.text) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ));
                        } else {
                          // print("帳號或密碼錯誤");
                          // loginfail(context, _alertTitle, '請確認帳號和密碼是否正確');
                          bool action = await loginfailDialog(context,_alertTitle,_alertTxt);
                         
                        }
                      }),
                ),
              ],
            )));
  }
}
