import 'dart:convert';

import 'package:My_Day_app/common_studyplan/share_studyplan_page.dart';
import 'package:My_Day_app/models/study_plan_list_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  StudyPlanListModel _groupStudyPlanListModel = null;

  @override
  void initState() {
    super.initState();
    _groupStudyPlanListtRequest();
  }

  Future<void> _groupStudyPlanListtRequest() async {
    var jsonString =
        await rootBundle.loadString('assets/json/studyplan_list.json');

    // var httpClient = HttpClient();
    // var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
    //     '/vote/get_end_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    // var response = await request.close();
    // var jsonString = await response.transform(utf8.decoder).join();
    // httpClient.close();

    var jsonMap = json.decode(jsonString);

    var groupStudyPlanListModel = StudyPlanListModel.fromJson(jsonMap);
    setState(() {
      _groupStudyPlanListModel = groupStudyPlanListModel;
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
            title: Text('共同讀書計畫',
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
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShareStudyPlanPage(groupNum)));
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          body: _buildGroupStudyPlanList(context)),
    );
  }

  Widget _buildGroupStudyPlanList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    String _studyPlanTime(index) {
      var studyplan = _groupStudyPlanListModel.studyplan[index];

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

    if (_groupStudyPlanListModel != null) {
      if (_groupStudyPlanListModel.studyplan.length == 0) {
        return Container(
          alignment: Alignment.center,
          child: Text('目前沒有任何共同讀書計畫!',
              style: TextStyle(fontSize: screenSize.width * 0.03)),
        );
      } else {
        return ListView.separated(
            itemCount: _groupStudyPlanListModel.studyplan.length,
            itemBuilder: (BuildContext context, int index) {
              var studyplan = _groupStudyPlanListModel.studyplan[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.height * 0.01,
                    vertical: screenSize.height * 0.01),
                leading: Container(
                    margin: EdgeInsets.only(left: screenSize.height * 0.02),
                    child: Column(
                      children: [
                        Text(studyplan.date.month.toString() + "月",
                            style:
                                TextStyle(fontSize: screenSize.width * 0.035)),
                        Text(studyplan.date.day.toString() + "日",
                            style:
                                TextStyle(fontSize: screenSize.width * 0.046)),
                      ],
                    )),
                title: Container(
                  margin: EdgeInsets.only(left: screenSize.height * 0.03),
                  child: Text(studyplan.title,
                      style: TextStyle(fontSize: screenSize.width * 0.052)),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(
                      left: screenSize.height * 0.03,
                      top: screenSize.height * 0.007),
                  child: Text(_studyPlanTime(index),
                      style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: Color(0xff959595))),
                ),
                trailing: PopupMenuButton(
                  offset: Offset(-40, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenSize.height * 0.01)),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text("取消分享",
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.035))),
                      ),
                    ];
                  },
                  onSelected: (int value) {
                    print(studyplan.studyplanNum);
                  },
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
      return Center(child: CircularProgressIndicator());
    }
  }
}
