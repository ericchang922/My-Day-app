import 'package:My_Day_app/common_schedule/common_schedule_create_page.dart';
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

  Future<void> _groupScheduleListRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/common_schedule_list.json');
    // var responseBody = json.decode(response);

    await CommonList(uid, groupNum).commonList().then((value) {
      var commonScheduleListModel = CommonScheduleListModel.fromJson(value);
      setState(() {
        _commonScheduleListModel = commonScheduleListModel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Color color = Theme.of(context).primaryColor;
    double _fabDimension = 56.0;

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
          body: TabBarView(
            children: <Widget>[
              Container(
                  color: Colors.white,
                  child: _buildFutureScheduleList(context)),
              Container(
                  color: Colors.white, child: _buildPastScheduleList(context)),
            ],
          )),
    );
  }

  Widget _buildFutureScheduleList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    String _futureScheduleTime(index) {
      var schedule = _commonScheduleListModel.futureSchedule[index];
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
                  leading: SizedBox(
                    width: screenSize.width * 0.14,
                    child: Container(
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
                  ),
                  title: Container(
                    margin: EdgeInsets.only(left: screenSize.height * 0.02),
                    child: Text(schedule.title,
                        style: TextStyle(fontSize: screenSize.width * 0.052)),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(
                        left: screenSize.height * 0.02,
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
              }),
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
