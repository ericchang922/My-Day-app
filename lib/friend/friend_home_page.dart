// flutter
import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/setting/get_timetable.dart';
import 'package:My_Day_app/public/setting_request/get_timetable.dart';
import 'package:flutter/material.dart';
// therd
import 'package:animations/animations.dart';
// my day
import 'package:My_Day_app/friend/friend_home_schedule/schedule_table.dart';
import 'package:My_Day_app/schedule/create_schedule.dart';
import 'package:My_Day_app/home/home_Update.dart';
import 'package:My_Day_app/models/schedule/schedule_list_model.dart';
import 'package:My_Day_app/models/timetable/main_timetable_list_model.dart';
import 'package:My_Day_app/models/timetable/section_time_model.dart';
import 'package:My_Day_app/public/schedule_request/get_list.dart';
import 'package:My_Day_app/public/timetable_request/main_timetable_list.dart';
import 'package:My_Day_app/public/convert.dart';
import 'package:My_Day_app/public/time_range.dart';
import 'package:My_Day_app/public/timetable_request/get_section_time.dart';
import 'package:My_Day_app/public/sizing.dart';

class FriendHomePage extends StatefulWidget {
  String friendId;
  FriendHomePage(this.friendId);
  @override
  State<FriendHomePage> createState() => _FriendHomePage(friendId);
}

class _FriendHomePage extends State<FriendHomePage> {

  String friendId;
  _FriendHomePage( this.friendId);

  Future<MainTimetableListGet> getTimetableData() async {
    MainTimetableList request =
        MainTimetableList(context: context, uid: friendId);
    MainTimetableListGet _data = await request.getData();

    return _data;
  }

  Future<ScheduleGetList> getScheduleList() async {
    GetList request = GetList(context: context, uid: friendId);
    ScheduleGetList _data = await request.getData();
    return _data;
  }

  Future<SectionTime> getSectionTime() async {
    GetSectionTime request = GetSectionTime(context: context, uid: friendId);
    SectionTime _data = await request.getData();
    return _data;
  }

  double _fabDimension = 0;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    FriendHomePageBody homePageBody = new FriendHomePageBody(
      futureTimetableData: getTimetableData(),
      futureScheduleList: getScheduleList(),
      futureSectionTime: getSectionTime(),
    );

    return Scaffold(
      body: homePageBody,
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
          );
        },
        onClosed: (value) {
          homePageBody = new FriendHomePageBody(
            futureTimetableData: getTimetableData(),
            futureScheduleList: getScheduleList(),
          );
        },
      ),
    );
  }
}

AppBar FriendhomePageAppBar(context, DateTime nowMon, int weekCount) {
  Color color = Theme.of(context).primaryColor;
  Sizing _sizing = Sizing(context);
  double paddingWidth = _sizing.width(5);
  double _monthSize = _sizing.height(2.3);
  double _weekSize = _sizing.height(1.5);
  double _titleSize = _sizing.height(2.5);

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
    title: Text('好友課表', style: TextStyle(fontSize: _titleSize)),
    leading: IconButton(
      icon: Icon(Icons.chevron_left),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    centerTitle: false,
    backgroundColor: color,
  );
}

class FriendHomePageBody extends StatefulWidget {
  Future<MainTimetableListGet> futureTimetableData;
  Future<ScheduleGetList> futureScheduleList;
  Future<SectionTime> futureSectionTime;


  FriendHomePageBody(
      {this.futureTimetableData,
      this.futureScheduleList,
      this.futureSectionTime,
    });
  @override
  State<FriendHomePageBody> createState() => _FriendHomePageBody();
}

class _FriendHomePageBody extends State<FriendHomePageBody> {

  Future<bool> _isOk;

  MainTimetableListGet _data;
  ScheduleGetList _scheduleList;
  SectionTime _sectionTime;

  GetTimetableModel _timetable;

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
  FloatingActionButton _floatingActionButton;

  @override
  _getTimetableRequest() async {
    String uid = prefs.getString('uid');
    GetTimetableModel _request =
        await GetTimetable(context: context, uid: uid).getData();

    setState(() {
      _timetable = _request;
      
      print(_timetable.timetable);
      print("_timetable123");
    });
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
        pageList.insert(
            1,
            ScheduleTable(
              monday: mon,
              sectionList: sectionList,
              data: _data,
              scheduleList: _scheduleList,
            ));
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
          data: _data,
          scheduleList: _scheduleList,
        ));
      });
    }
    if (page == homeIndex) {
      setState(() {
        _floatingActionButton = null;
      });
    }
  }

  Future<bool> setTable() async {
    _scheduleList = await widget.futureScheduleList;
    _data = await widget.futureTimetableData;
    _sectionTime = await widget.futureSectionTime;

    for (var s in _sectionTime.timetable) {
      if (TimeRange(DateTime.now()).inTime(s.startDate, s.endDate)) {
        sectionList = [];
        for (var sub in s.subject) {
          sectionList.add({
            'start': ConvertDuration.toShortTime(sub.startTime),
            'end': ConvertDuration.toShortTime(sub.endTime)
          });
        }
      }
    }

    pageList.insert(0, ScheduleTable());
    for (int i = 0; i < mondayList.length; i++) {
      pageList.add(ScheduleTable(
        monday: mondayList[i],
        sectionList: sectionList,
        data: _data,
        scheduleList: _scheduleList,
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
      
      mondayList = [
        _getLastWeek(_getLastWeek(_getLastWeek(now))),
        _getLastWeek(_getLastWeek(now)),
        _getLastWeek(now),
        _getMon(now),
        _getNextWeek(now)
      ];

      _isOk = setTable();
      _getTimetableRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _isOk,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if(_timetable.timetable==false||_timetable.timetable==null){
              return Center(child: Text("你沒有權限觀看好友課表"));
            }else{
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
            }
            
          }else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
