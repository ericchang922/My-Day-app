// flutter
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// therd
import 'package:animations/animations.dart';
// my day
import 'package:My_Day_app/my_day_icon.dart';
import 'package:My_Day_app/group/group_list_page.dart';
import 'package:My_Day_app/home_page.dart';
import 'package:My_Day_app/homeUpdate.dart';
import 'package:My_Day_app/studyplan/learn.dart';
import 'package:My_Day_app/temporary_group/temporary_group_list_page.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _index = 0;

  final _pages = <Widget>[
    HomePage(),
    GroupListPage(),
    TemporaryGroupListPage(),
    Learn()
  ];

  void _onTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime nowMon = HomeInherited.of(context).nowMon;
    int weekCount = HomeInherited.of(context).weekCount;
    final _appBars = <Widget>[
      homePageAppBar(context, nowMon, weekCount),
      groupListAppBar(context),
      temporaryGroupListAppBar(context),
      learnAppBar
    ];
    Color color = Theme.of(context).primaryColor;
    var size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    double iconSize = height * 0.04;

    return Container(
      color: color,
      child: SafeArea(
        child: Scaffold(
            appBar: _appBars[_index],
            body: PageTransitionSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.vertical,
                );
              }, // 動畫 Widget function
              child: _pages[_index], // 頁面
            ),
            bottomNavigationBar: SizedBox(
              height: height * 0.09,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.white,
                unselectedItemColor: Colors.yellow,
                backgroundColor: color,
                elevation: 0.0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(MyDayIcon.home, size: iconSize),
                    label: '首頁',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MyDayIcon.group, size: iconSize),
                    label: '群組',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MyDayIcon.temporary_group, size: iconSize),
                    label: '玩聚',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MyDayIcon.study, size: iconSize),
                    label: '學習',
                  ),
                ],
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: _index,
                selectedIconTheme: IconThemeData(color: Colors.white),
                onTap: _onTapped,
              ),
            )),
      ),
    );
  }
}
