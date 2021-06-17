import 'package:flutter/material.dart';
import 'group.dart';
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
      debugShowCheckedModeBanner: false, 
      home: HomePageWidget(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new HomePageWidget(),
        '/group' : (BuildContext context) => new GroupPageWidget(),
        '/login' : (BuildContext context) => new LoginPage(),
        '/learn' : (BuildContext context) => new LearnPage(),
      },
      );
  }
}

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('首頁',style: TextStyle(fontSize: 22)),
          actions: [
            IconButton(
              onPressed: () {
                  Navigator.pushReplacementNamed(context,'/login');
                },
              icon: Icon(Icons.login),)
            ],
        ),
        body: HomePage(),
        bottomNavigationBar: Container(
          child: Row(children: <Widget>[
            Expanded(
              // ignore: deprecated_member_use
              child: FlatButton(
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Text(
                  '首頁',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                ),
                color: Color(0xffF86D67),
                textColor: Color(0xffF6CA07),
                onPressed: () {},
              ),
            ),
            Expanded(
              // ignore: deprecated_member_use
              child: FlatButton(
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Text(
                  '群組',
                  style: TextStyle(fontSize: 20),
                ),
                color: Color(0xffF86D67),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context,'/group');
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
                  '玩聚',
                  style: TextStyle(fontSize: 20),
                ),
                color: Color(0xffF86D67),
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
            Expanded(
              // ignore: deprecated_member_use
              child: FlatButton(
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Text(
                  '學習',
                  style: TextStyle(fontSize: 20),
                ),
                color: Color(0xffF86D67),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context,'/learn');
                },
              ),
            ),
            
        ])));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('這是首頁，正在開發中...'),
    );
  }
}
