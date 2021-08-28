// flutter
import 'package:My_Day_app/homeUpdate.dart';
import 'package:My_Day_app/my_day_icon.dart';
import 'package:My_Day_app/public/timetable_request/main_timetable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// therd
import 'package:animations/animations.dart';
// my day
import 'package:My_Day_app/models/timetable/main_timetable_list_model.dart';
import 'package:My_Day_app/schedule/schedule_table.dart';
import 'package:My_Day_app/schedule/create_schedule.dart';
import 'package:My_Day_app/setting/settings.dart';

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

String _convertToWeekDayName(int number) {
  int num = number;
  List<String> chinese = [
    '零',
    '一',
    '二',
    '三',
    '四',
    '五',
    '六',
    '七',
    '八',
    '九',
    '十',
    ''
  ];
  List<String> unit = ['十', '百', '千'];
  int thousand;
  int hundred;
  int ten;
  int one;
  bool isZero = false;

  String chineseNum = '';
  if (num == null) {
    num = 0;
  }

  if (num >= 10000) {
    num = 0;
    chineseNum = '過大';
  }
  if (num >= 1000) {
    thousand = num ~/ 1000;
    chineseNum += '${chinese[thousand]}${unit[2]}';
  }
  if (num >= 100) {
    num = num % 1000;
    hundred = num ~/ 100;
    if (hundred == 0 && num % 100 != 0) {
      chineseNum += '${chinese[hundred]}';
    } else {
      chineseNum += '${chinese[ten]}${unit[1]}';
    }
  }
  if (num >= 10) {
    num = num % 100;
    ten = num ~/ 10;
    if (ten == 1 && hundred == null && thousand == null) {
      chineseNum += unit[0];
    } else if (ten == 0 && isZero) {
    } else if (ten == 0 && !isZero) {
      chineseNum += chinese[ten];
    } else {
      isZero = false;
      chineseNum += '${chinese[ten]}${unit[0]}';
    }
  }

  one = num % 10;
  if (one > 0) chineseNum += '${chinese[one]}';
  if (num == 0) {
    chineseNum = '';
  } else {
    chineseNum = '第$chineseNum週';
  }

  return chineseNum;
}

AppBar homePageAppBar(context, DateTime nowMon, int weekCount) {
  Color color = Theme.of(context).primaryColor;
  Size _size = MediaQuery.of(context).size;
  double _height = _size.height;
  double _width = _size.width;
  double paddingWidth = _width * 0.05;
  double _monthSize = _height * 0.023;
  double _weekSize = _height * 0.015;

  List<Widget> showWeek(String s) {
    List<Widget> showWidget = [
      Text(
        '${nowMon.month} 月',
        style: TextStyle(fontSize: _monthSize),
      ),
    ];
    if (s == null || s == '') {
    } else {
      showWidget.add(Text(
        s,
        style: TextStyle(fontSize: _weekSize),
      ));
    }
    return showWidget;
  }

  return AppBar(
      title: Container(
        child: Row(children: [
          Padding(
            padding: EdgeInsets.only(left: paddingWidth, right: paddingWidth),
            child: Column(
              children: showWeek('${_convertToWeekDayName(weekCount)}'),
            ),
          ),
          Text('${nowMon.year} 年')
        ]),
      ),
      centerTitle: false,
      backgroundColor: color,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
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
  String _uid = 'amy123';
  Future<bool> _isOk;
  Future<MainTimetableListGet> _futureData;
  MainTimetableListGet _data;
  DateTime now = DateTime.now();
  int homeIndex = 4;
  PageController pageController;
  List<DateTime> mondayList = [];
  List<ScheduleTable> pageList = [];
  List<Map<String, String>> sectionList = [
    {'start': '08:10', 'end': '09:00'},
    {'start': '09:10', 'end': '10:00'},
    {'start': '10:10', 'end': '11:00'},
    {'start': '11:10', 'end': '12:00'},
    {'start': '13:30', 'end': '14:20'},
    {'start': '14:25', 'end': '15:15'},
    {'start': '15:25', 'end': '16:15'}
  ];
  FloatingActionButton _floatingActionButton = null;

  Future<MainTimetableListGet> getThisData() async {
    MainTimetableList request = MainTimetableList(context: context, uid: _uid);
    return request.getData();
  }

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
    HomeInherited.of(context).updateDate(pageList[page].getMonday());
    HomeInherited.of(context).updateWeek(pageList[page].getWeekCount());

    if (page == 0) {
      homeIndex++;
      pageController.jumpToPage(2);
      DateTime mon = _getLastWeek(mondayList[0]);
      setState(() {
        pageList.insert(1,
            ScheduleTable(monday: mon, sectionList: sectionList, data: _data));
        mondayList.insert(0, mon);
      });
      await Future.delayed(Duration(milliseconds: 1));
      pageController.animateToPage(1,
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    }
    if (page == pageList.length - 1) {
      setState(() {
        mondayList.add(_getNextWeek(mondayList[mondayList.length - 1]));
        pageList.add(ScheduleTable(
            monday: mondayList[mondayList.length - 1],
            sectionList: sectionList,
            data: _data));
      });
    }
    if (page == homeIndex) {
      setState(() {
        _floatingActionButton = null;
      });
    } else {
      setState(() {
        _floatingActionButton = FloatingActionButton(
            child: Icon(MyDayIcon.home),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              pageController.animateToPage(homeIndex,
                  duration: Duration(milliseconds: 900), curve: Curves.ease);
            });
      });
    }
  }

  Future<bool> setTable() async {
    _data = await _futureData;
    pageList.insert(0, ScheduleTable());
    for (int i = 0; i < mondayList.length; i++) {
      pageList.add(ScheduleTable(
        monday: mondayList[i],
        sectionList: sectionList,
        data: _data,
      ));
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: homeIndex, keepPage: false);
    pageController.addListener(() {});

    setState(() {
      _futureData = getThisData();

      mondayList = [
        _getLastWeek(_getLastWeek(_getLastWeek(now))),
        _getLastWeek(_getLastWeek(now)),
        _getLastWeek(now),
        _getMon(now),
        _getNextWeek(now)
      ];

      _isOk = setTable();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _isOk,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Stack(children: [
              PageView(
                onPageChanged: _onPageChaged,
                children: pageList,
                controller: pageController,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 20.0, bottom: 16.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: _floatingActionButton),
              )
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
