import 'dart:convert';

import 'package:My_Day_app/common_schedule/common_schedule_create_page.dart';
import 'package:My_Day_app/common_schedule/common_schedule_detail_page.dart';
import 'package:My_Day_app/common_schedule/common_schedule_edit_page.dart';
import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/common_schedule_list_model.dart';
import 'package:My_Day_app/schedule/schedule_request.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonScheduleListPage extends StatefulWidget {
  int groupNum;
  CommonScheduleListPage(this.groupNum);

  @override
  _CommonScheduleListWidget createState() =>
      new _CommonScheduleListWidget(groupNum);
}

class _CommonScheduleListWidget extends State<CommonScheduleListPage>
    with RouteAware {
  int groupNum;
  _CommonScheduleListWidget(this.groupNum);

  CommonScheduleListModel _commonScheduleListModel = null;

  String uid = 'lili123';

  @override
  void initState() {
    super.initState();
    _groupScheduleListRequest();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    _groupScheduleListRequest();
  }

  _groupScheduleListRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/common_schedule_list.json');
    // var responseBody = json.decode(response);

    await CommonList(uid, groupNum).commonList().then((responseBody) {
      var commonScheduleListModel =
          CommonScheduleListModel.fromJson(responseBody);
      setState(() {
        _commonScheduleListModel = commonScheduleListModel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _fabDimension = 56.0;

    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _heightSize = _height * 0.01;
    double _widthSize = _width * 0.01;
    double _leadingL = _height * 0.02;
    double _textL = _height * 0.03;
    double _subtitleT = _height * 0.005;
    double _tabH = _height * 0.04683;

    double _tabSize = _width * 0.041;
    double _p2Size = _height * 0.02;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;
    Color _gray = Color(0xff959595);

    Widget futureScheduleList;
    Widget pastScheduleList;

    String _scheduleTime(index, isFuture) {
      var schedule;
      if (isFuture)
        schedule = _commonScheduleListModel.futureSchedule[index];
      else
        schedule = _commonScheduleListModel.pastSchedule[index];

      String startTime =
          "${schedule.startTime.hour.toString().padLeft(2, '0')}:${schedule.startTime.minute.toString().padLeft(2, '0')}";
      String endTime =
          "${schedule.endTime.hour.toString().padLeft(2, '0')}:${schedule.endTime.minute.toString().padLeft(2, '0')}";

      if (schedule.startTime.day == schedule.endTime.day) {
        if (startTime == "00:00" && endTime == "00:00" ||
            startTime == "00:00" && endTime == "23:59") {
          return "整天";
        } else {
          return startTime + " - " + endTime;
        }
      } else {
        return startTime + " - ";
      }
    }

    Widget noSchedule = Center(child: Text('目前沒有任何共同行程!'));
    if (_commonScheduleListModel != null) {
      if (_commonScheduleListModel.futureSchedule.length == 0) {
        futureScheduleList = noSchedule;
      } else {
        futureScheduleList = ListView.separated(
          itemCount: _commonScheduleListModel.futureSchedule.length,
          itemBuilder: (BuildContext context, int index) {
            var schedule = _commonScheduleListModel.futureSchedule[index];
            return ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _heightSize, vertical: _heightSize),
              leading: SizedBox(
                width: _width * 0.14,
                child: Container(
                    margin: EdgeInsets.only(left: _leadingL),
                    child: Column(
                      children: [
                        Text(schedule.startTime.month.toString() + "月",
                            style: TextStyle(fontSize: _subtitleSize)),
                        Text(schedule.startTime.day.toString() + "日",
                            style: TextStyle(fontSize: _titleSize)),
                      ],
                    )),
              ),
              title: Container(
                margin: EdgeInsets.only(left: _textL),
                child: Text(schedule.title,
                    style: TextStyle(fontSize: _titleSize)),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(left: _textL, top: _subtitleT),
                child: Text(_scheduleTime(index, true),
                    style: TextStyle(fontSize: _subtitleSize, color: _gray)),
              ),
              trailing: PopupMenuButton<int>(
                offset: Offset(-40, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_heightSize)),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child:
                              Text("刪除", style: TextStyle(fontSize: _p2Size))),
                    ),
                  ];
                },
                onSelected: (int value) {
                  print(schedule.scheduleNum);
                },
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CommonScheduleEditPage(schedule.scheduleNum)));
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
            );
          },
        );
      }
    } else {
      futureScheduleList = Center(child: CircularProgressIndicator());
    }

    if (_commonScheduleListModel != null) {
      if (_commonScheduleListModel.pastSchedule.length == 0) {
        pastScheduleList = noSchedule;
      } else {
        pastScheduleList = ListView.separated(
          itemCount: _commonScheduleListModel.pastSchedule.length,
          itemBuilder: (BuildContext context, int index) {
            var schedule = _commonScheduleListModel.pastSchedule[index];
            return ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _heightSize, vertical: _heightSize),
              leading: SizedBox(
                width: _width * 0.16,
                child: Container(
                    margin: EdgeInsets.only(left: _leadingL),
                    child: Column(
                      children: [
                        Text(schedule.startTime.month.toString() + "月",
                            style: TextStyle(fontSize: _subtitleSize)),
                        Text(schedule.startTime.day.toString() + "日",
                            style: TextStyle(fontSize: _titleSize)),
                      ],
                    )),
              ),
              title: Container(
                margin: EdgeInsets.only(left: _textL),
                child: Text(schedule.title,
                    style: TextStyle(fontSize: _titleSize)),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(left: _textL, top: _subtitleT),
                child: Text(_scheduleTime(index, false),
                    style: TextStyle(fontSize: _subtitleSize, color: _gray)),
              ),
              trailing: PopupMenuButton<int>(
                offset: Offset(-40, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_heightSize)),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child:
                              Text("刪除", style: TextStyle(fontSize: _p2Size))),
                    ),
                  ];
                },
                onSelected: (int value) {
                  print(schedule.scheduleNum);
                },
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CommonScheduleDetailPage(schedule.scheduleNum)));
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
            );
          },
        );
      }
    } else {
      pastScheduleList = Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('共同行程', style: TextStyle(fontSize: _appBarSize)),
            leading: Container(
              margin: EdgeInsets.only(left: _leadingL),
              child: GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            bottom: TabBar(
              indicator: ShapeDecoration(
                  shape: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffEFB208),
                          width: 0,
                          style: BorderStyle.solid)),
                  gradient: LinearGradient(
                      colors: [Color(0xffEFB208), Color(0xffEFB208)])),
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xffe3e3e3),
              indicatorPadding: EdgeInsets.all(0.0),
              indicatorWeight: _widthSize,
              labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              tabs: <Widget>[
                Container(
                  height: _tabH,
                  alignment: Alignment.center,
                  color: Theme.of(context).primaryColor,
                  child: Text("未結束", style: TextStyle(fontSize: _tabSize)),
                ),
                Container(
                  height: _tabH,
                  alignment: Alignment.center,
                  color: Theme.of(context).primaryColor,
                  child: Text("已結束", style: TextStyle(fontSize: _tabSize)),
                ),
              ],
            ),
          ),
          floatingActionButton: OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (BuildContext context, VoidCallback _) {
              return CommonScheduleCreatePage(groupNum);
            },
            closedElevation: 6.0,
            closedShape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(_fabDimension / 2)),
            ),
            closedColor: _color,
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
          body: TabBarView(
            children: <Widget>[
              Container(color: Colors.white, child: futureScheduleList),
              Container(color: Colors.white, child: pastScheduleList),
            ],
          )),
    );
  }
}
