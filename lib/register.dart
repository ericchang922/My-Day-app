
import 'package:flutter/material.dart';
import 'learn.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: RegisterWidget());
  }
}

class RegisterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           title: Text('註冊',
              style:
                  TextStyle(color: Colors.white,fontSize: 22)),
          backgroundColor: PrimaryColor,
        ),
        body: Register(),
        bottomNavigationBar: Container(
          child: Row(children: <Widget>[
            Expanded(
              // ignore: deprecated_member_use
              child: FlatButton(
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Text(
                  '取消',
                  style: TextStyle(fontSize: 18),
                ),
                color: Color(0xffFFAAA6),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ),
            Expanded(
              // ignore: deprecated_member_use
              child: FlatButton(
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Text(
                  '確認',
                  style: TextStyle(fontSize: 18),
                ),
                color: Color(0xffF86D67),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ),
        ])));
  }
}

class Register extends StatelessWidget {
  get direction => null;
  get border => null;
  get decoration => null;
  get child => null;
  get btnCenterClickEvent => null;
  get appBar => null;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(35, 22, 35, 0),
              child: ListTile(
                title: Text('帳號：',style: TextStyle(fontSize: 20)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  hintText: ('請輸入電子信箱'),
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
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: ListTile(
                title: Text('姓名：',style: TextStyle(fontSize: 20)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
              child: TextField(
                obscureText: false,
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
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: ListTile(
                title: Text('密碼：',style: TextStyle(fontSize: 20)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
              child: TextField(
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
              padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: ListTile(
                title: Text('再次輸入密碼：',style: TextStyle(fontSize: 20)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
              child: TextField(
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
            
          ],
        )));
  }
}


