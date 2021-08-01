import 'package:flutter/material.dart';
import 'home.dart';
import 'group/group_list_page.dart';
import 'learn.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffF86D67),  //主色
        primaryColorLight: Color(0xffFFAAA6),  //次色
        primaryColorDark: Color(0xffFFF5F5), //淡色
        accentColor: Color(0xffF86D67), 
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
      },
    );
  }
}