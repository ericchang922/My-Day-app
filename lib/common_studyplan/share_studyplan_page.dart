import 'package:flutter/material.dart';

import 'package:My_Day_app/public/studyplan_request/sharing.dart';
import 'package:My_Day_app/public/studyplan_request/personal_share_list.dart';
import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/models/study_plan/personal_share_studyplan.dart';
import 'package:date_format/date_format.dart';

class ShareStudyPlanPage extends StatefulWidget {
  int groupNum;
  ShareStudyPlanPage(this.groupNum);

  @override
  _ShareStudyPlanWidget createState() => new _ShareStudyPlanWidget(groupNum);
}

class _ShareStudyPlanWidget extends State<ShareStudyPlanPage> {
  int groupNum;
  _ShareStudyPlanWidget(this.groupNum);

  PersonalShareStudyplanListModel _personalShareStudyPlanModel;

  String uid = 'lili123';
  int studyplanNum;
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

  _shareStudyPlanRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/personal_share_studyplan_list.json');
    // var responseBody = json.decode(response);
    // var _request = ShareStudyplanListModel.fromJson(responseBody);

    PersonalShareStudyplanListModel _request =
        await PersonalShareList(uid: uid, shareStatus: 0).getData();

    setState(() {
      _personalShareStudyPlanModel = _request;
      for (int i = 0; i < _personalShareStudyPlanModel.studyplan.length; i++) {
        _studyplanCheck.add(false);
      }
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
    double _bottomHeight = _height * 0.07;
    double _bottomIconWidth = _width * 0.05;

    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _gray = Color(0xff959595);
    Color _hintGray = Color(0xffCCCCCC);

    Widget noStudyplan = Center(child: Text('目前沒有任何讀書計畫!'));
    Widget studyPlanList;

    _submitSharing(int studyplanNum) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return Sharing(
            uid: uid, studyplanNum: studyplanNum, groupNum: groupNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    String _studyPlanTime(index) {
      var studyplan = _personalShareStudyPlanModel.studyplan[index];

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

    int _studyplanCount() {
      int _studyplanCount = 0;
      for (int i = 0; i < _studyplanCheck.length; i++) {
        if (_studyplanCheck[i] == true) {
          _studyplanCount++;
        }
      }
      return _studyplanCount;
    }

    if (_personalShareStudyPlanModel != null) {
      if (_personalShareStudyPlanModel.studyplan.length == 0) {
        studyPlanList = noStudyplan;
      } else {
        studyPlanList = ListView.separated(
            itemCount: _personalShareStudyPlanModel.studyplan.length,
            itemBuilder: (BuildContext context, int index) {
              var studyplan = _personalShareStudyPlanModel.studyplan[index];
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
                trailing: Container(
                  margin: EdgeInsets.only(right: _height * 0.02),
                  child: CustomerCheckBox(
                    value: _studyplanCheck[index],
                    onTap: (value) {
                      setState(() {
                        if (value == true) {
                          if (_studyplanCount() < 1) {
                            _studyplanCheck[index] = value;
                            studyplanNum = studyplan.studyplanNum;
                          }
                        } else {
                          _studyplanCheck[index] = value;
                        }
                      });
                      _buttonIsOnpressed();
                    },
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (_studyplanCheck[index] == false) {
                      if (_studyplanCount() < 1) {
                        _studyplanCheck[index] = true;
                        studyplanNum = studyplan.studyplanNum;
                      }
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
      studyPlanList = Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()));
    }

    _onPressed() {
      var _onPressed;

      if (_isEnabled == true) {
        _onPressed = () async {
          if (await _submitSharing(studyplanNum) != true) {
            Navigator.pop(context);
          }
        };
      }
      return _onPressed;
    }

    return Container(
      color: _color,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text('選擇讀書計畫', style: TextStyle(fontSize: _appBarSize)),
              leading: Container(
                margin: EdgeInsets.only(left: _leadingL),
                child: GestureDetector(
                  child: Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            body: Container(color: Colors.white, child: studyPlanList),
            bottomNavigationBar: Container(
              color: Theme.of(context).bottomAppBarColor,
              child: SafeArea(
                top: false,
                child: BottomAppBar(
                  elevation: 0,
                  child: Row(children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: _bottomHeight,
                        child: RawMaterialButton(
                            elevation: 0,
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: _bottomIconWidth,
                            ),
                            fillColor: _light,
                            onPressed: () => Navigator.pop(context)),
                      ),
                    ), // 取消按鈕
                    Expanded(
                      child: SizedBox(
                        height: _bottomHeight,
                        child: RawMaterialButton(
                            elevation: 0,
                            child: Image.asset(
                              'assets/images/confirm.png',
                              width: _bottomIconWidth,
                            ),
                            fillColor: _color,
                            onPressed: _onPressed()),
                      ),
                    )
                  ]),
                ),
              ),
            )),
      ),
    );
  }
}
