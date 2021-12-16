import 'package:flutter/material.dart';

import 'package:animations/animations.dart';

import 'package:My_Day_app/common_schedule/common_schedule_form.dart';
import 'package:My_Day_app/public/schedule_request/delete.dart';
import 'package:My_Day_app/common_schedule/edit_common_schedule_page.dart';
import 'package:My_Day_app/models/group/common_schedule_list_model.dart';
import 'package:My_Day_app/public/schedule_request/common_list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class CommonScheduleListPage extends StatefulWidget {
  int groupNum;
  CommonScheduleListPage(this.groupNum);

  @override
  _CommonScheduleListWidget createState() =>
      new _CommonScheduleListWidget(groupNum);
}

class _CommonScheduleListWidget extends State<CommonScheduleListPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _groupScheduleListRequest();
  }

  int groupNum;
  _CommonScheduleListWidget(this.groupNum);

  CommonScheduleListModel _commonScheduleListModel;

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _groupScheduleListRequest() async {
    CommonScheduleListModel _request =
        await CommonList(context: context, uid: uid, groupNum: groupNum)
            .getData();

    setState(() {
      _commonScheduleListModel = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _fabDimension = 56.0;

    Sizing _sizing = Sizing(context);

    double _heightSize = _sizing.height(1);
    double _widthSize = _sizing.width(1);
    double _leadingL = _sizing.height(2);
    double _textL = _sizing.height(2);
    double _subtitleT = _sizing.height(0.8);
    double _tabH = _sizing.height(4.683);
    double _listLR = _sizing.width(6);

    double _tabSize = _sizing.width(4.1);
    double _p2Size = _sizing.height(2);
    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;
    Color _gray = Color(0xff959595);
    Color _lightGray = Color(0xffE3E3E3);
    Color _yellow = Color(0xffEFB208);

    Widget futureScheduleList;
    Widget pastScheduleList;

    _submitDelete(int scheduleNum) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return Delete(context: context, uid: uid, scheduleNum: scheduleNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

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

      if (schedule.startTime.day == schedule.endTime.day &&
          schedule.startTime.year == schedule.endTime.year) {
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
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => EditCommonSchedulePage(
                            scheduleNum: schedule.scheduleNum)))
                    .then((value) => _groupScheduleListRequest());
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: _sizing.height(1), bottom: _sizing.height(1)),
                child: Row(
                  children: [
                    SizedBox(
                      width: _sizing.width(18),
                      child: Container(
                        margin: EdgeInsets.only(left: _listLR),
                        child: Column(
                          children: [
                            Text(schedule.startTime.month.toString() + "月",
                                style: TextStyle(fontSize: _subtitleSize)),
                            Text(schedule.startTime.day.toString() + "日",
                                style: TextStyle(fontSize: _titleSize)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _sizing.width(70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: _textL),
                            child: Text(schedule.title,
                                style: TextStyle(fontSize: _titleSize)),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: _textL, top: _subtitleT),
                            child: Text(_scheduleTime(index, true),
                                style: TextStyle(
                                    fontSize: _subtitleSize, color: _gray)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PopupMenuButton<int>(
                        icon: Icon(
                          Icons.more_vert,
                          color: _gray,
                        ),
                        offset: Offset(-40, 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_heightSize)),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                              value: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("刪除",
                                      style: TextStyle(fontSize: _p2Size))),
                            ),
                          ];
                        },
                        onSelected: (int value) async {
                          if (await _submitDelete(schedule.scheduleNum) !=
                              true) {
                            _groupScheduleListRequest();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => EditCommonSchedulePage(
                            scheduleNum: schedule.scheduleNum)))
                    .then((value) => _groupScheduleListRequest());
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: _sizing.height(1), bottom: _sizing.height(1)),
                child: Row(
                  children: [
                    SizedBox(
                      width: _sizing.width(18),
                      child: Container(
                        margin: EdgeInsets.only(left: _listLR),
                        child: Column(
                          children: [
                            Text(schedule.startTime.month.toString() + "月",
                                style: TextStyle(fontSize: _subtitleSize)),
                            Text(schedule.startTime.day.toString() + "日",
                                style: TextStyle(fontSize: _titleSize)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _sizing.width(70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: _textL),
                            child: Text(schedule.title,
                                style: TextStyle(fontSize: _titleSize)),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: _textL, top: _subtitleT),
                            child: Text(_scheduleTime(index, false),
                                style: TextStyle(
                                    fontSize: _subtitleSize, color: _gray)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PopupMenuButton<int>(
                        offset: Offset(-40, 0),
                        icon: Icon(
                          Icons.more_vert,
                          color: _gray,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_heightSize)),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                              value: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("刪除",
                                      style: TextStyle(fontSize: _p2Size))),
                            ),
                          ];
                        },
                        onSelected: (int value) async {
                          if (await _submitDelete(schedule.scheduleNum) !=
                              true) {
                            _groupScheduleListRequest();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
      child: Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: _color,
                title: Text('共同行程', style: TextStyle(fontSize: _appBarSize)),
                leading: Container(
                  margin: EdgeInsets.only(left: _leadingL),
                  child: GestureDetector(
                    child: Icon(Icons.chevron_left),
                    onTap: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/group_detail'));
                    },
                  ),
                ),
                bottom: TabBar(
                  indicator: ShapeDecoration(
                      shape: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: _yellow,
                              width: 0,
                              style: BorderStyle.solid)),
                      gradient: LinearGradient(colors: [_yellow, _yellow])),
                  labelColor: Colors.white,
                  unselectedLabelColor: _lightGray,
                  indicatorPadding: EdgeInsets.all(0.0),
                  indicatorWeight: _widthSize,
                  labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  tabs: <Widget>[
                    Container(
                      height: _tabH,
                      alignment: Alignment.center,
                      color: _color,
                      child: Text("未結束", style: TextStyle(fontSize: _tabSize)),
                    ),
                    Container(
                      height: _tabH,
                      alignment: Alignment.center,
                      color: _color,
                      child: Text("已結束", style: TextStyle(fontSize: _tabSize)),
                    ),
                  ],
                ),
              ),
              floatingActionButton: OpenContainer(
                transitionType: ContainerTransitionType.fadeThrough,
                openBuilder: (BuildContext context, VoidCallback _) {
                  return CommonScheduleForm(groupNum: groupNum);
                },
                closedElevation: 6.0,
                closedShape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_fabDimension / 2)),
                ),
                closedColor: _color,
                closedBuilder:
                    (BuildContext context, VoidCallback openContainer) {
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
                  Container(
                      color: Colors.white,
                      child: SafeArea(top: false, child: futureScheduleList)),
                  Container(
                      color: Colors.white,
                      child: SafeArea(top: false, child: pastScheduleList)),
                ],
              )),
        ),
      ),
    );
  }
}
