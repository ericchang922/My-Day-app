import 'package:My_Day_app/models/studyplan/personal_share_studyplan_model.dart';
import 'package:My_Day_app/public/studyplan_request/group_list.dart';
import 'package:My_Day_app/public/studyplan_request/personal_list.dart';
import 'package:My_Day_app/public/studyplan_request/personal_share_list.dart';
import 'package:My_Day_app/study/studyplan_detail_page.dart';
import 'package:My_Day_app/models/schedule/group_studyplan_list_model.dart';
import 'package:My_Day_app/models/studyplan/studyplan_list_model.dart';
import 'package:My_Day_app/study/studyplan_form.dart';
import 'package:date_format/date_format.dart';

import 'package:flutter/material.dart';

class StudyplanListPage extends StatefulWidget {
  @override
  _StudyplanListPage createState() => _StudyplanListPage();
}

class _StudyplanListPage extends State<StudyplanListPage> {
  StudyplanListModel _studyplanListModel;
  GroupStudyplanListModel _groupStudyplanListModel;
  PersonalShareStudyplanListModel _shareStudyplanListModel;

  String uid = 'lili123';
  List _shareStudyplanNumList = [];

  @override
  void initState() {
    super.initState();
    _studyplanListRequest();
    _groupStudyplanListRequest();
    _personalShareStudyplanList();
  }

  _studyplanListRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/studyplan_list.json');
    // var responseBody = json.decode(response);
    // var _request = StudyplanListModel.fromJson(responseBody);

    StudyplanListModel _request = await PersonalList(uid: uid).getData();

    setState(() {
      _studyplanListModel = _request;
    });
  }

  _groupStudyplanListRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/group_studyplan_list.json');
    // var responseBody = json.decode(response);
    // var _request = GroupStudyplanListModel.fromJson(responseBody);

    GroupStudyplanListModel _request = await GroupList(uid: uid).getData();

    setState(() {
      _groupStudyplanListModel = _request;
      _shareStudyplanNumList = [];
      for (int i = 0; i < _groupStudyplanListModel.pastStudyplan.length; i++) {
        var studyplan = _groupStudyplanListModel.pastStudyplan[i];
        for (int j = 0; j < studyplan.studyplanContent.length; j++) {
          _shareStudyplanNumList
              .add(studyplan.studyplanContent[j].studyplanNum);
        }
      }
      for (int i = 0;
          i < _groupStudyplanListModel.futureStudyplan.length;
          i++) {
        var studyplan = _groupStudyplanListModel.futureStudyplan[i];
        for (int j = 0; j < studyplan.studyplanContent.length; j++) {
          _shareStudyplanNumList
              .add(studyplan.studyplanContent[j].studyplanNum);
        }
      }
    });
    print(_shareStudyplanNumList);
  }

  _personalShareStudyplanList() async {
    PersonalShareStudyplanListModel _request =
        await PersonalShareList(uid: uid, shareStatus: 1).getData();
    setState(() {
      _shareStudyplanListModel = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _heightSize = _height * 0.01;
    double _widthSize = _width * 0.01;
    double _leadingL = _height * 0.02;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.01;
    double _subtitleT = _height * 0.008;
    double _tab = _height * 0.04683;
    double _listLR = _width * 0.06;

    double _tabSize = _width * 0.041;
    double _pSize = _height * 0.023;
    double _p2Size = _height * 0.02;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;
    Color _gray = Color(0xff959595);
    Color _bule = Color(0xff7AAAD8);
    Color _lightGray = Color(0xffE3E3E3);
    Color _yellow = Color(0xffEFB208);

    Widget noStudyplan = Center(child: Text('目前沒有任何讀書計畫!'));
    List<Widget> groupStudyplanList = [];

    String _studyPlanTime(DateTime startTime, DateTime endTime) {
      String startTimeValue = formatDate(
          DateTime(startTime.year, startTime.month, startTime.day,
              startTime.hour, startTime.minute),
          [HH, ':', nn]);

      String endTimeValue = formatDate(
          DateTime(endTime.year, endTime.month, endTime.day, endTime.hour,
              endTime.minute),
          [HH, ':', nn]);

      return startTimeValue + " - " + endTimeValue;
    }

    _personalStudyplan(int typeId, int itemCount) {
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin:
                EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
            child: Text('個人', style: TextStyle(fontSize: _pSize, color: _bule)),
          ),
          ListView.separated(
              itemCount: itemCount,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var studyplan;
                if (typeId == 0)
                  studyplan = _studyplanListModel.futureStudyplan[index];
                else
                  studyplan = _studyplanListModel.pastStudyplan[index];
                return InkWell(
                  onTap: () {
                    print(studyplan.studyplanNum);
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => StudyplanDetailPage(
                                studyplan.studyplanNum,
                                typeId,
                                null,
                                _shareStudyplanNumList
                                    .contains(studyplan.studyplanNum))))
                        .then((value) {
                      _studyplanListRequest();
                      _groupStudyplanListRequest();
                      _personalShareStudyplanList();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: _height * 0.01, bottom: _height * 0.01),
                    child: Row(
                      children: [
                        SizedBox(
                          width: _width * 0.18,
                          child: Container(
                            margin: EdgeInsets.only(left: _listLR),
                            child: Column(
                              children: [
                                Text(studyplan.date.month.toString() + "月",
                                    style: TextStyle(fontSize: _subtitleSize)),
                                Text(studyplan.date.day.toString() + "日",
                                    style: TextStyle(fontSize: _titleSize)),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: _textL),
                              child: Text(studyplan.title,
                                  style: TextStyle(fontSize: _titleSize)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: _textL, top: _subtitleT),
                              child: Text(
                                  _studyPlanTime(
                                      studyplan.startTime, studyplan.endTime),
                                  style: TextStyle(
                                      fontSize: _subtitleSize, color: _gray)),
                            ),
                          ],
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
              }),
        ],
      );
    }

    _groupStudyplanList(int typeId, int value, int itemCount) {
      groupStudyplanList = [];
      groupStudyplanList.add(
        ListView.separated(
            itemCount: itemCount,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var studyplan;
              int groupNum;
              if (typeId == 0) {
                studyplan = _groupStudyplanListModel
                    .futureStudyplan[value].studyplanContent[index];
                groupNum =
                    _groupStudyplanListModel.futureStudyplan[value].groupNum;
              } else {
                studyplan = _groupStudyplanListModel
                    .pastStudyplan[value].studyplanContent[index];
                groupNum =
                    _groupStudyplanListModel.pastStudyplan[value].groupNum;
              }

              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => StudyplanDetailPage(
                              studyplan.studyplanNum,
                              typeId,
                              groupNum,
                              _shareStudyplanNumList
                                  .contains(studyplan.studyplanNum))))
                      .then((value) {
                    _studyplanListRequest();
                    _groupStudyplanListRequest();
                    _personalShareStudyplanList();
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: _height * 0.01, bottom: _height * 0.01),
                  child: Row(
                    children: [
                      SizedBox(
                        width: _width * 0.18,
                        child: Container(
                          margin: EdgeInsets.only(left: _listLR),
                          child: Column(
                            children: [
                              Text(studyplan.date.month.toString() + "月",
                                  style: TextStyle(fontSize: _subtitleSize)),
                              Text(studyplan.date.day.toString() + "日",
                                  style: TextStyle(fontSize: _titleSize)),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: _textL),
                            child: Text(studyplan.title,
                                style: TextStyle(fontSize: _titleSize)),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: _textL, top: _subtitleT),
                            child: Text(
                                _studyPlanTime(
                                    studyplan.startTime, studyplan.endTime),
                                style: TextStyle(
                                    fontSize: _subtitleSize, color: _gray)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: _height * 0.03, right: _height * 0.03),
                child: Divider(
                  height: 1,
                  color: _lightGray,
                ),
              );
            }),
      );
      return groupStudyplanList;
    }

    _groupStudyplan(int typeId, int itemCount) {
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin:
                EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
            child: Text('群組', style: TextStyle(fontSize: _pSize, color: _bule)),
          ),
          ListView.separated(
              itemCount: itemCount,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var studyplan;
                if (typeId == 0)
                  studyplan = _groupStudyplanListModel.futureStudyplan[index];
                else
                  studyplan = _groupStudyplanListModel.pastStudyplan[index];
                return Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: _gray,
                    colorScheme: ColorScheme.light(
                      primary: _gray,
                    ),
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                      title: Container(
                        margin: EdgeInsets.only(left: _height * 0.02),
                        child: Text(
                            '${studyplan.groupName} (${studyplan.studyplanCount}) ',
                            style:
                                TextStyle(fontSize: _titleSize, color: _gray)),
                      ),
                      backgroundColor: Colors.white,
                      children: _groupStudyplanList(
                          typeId, index, studyplan.studyplanCount)),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                );
              }),
        ],
      );
    }

    _studyplanList(int typeId) {
      var personalCount;
      var groupCount;

      if (_studyplanListModel != null && _groupStudyplanListModel != null) {
        if (typeId == 0) {
          personalCount = _studyplanListModel.futureStudyplan.length;
          groupCount = _groupStudyplanListModel.futureStudyplan.length;
        } else {
          personalCount = _studyplanListModel.pastStudyplan.length;
          groupCount = _groupStudyplanListModel.pastStudyplan.length;
        }
        if (personalCount == 0 && groupCount == 0) {
          return noStudyplan;
        } else {
          return ListView(
            children: [
              if (personalCount != 0) _personalStudyplan(typeId, personalCount),
              if (groupCount != 0) _groupStudyplan(typeId, groupCount)
            ],
          );
        }
      } else {
        return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()));
      }
    }

    _shareStudyplan() {
      if (_shareStudyplanListModel != null) {
        return ListView.separated(
            itemCount: _shareStudyplanListModel.studyplan.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var studyplan;
              int typeId;
              studyplan = _shareStudyplanListModel.studyplan[index];
              if (studyplan.date.isBefore(DateTime.now()))
                typeId = 1;
              else
                typeId = 0;
              return InkWell(
                onTap: () {
                  print(studyplan.studyplanNum);
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => StudyplanDetailPage(
                              studyplan.studyplanNum, typeId, null, true)))
                      .then((value) {
                    _studyplanListRequest();
                    _groupStudyplanListRequest();
                    _personalShareStudyplanList();
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: _height * 0.01, bottom: _height * 0.01),
                  child: Row(
                    children: [
                      SizedBox(
                        width: _width * 0.18,
                        child: Container(
                          margin: EdgeInsets.only(left: _listLR),
                          child: Column(
                            children: [
                              Text(studyplan.date.month.toString() + "月",
                                  style: TextStyle(fontSize: _subtitleSize)),
                              Text(studyplan.date.day.toString() + "日",
                                  style: TextStyle(fontSize: _titleSize)),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: _textL),
                            child: Text(studyplan.title,
                                style: TextStyle(fontSize: _titleSize)),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: _textL, top: _subtitleT),
                            child: Text(
                                _studyPlanTime(
                                    studyplan.startTime, studyplan.endTime),
                                style: TextStyle(
                                    fontSize: _subtitleSize, color: _gray)),
                          ),
                        ],
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
            });
      }
    }

    return Container(
      color: _color,
      child: SafeArea(
        bottom: false,
        child: DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: _color,
                title: Text('讀書計畫', style: TextStyle(fontSize: _appBarSize)),
                leading: Container(
                  margin: EdgeInsets.only(left: _leadingL),
                  child: GestureDetector(
                    child: Icon(Icons.chevron_left),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudyPlanForm()))
                          .then((value) {
                        _studyplanListRequest();
                        _groupStudyplanListRequest();
                        _personalShareStudyplanList();
                      });
                    },
                  ),
                ],
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
                  indicatorWeight: _width * 0.01,
                  labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  tabs: <Widget>[
                    Container(
                      height: _tab,
                      alignment: Alignment.center,
                      color: _color,
                      child: Text('未結束', style: TextStyle(fontSize: _pSize)),
                    ),
                    Container(
                      height: _tab,
                      alignment: Alignment.center,
                      color: _color,
                      child: Text('已結束', style: TextStyle(fontSize: _pSize)),
                    ),
                    Container(
                      height: _tab,
                      alignment: Alignment.center,
                      color: _color,
                      child: Text('已共享', style: TextStyle(fontSize: _pSize)),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Container(
                      color: Colors.white,
                      child: SafeArea(top: false, child: _studyplanList(0))),
                  Container(
                      color: Colors.white,
                      child: SafeArea(top: false, child: _studyplanList(1))),
                  Container(
                      color: Colors.white,
                      child: SafeArea(top: false, child: _shareStudyplan())),
                ],
              ),
            )),
      ),
    );
  }
}
