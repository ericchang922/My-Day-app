import 'package:My_Day_app/common_studyplan/studyplan_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/public/studyplan_request/cancel_sharing.dart';
import 'package:My_Day_app/public/studyplan_request/one_group_list.dart';
import 'package:My_Day_app/common_studyplan/share_studyplan_page.dart';
import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/studyplan/common_studyplan_list_model.dart';
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
    //     await rootBundle.loadString('assets/json/common_studyplan_list.json');
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
    Color _lightGray = Color(0xffE3E3E3);
    Color _yellow = Color(0xffEFB208);

    Widget noStudyplan = Center(child: Text('目前沒有任何共同讀書計畫!'));

    _submitCancel(int studyplanNum) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return CancelSharing(uid: uid, studyplanNum: studyplanNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    String _studyPlanTime(index, int typeId) {
      var studyplan;
      if (typeId == 0)
        studyplan = _groupStudyplanListModel.futureStudyplan[index];
      else
        studyplan = _groupStudyplanListModel.pastStudyplan[index];

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

    _studyplanList(int typeId) {
      var itemCount;

      if (_groupStudyplanListModel != null) {
        if (typeId == 0)
          itemCount = _groupStudyplanListModel.futureStudyplan.length;
        else
          itemCount = _groupStudyplanListModel.pastStudyplan.length;

        if (itemCount == 0) {
          return noStudyplan;
        } else {
          return ListView.separated(
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
                var studyplan;
                if (typeId == 0)
                  studyplan = _groupStudyplanListModel.futureStudyplan[index];
                else
                  studyplan = _groupStudyplanListModel.pastStudyplan[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: _heightSize, vertical: _heightSize),
                  leading: SizedBox(
                    width: _width * 0.17,
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
                    child: Text(_studyPlanTime(index, typeId),
                        style:
                            TextStyle(fontSize: _subtitleSize, color: _gray)),
                  ),
                  trailing:
                      _popupMenu(studyplan.creatorId, studyplan.studyplanNum),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            StudyplanDetailPage(studyplan.studyplanNum, typeId)));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                );
              });
        }
      } else {
        return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()));
      }
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
                  title:
                      Text('共同讀書計畫', style: TextStyle(fontSize: _appBarSize)),
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
                              builder: (context) =>
                                  ShareStudyPlanPage(groupNum)));
                        },
                        icon: Icon(Icons.add))
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
                    indicatorWeight: _widthSize,
                    labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    tabs: <Widget>[
                      Container(
                        height: _tabH,
                        alignment: Alignment.center,
                        color: _color,
                        child:
                            Text("未結束", style: TextStyle(fontSize: _tabSize)),
                      ),
                      Container(
                        height: _tabH,
                        alignment: Alignment.center,
                        color: _color,
                        child:
                            Text("已結束", style: TextStyle(fontSize: _tabSize)),
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
                  ],
                )),
          ),
        ));
  }
}
