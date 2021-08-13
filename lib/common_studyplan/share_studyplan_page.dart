import 'dart:convert';

import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/models/study_plan/study_plan_list_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShareStudyPlanPage extends StatefulWidget {
  int groupNum;
  ShareStudyPlanPage(this.groupNum);

  @override
  _ShareStudyPlanWidget createState() => new _ShareStudyPlanWidget(groupNum);
}

class _ShareStudyPlanWidget extends State<ShareStudyPlanPage> {
  int groupNum;
  _ShareStudyPlanWidget(this.groupNum);

  StudyPlanListModel _shareStudyPlanModel = null;

  List _studyplanCheck = [];

  bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _shareStudyPlanRequest();
    _buttonIsOnpressed();
  }

  _buttonIsOnpressed() {
    int count = 0;
    for (int i = 0; i < _studyplanCheck.length; i++) {
      if (_studyplanCheck[i] == true) {
        count++;
      }
    }
    if (count != 0) {
      setState(() {
        _isEnabled = true;
      });
    } else {
      setState(() {
        _isEnabled = false;
      });
    }
  }

  Future<void> _shareStudyPlanRequest() async {
    var jsonString =
        await rootBundle.loadString('assets/json/studyplan_list.json');

    // var httpClient = HttpClient();
    // var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
    //     '/vote/get_end_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    // var response = await request.close();
    // var jsonString = await response.transform(utf8.decoder).join();
    // httpClient.close();

    var jsonMap = json.decode(jsonString);

    var shareStudyPlanModel = StudyPlanListModel.fromJson(jsonMap);
    setState(() {
      _shareStudyPlanModel = shareStudyPlanModel;
      for (int i = 0; i < _shareStudyPlanModel.studyplan.length; i++) {
        _studyplanCheck.add(false);
      }
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
              title: Text('選擇讀書計畫',
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
            ),
            body: Container(color: Colors.white, child: _buildShareGroupStudyPlanListWidget(context))
            ));
  }

  int _studyplanCount() {
    int _studyplanCount = 0;
    for (int i = 0; i < _studyplanCheck.length; i++) {
      if (_studyplanCheck[i] == true) {
        _studyplanCount++;
      }
    }
    return _studyplanCount;
  }

  Widget _buildShareGroupStudyPlanListWidget(BuildContext context){
    return Column(
      children: [
        Expanded(child: _buildShareGroupStudyPlanList(context)),
        _buildCheckButtom(context)
      ]);
  }

  Widget _buildShareGroupStudyPlanList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    String _studyPlanTime(index) {
      var studyplan = _shareStudyPlanModel.studyplan[index];

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

    if (_shareStudyPlanModel != null) {
      if (_shareStudyPlanModel.studyplan.length == 0) {
        return Container(
          alignment: Alignment.center,
          child: Text('目前沒有任何共同讀書計畫!',
              style: TextStyle(fontSize: screenSize.width * 0.03)),
        );
      } else {
        return ListView.separated(
            itemCount: _shareStudyPlanModel.studyplan.length,
            itemBuilder: (BuildContext context, int index) {
              var studyplan = _shareStudyPlanModel.studyplan[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.height * 0.03,
                    vertical: screenSize.height * 0.01),
                leading: Column(
                  children: [
                    Text(studyplan.date.month.toString() + "月",
                        style: TextStyle(fontSize: screenSize.width * 0.035)),
                    Text(studyplan.date.day.toString() + "日",
                        style: TextStyle(fontSize: screenSize.width * 0.046)),
                  ],
                ),
                title: Container(
                  margin: EdgeInsets.only(left: screenSize.height * 0.025),
                  child: Text(studyplan.title,
                      style: TextStyle(fontSize: screenSize.width * 0.052)),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(
                      left: screenSize.height * 0.025,
                      top: screenSize.height * 0.007),
                  child: Text(_studyPlanTime(index),
                      style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: Color(0xff959595))),
                ),
                trailing: CustomerCheckBox(
                  value: _studyplanCheck[index],
                  onTap: (value) {
                    if (value == true) {
                      if (_studyplanCount() == 0) {
                        _studyplanCheck[index] = value;
                      }
                    } else {
                      _studyplanCheck[index] = value;
                    }
                    _buttonIsOnpressed();
                  },
                ),
                onTap: () {
                  setState(() {
                    if (_studyplanCheck[index] == false) {
                      _studyplanCheck[index] = true;
                    } else {
                      _studyplanCheck[index] = false;
                    }
                  });
                  _buttonIsOnpressed();
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
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildCheckButtom(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var _onPressed;
    if (_isEnabled == true) {
      _onPressed = () {
        int index = _studyplanCheck.indexOf(true);
        print(_shareStudyPlanModel.studyplan[index].studyplanNum);
      };
    }
    return Row(children: <Widget>[
      Expanded(
        // ignore: deprecated_member_use
        child: FlatButton(
          height: screenSize.height * 0.07,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Image.asset(
            'assets/images/cancel.png',
            width: screenSize.width * 0.05,
          ),
          color: Theme.of(context).primaryColorLight,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      Expanded(
          // ignore: deprecated_member_use
          child: Builder(builder: (context) {
        return FlatButton(
            disabledColor: Color(0xffCCCCCC),
            height: screenSize.height * 0.07,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Image.asset(
              'assets/images/confirm.png',
              width: screenSize.width * 0.05,
            ),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: _onPressed);
      }))
    ]);
  }
}
