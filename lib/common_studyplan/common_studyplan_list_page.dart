import 'package:flutter/material.dart';

import 'package:My_Day_app/public/studyplan_request/cancel_sharing.dart';
import 'package:My_Day_app/public/studyplan_request/one_group_list.dart';
import 'package:My_Day_app/common_studyplan/share_studyplan_page.dart';
import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/study_plan/share_studyplan_list_model.dart';
import 'package:date_format/date_format.dart';

class CommonStudyPlanListPage extends StatefulWidget {
  int groupNum;
  CommonStudyPlanListPage(this.groupNum);

  @override
  _CommonStudyPlanListWidget createState() =>
      new _CommonStudyPlanListWidget(groupNum);
}

class _CommonStudyPlanListWidget extends State<CommonStudyPlanListPage>
    with RouteAware {
  int groupNum;
  _CommonStudyPlanListWidget(this.groupNum);

  ShareStudyplanListModel _groupStudyplanListModel;

  String uid = 'lili123';

  @override
  void initState() {
    super.initState();
    _groupStudyplanListRequest();
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
    _groupStudyplanListRequest();
  }

  _groupStudyplanListRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/share_studyplan_list.json');
    // var responseBody = json.decode(response);
    // var _request = ShareStudyplanListModel.fromJson(responseBody);

    ShareStudyplanListModel _request =
        await OneGroupList(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _groupStudyplanListModel = _request;
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
    double _subtitleT = _height * 0.008;
    double _tabH = _height * 0.04683;

    double _tabSize = _width * 0.041;
    double _p2Size = _height * 0.02;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;
    Color _gray = Color(0xff959595);

    Widget noStudyplan = Center(child: Text('目前沒有任何共同讀書計畫!'));
    Widget groupStudyPlanList;

    _submitCancel(int studyplanNum) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return CancelSharing(
            uid: uid, studyplanNum: studyplanNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    String _studyPlanTime(index) {
      var studyplan = _groupStudyplanListModel.studyplan[index];

      String startTime = formatDate(
          DateTime(
              studyplan.startTime.year,
              studyplan.startTime.month,
              studyplan.startTime.day,
              studyplan.startTime.hour,
              studyplan.startTime.minute),
          [HH, ':', nn]);

      String endTime = formatDate(
          DateTime(
              studyplan.endTime.year,
              studyplan.endTime.month,
              studyplan.endTime.day,
              studyplan.endTime.hour,
              studyplan.endTime.minute),
          [HH, ':', nn]);

      return startTime + " - " + endTime;
    }

    _popupMenu(String id, int studyplanNum) {
      if (id == uid) {
        return PopupMenuButton(
          offset: Offset(-40, 0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_height * 0.01)),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                child: Container(
                    alignment: Alignment.center,
                    child: Text("取消分享",
                        style: TextStyle(fontSize: _subtitleSize))),
              ),
            ];
          },
          onSelected: (int value) async {
            if (await _submitCancel(studyplanNum) != true) {
              _groupStudyplanListRequest();
            }
          },
        );
      }
    }

    if (_groupStudyplanListModel != null) {
      if (_groupStudyplanListModel.studyplan.length == 0) {
        groupStudyPlanList = noStudyplan;
      } else {
        groupStudyPlanList = ListView.separated(
            itemCount: _groupStudyplanListModel.studyplan.length,
            itemBuilder: (BuildContext context, int index) {
              var studyplan = _groupStudyplanListModel.studyplan[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: _heightSize, vertical: _heightSize),
                leading: SizedBox(
                  width: _width * 0.16,
                  child: Container(
                      margin: EdgeInsets.only(left: _leadingL),
                      child: Column(
                        children: [
                          Text(studyplan.date.month.toString() + "月",
                              style: TextStyle(fontSize: _subtitleSize)),
                          Text(studyplan.date.day.toString() + "日",
                              style: TextStyle(fontSize: _titleSize)),
                        ],
                      )),
                ),
                title: Container(
                  margin: EdgeInsets.only(left: _textL),
                  child: Text(studyplan.title,
                      style: TextStyle(fontSize: _titleSize)),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(left: _textL, top: _subtitleT),
                  child: Text(_studyPlanTime(index),
                      style: TextStyle(fontSize: _subtitleSize, color: _gray)),
                ),
                trailing:
                    _popupMenu(studyplan.creatorId, studyplan.studyplanNum),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
              );
            });
      }
    } else {
      groupStudyPlanList = Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: _color,
          title: Text('共同讀書計畫', style: TextStyle(fontSize: _appBarSize)),
          leading: Container(
            margin: EdgeInsets.only(left: _leadingL),
            child: GestureDetector(
              child: Icon(Icons.chevron_left),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShareStudyPlanPage(groupNum)));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Container(color: Colors.white, child: groupStudyPlanList));
  }
}
