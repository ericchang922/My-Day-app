import 'package:My_Day_app/models/group/common_schedule_list_model.dart';
import 'package:My_Day_app/schedule/schedule_table.dart';
import 'package:My_Day_app/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:My_Day_app/schedule/create_schedule.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  double _fabDimension = 56.0;
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
      body: HomePageBody(),
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (BuildContext context, VoidCallback _) {
          return CreateSchedule();
        },
        closedElevation: 6.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_fabDimension / 2)),
        ),
        closedColor: color,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: _fabDimension,
            width: _fabDimension,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

AppBar homePageAppBar(context) {
  Color color = Theme.of(context).primaryColor;
  return AppBar(title: Text('首頁'), backgroundColor: color, actions: [
    IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsPage()));
      },
      icon: Icon(Icons.settings),
    ),
  ]);
}

class HomePageBody extends StatefulWidget {
  @override
  State<HomePageBody> createState() => _HomePageBody();
}

class _HomePageBody extends State<HomePageBody> {
  DateTime now = DateTime.now();
  int homeIndex = 4;
  PageController pageController;
  List<DateTime> mondayList = [];
  List<Widget> pageList = [];
  List<Map<String, String>> sectionList = [
    {'start': '08:10', 'end': '09:00'},
    {'start': '09:10', 'end': '10:00'},
    {'start': '10:10', 'end': '11:00'},
    {'start': '11:10', 'end': '12:00'},
    {'start': '13:30', 'end': '14:20'},
    {'start': '14:25', 'end': '15:15'},
    {'start': '15:25', 'end': '16:15'}
  ];

  _getMon(DateTime today) {
    int daysAfter = today.weekday - 1;
    return DateTime.utc(today.year, today.month, today.day - daysAfter);
  }

  _getLastWeek(DateTime thisWeek) {
    DateTime mon = _getMon(thisWeek).add(Duration(days: -7));
    return DateTime.utc(mon.year, mon.month, mon.day);
  }

  _getNextWeek(DateTime thisWeek) {
    DateTime mon = _getMon(thisWeek).add(Duration(days: 7));
    return DateTime.utc(mon.year, mon.month, mon.day);
  }

  _onPageChaged(int page) async {
    if (page == 0) {
      pageController.animateToPage(2, duration: Duration(seconds: 1), curve: Curves.easeInOut);
      pageController.jumpToPage(2);
      DateTime mon = _getLastWeek(mondayList[0]);
      setState(() {
        pageList.insert(1, ScheduleTable(monday: mon, sectionList: sectionList));
        mondayList.insert(0, mon);
      });
      
    }
    if (page == pageList.length - 1) {
      setState(() {
        mondayList.add(_getNextWeek(mondayList[mondayList.length - 1]));
        pageList.add(ScheduleTable(
            monday: mondayList[mondayList.length - 1],
            sectionList: sectionList));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: homeIndex, keepPage:false);
    pageController.addListener(() {});

    setState(() {
      mondayList = [
        _getLastWeek(_getLastWeek(_getLastWeek(now))),
        _getLastWeek(_getLastWeek(now)),
        _getLastWeek(now),
        _getMon(now),
        _getNextWeek(now)
      ];
      for (int i = 0; i < mondayList.length; i++) {
        pageList.add(ScheduleTable(
          monday: mondayList[i],
          sectionList: sectionList,
        ));
      }
      pageList.insert(0, Container());
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged:_onPageChaged,
      children: pageList,
      controller: pageController,
    );
  }
}
