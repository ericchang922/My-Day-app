import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';

import 'package:My_Day_app/study/studyplan_detail_page.dart';
import 'package:My_Day_app/public/studyplan_request/cancel_sharing.dart';
import 'package:My_Day_app/public/studyplan_request/one_group_list.dart';
import 'package:My_Day_app/common_studyplan/share_studyplan_page.dart';
import 'package:My_Day_app/models/studyplan/common_studyplan_list_model.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';


class CommonStudyPlanListPage extends StatefulWidget {
  int groupNum;
  CommonStudyPlanListPage(this.groupNum);

  @override
  _CommonStudyPlanListWidget createState() =>
      new _CommonStudyPlanListWidget(groupNum);
}

class _CommonStudyPlanListWidget extends State<CommonStudyPlanListPage> {
  int groupNum;
  _CommonStudyPlanListWidget(this.groupNum);

  ShareStudyplanListModel _groupStudyplanListModel;

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _groupStudyplanListRequest();
  }

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _groupStudyplanListRequest() async {
    ShareStudyplanListModel _request =
        await OneGroupList(context: context, uid: uid, groupNum: groupNum)
            .getData();

    setState(() {
      _groupStudyplanListModel = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _heightSize = _sizing.height(1);
    double _widthSize = _sizing.width(1);
    double _leadingL = _sizing.height(2);
    double _textL = _sizing.height(3);
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
              borderRadius: BorderRadius.circular(_sizing.height(1))),
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
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => StudyplanDetailPage(
                                studyplan.studyplanNum,
                                typeId,
                                groupNum,
                                true)))
                        .then((value) => _groupStudyplanListRequest());
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
                                Text(studyplan.date.month.toString() + "月",
                                    style: TextStyle(fontSize: _subtitleSize)),
                                Text(studyplan.date.day.toString() + "日",
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
                                child: Text(studyplan.title,
                                    style: TextStyle(fontSize: _titleSize)),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: _textL, top: _subtitleT),
                                child: Text(_studyPlanTime(index, typeId),
                                    style: TextStyle(
                                        fontSize: _subtitleSize, color: _gray)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: _popupMenu(
                                studyplan.creatorId, studyplan.studyplanNum)),
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      ShareStudyPlanPage(groupNum)))
                              .then((value) => _groupStudyplanListRequest());
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
