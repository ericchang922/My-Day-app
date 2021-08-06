import 'dart:convert';

import 'package:My_Day_app/models/common_schedule_list_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonScheduleListPage extends StatefulWidget {
  int groupNum;
  CommonScheduleListPage(this.groupNum);

  @override
  _CommonScheduleListWidget createState() =>
      new _CommonScheduleListWidget(groupNum);
}

class _CommonScheduleListWidget extends State<CommonScheduleListPage> {
  int groupNum;
  _CommonScheduleListWidget(this.groupNum);

  CommonScheduleListModel _commonScheduleListModel = null;

  @override
  void initState() {
    super.initState();
    _groupStudyPlanListtRequest();
  }

  Future<void> _groupStudyPlanListtRequest() async {
    var jsonString =
        await rootBundle.loadString('assets/json/common_schedule_list.json');

    // var httpClient = HttpClient();
    // var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
    //     '/vote/get_end_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    // var response = await request.close();
    // var jsonString = await response.transform(utf8.decoder).join();
    // httpClient.close();

    var jsonMap = json.decode(jsonString);

    var commonScheduleListModel = CommonScheduleListModel.fromJson(jsonMap);
    setState(() {
      _commonScheduleListModel = commonScheduleListModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('共同行程',
                style: TextStyle(fontSize: screenSize.width * 0.052)),
            leading: Container(
              margin: EdgeInsets.only(left: screenSize.height * 0.02),
              child: GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () {
                  Navigator.of(context).pop();
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
              indicatorWeight: screenSize.width * 0.01,
              labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              tabs: <Widget>[
                Container(
                  height: screenSize.height * 0.04683,
                  alignment: Alignment.center,
                  color: Theme.of(context).primaryColor,
                  child: Text("未結束",
                      style: TextStyle(fontSize: screenSize.width * 0.041)),
                ),
                Container(
                  height: screenSize.height * 0.04683,
                  alignment: Alignment.center,
                  color: Theme.of(context).primaryColor,
                  child: Text("已結束",
                      style: TextStyle(fontSize: screenSize.width * 0.041)),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _buildFutureScheduleList(context),
              _buildPastScheduleList(context),
            ],
          )),
    );
  }

  Widget _buildFutureScheduleList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    String _futureScheduleTime(index) {
      var schedule = _commonScheduleListModel.futureSchedule[index];
      String startDate = formatDate(
          DateTime(
            schedule.startTime.year,
            schedule.startTime.month,
            schedule.startTime.day,
          ),
          [yyyy, '年', mm, '月', dd, '日 ']);

      String endDate = formatDate(
          DateTime(
            schedule.endTime.year,
            schedule.endTime.month,
            schedule.endTime.day,
          ),
          [yyyy, '年', mm, '月', dd, '日 ']);

      String startTime = formatDate(
          DateTime(
              schedule.startTime.year,
              schedule.startTime.month,
              schedule.startTime.day,
              schedule.startTime.hour,
              schedule.startTime.minute),
          [HH, ':', nn]);

      String endTime = formatDate(
          DateTime(
              schedule.endTime.year,
              schedule.endTime.month,
              schedule.endTime.day,
              schedule.endTime.hour,
              schedule.endTime.minute),
          [HH, ':', nn]);
      if (startDate == endDate) {
        return startTime + " - " + endTime;
      } else {
        return startTime + " - ";
      }
    }

    if (_commonScheduleListModel != null) {
      if (_commonScheduleListModel.futureSchedule.length == 0) {
        return Container(
          alignment: Alignment.center,
          child: Text('目前沒有任何共同行程!',
              style: TextStyle(fontSize: screenSize.width * 0.03)),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: screenSize.height * 0.01),
          child: ListView.separated(
              itemCount: _commonScheduleListModel.futureSchedule.length,
              itemBuilder: (BuildContext context, int index) {
                var schedule = _commonScheduleListModel.futureSchedule[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.01,
                      vertical: screenSize.height * 0.01),
                  leading: Container(
                      margin: EdgeInsets.only(left: screenSize.height * 0.02),
                      child: Column(
                        children: [
                          Text(schedule.startTime.month.toString() + "月",
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.035)),
                          Text(schedule.startTime.day.toString() + "日",
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.046)),
                        ],
                      )),
                  title: Container(
                    margin: EdgeInsets.only(left: screenSize.height * 0.03),
                    child: Text(schedule.title,
                        style: TextStyle(fontSize: screenSize.width * 0.052)),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(
                        left: screenSize.height * 0.03,
                        top: screenSize.height * 0.007),
                    child: Text(_futureScheduleTime(index),
                        style: TextStyle(
                            fontSize: screenSize.width * 0.035,
                            color: Color(0xff959595))),
                  ),
                  trailing: PopupMenuButton<int>(
                    offset: Offset(-40, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenSize.height * 0.01)),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("隱藏",
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.035))),
                        ),
                        PopupMenuDivider(
                          height: 1,
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("刪除",
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.035))),
                        ),
                      ];
                    },
                    onSelected: (int value) {
                      print(schedule.scheduleNum);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                );
              }),
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildPastScheduleList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    String _pastScheduleTime(index) {
      var schedule = _commonScheduleListModel.pastSchedule[index];
      String startDate = formatDate(
          DateTime(
            schedule.startTime.year,
            schedule.startTime.month,
            schedule.startTime.day,
          ),
          [yyyy, '年', mm, '月', dd, '日 ']);

      String endDate = formatDate(
          DateTime(
            schedule.endTime.year,
            schedule.endTime.month,
            schedule.endTime.day,
          ),
          [yyyy, '年', mm, '月', dd, '日 ']);

      String startTime = formatDate(
          DateTime(
              schedule.startTime.year,
              schedule.startTime.month,
              schedule.startTime.day,
              schedule.startTime.hour,
              schedule.startTime.minute),
          [HH, ':', nn]);

      String endTime = formatDate(
          DateTime(
              schedule.endTime.year,
              schedule.endTime.month,
              schedule.endTime.day,
              schedule.endTime.hour,
              schedule.endTime.minute),
          [HH, ':', nn]);
      if (startDate == endDate) {
        return startTime + " - " + endTime;
      } else {
        return startTime + " - ";
      }
    }

    if (_commonScheduleListModel != null) {
      if (_commonScheduleListModel.pastSchedule.length == 0) {
        return Container(
          alignment: Alignment.center,
          child: Text('目前沒有任何共同行程!',
              style: TextStyle(fontSize: screenSize.width * 0.03)),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: screenSize.height * 0.01),
          child: ListView.separated(
              itemCount: _commonScheduleListModel.pastSchedule.length,
              itemBuilder: (BuildContext context, int index) {
                var schedule = _commonScheduleListModel.pastSchedule[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.01,
                      vertical: screenSize.height * 0.01),
                  leading: Container(
                      margin: EdgeInsets.only(left: screenSize.height * 0.02),
                      child: Column(
                        children: [
                          Text(schedule.startTime.month.toString() + "月",
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.035)),
                          Text(schedule.startTime.day.toString() + "日",
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.046)),
                        ],
                      )),
                  title: Container(
                    margin: EdgeInsets.only(left: screenSize.height * 0.03),
                    child: Text(schedule.title,
                        style: TextStyle(fontSize: screenSize.width * 0.052)),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(
                        left: screenSize.height * 0.03,
                        top: screenSize.height * 0.007),
                    child: Text(_pastScheduleTime(index),
                        style: TextStyle(
                            fontSize: screenSize.width * 0.035,
                            color: Color(0xff959595))),
                  ),
                  trailing: PopupMenuButton<int>(
                    offset: Offset(-40, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenSize.height * 0.01)),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("隱藏",
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.035))),
                        ),
                        PopupMenuDivider(
                          height: 1,
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("刪除",
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.035))),
                        ),
                      ];
                    },
                    onSelected: (int value) {
                      print(schedule.scheduleNum);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                );
              }),
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
