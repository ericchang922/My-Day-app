import 'package:flutter/material.dart';
import 'personal_information.dart';

const PrimaryColor = const Color(0xFFF86D67);
class ChangepwPersonalPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: ChangepwPersonalWidget());
  }
}

class ChangepwPersonalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  double _width = size.width;
  double _iconWidth = _width * 0.05;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('更改密碼',
              style:
                  TextStyle(color: Colors.white,fontSize: 22)),
          backgroundColor: PrimaryColor,
        ),
        body: Changepw(),
        bottomNavigationBar: Container(
            child: Row(children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: SizedBox(
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    backgroundColor: Color(0xffFFAAA6)
                    ),
              
              child: Image.asset(
                    'assets/images/cancel.png',
                    width: _iconWidth,
                  ),
              
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PersonalInformationPage()));
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    backgroundColor: Color(0xffF86D67)
                    ),
             
              child: Image.asset(
                    'assets/images/confirm.png',
                    width: _iconWidth,
                  ),
              
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PersonalInformationPage()));
              },
            ),
          )),
        ]))));
  }
}

class Changepw extends StatelessWidget {
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
        home: SafeArea(
      child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 50, 35, 0),
                  child: ListTile(
                    title: Text('新密碼：',style: TextStyle(fontSize: 20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(52, 0, 52, 0),
                  child: TextField(
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
            ))));
  }
}
