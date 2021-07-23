import 'package:flutter/material.dart';
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
      home: HomePageWidget(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
      },
    );
  }
}

class HomePageWidget extends StatefulWidget {
  @override
  State<HomePageWidget> createState() => _HomePageWidget();
}

class _HomePageWidget extends State<HomePageWidget> {
  int _selectedIndex = 0;
  final pages = [HomePage('首頁'), GroupListPage('群組'), HomePage('玩聚'), Learn()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: pages[_selectedIndex],
        ),
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Color(0xffF86D67),
              textColor: Color(0xffF6CA07),
              onPressed: () {
                _onItemTapped(0);
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
                '群組',
                style: TextStyle(fontSize: 20),
              ),
              color: Color(0xffF86D67),
              textColor: Colors.white,
              onPressed: () {
                _onItemTapped(1);
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
              onPressed: () {
                _onItemTapped(2);
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
                '學習',
                style: TextStyle(fontSize: 20),
              ),
              color: Color(0xffF86D67),
              textColor: Colors.white,
              onPressed: () {
                _onItemTapped(3);
              },
            ),
          ),
        ])));
  }
}

class HomePage extends StatelessWidget {
  String s;
  HomePage(String s){
    this.s=s;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('首頁', style: TextStyle(fontSize: 22)),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(Icons.login),
            )
          ],
        ),
        body: Center(
          child: Text('這是'+s+'，正在開發中...'),
        ));
  }
}
