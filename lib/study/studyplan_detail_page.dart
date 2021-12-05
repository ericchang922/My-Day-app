import 'package:My_Day_app/common_note/common_note_detail_page.dart';
import 'package:My_Day_app/common_studyplan/customer_check_box_studyplan.dart';
import 'package:My_Day_app/study/edit_studyplan_page.dart';
import 'package:My_Day_app/models/studyplan/studyplan_model.dart';
import 'package:My_Day_app/public/studyplan_request/cancel_sharing.dart';
import 'package:My_Day_app/public/studyplan_request/delete.dart';
import 'package:My_Day_app/public/studyplan_request/get.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudyplanDetailPage extends StatefulWidget {
  int studyplanNum;
  int typeId;
  int groupNum;
  bool isCommon;
  StudyplanDetailPage(
      this.studyplanNum, this.typeId, this.groupNum, this.isCommon);

  @override
  _StudyplanDetailPage createState() =>
      new _StudyplanDetailPage(studyplanNum, typeId, groupNum, isCommon);
}

class _StudyplanDetailPage extends State<StudyplanDetailPage> {
  int studyplanNum;
  int typeId;
  int groupNum;
  bool isCommon;
  _StudyplanDetailPage(
      this.studyplanNum, this.typeId, this.groupNum, this.isCommon);

  StudyplanModel _getStudyplan;

  String uid = 'lili123';
  List _check = [];

  bool _showTimeString = false;

  double _subjectListHeight = 0;

  final GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getStudyplanRequest();
  }

  _getStudyplanRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/get_studyplan.json');
    // var responseBody = json.decode(response);
    // var _request = StudyplanModel.fromJson(responseBody);

    StudyplanModel _request =
        await Get(uid: uid, studyplanNum: studyplanNum).getData();

    setState(() {
      _getStudyplan = _request;
      for (int i = 0; i < _getStudyplan.subject.length; i++) {
        _check.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _leadingL = _height * 0.02;
    double _timeHeight =
        _showTimeString == true ? _subjectListHeight - _height * 0.06 : 0;

    double _endTimeHeight =
        _showTimeString == true ? _subjectListHeight - _height * 0.025 : 0;

    double _appBarSize = _width * 0.058;
    double _titleSize = _height * 0.025;
    double _pSize = _height * 0.023;
    double _subtitleSize = _height * 0.02;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).accentColor;
    Color _bule = Color(0xff7AAAD8);
    Color _darkGrey = Color(0xff999999);

    if (_getStudyplan != null) {
      String _date =
          '${_getStudyplan.date.year.toString()}年${_getStudyplan.date.month.toString().padLeft(2, '0')}月${_getStudyplan.date.day.toString().padLeft(2, '0')}日';
      String _time =
          '${_getStudyplan.startTime.hour.toString().padLeft(2, '0')}:${_getStudyplan.startTime.minute.toString().padLeft(2, '0')} - ${_getStudyplan.endTime.hour.toString().padLeft(2, '0')}:${_getStudyplan.endTime.minute.toString().padLeft(2, '0')}';

      Widget _timeWidget = Container(
        margin: EdgeInsets.all(_width * 0.01),
        height: _height * 0.05,
        width: _width,
        child: Center(
            child: Text(
          _time,
          style: TextStyle(color: Colors.white, fontSize: _pSize),
        )),
        decoration: BoxDecoration(
            color: _light, borderRadius: BorderRadius.circular(_height * 0.01)),
      );

      double _subjectMargin = _showTimeString == true ? _height * 0.04 : 0;

      _submitCancelSharing() async {
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

      _submitDelete() async {
        var submitWidget;
        _submitWidgetfunc() async {
          return Delete(uid: uid, studyplanNum: studyplanNum);
        }

        submitWidget = await _submitWidgetfunc();
        if (await submitWidget.getIsError())
          return true;
        else
          return false;
      }

      _selectedItem(BuildContext context, value) async {
        switch (value) {
          case 'edit':
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) =>
                        EditStudyPlanPage(studyplanNum, null)))
                .then((value) => _getStudyplanRequest());
            break;
          case 'edit_common':
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) =>
                        EditStudyPlanPage(studyplanNum, groupNum)))
                .then((value) => _getStudyplanRequest());
            break;
          case 'cancel':
            if (await _submitCancelSharing() != true) {
              Navigator.pop(context);
            }
            break;
          case 'delete':
            if (await _submitDelete() != true) {
              Navigator.pop(context);
            }
            break;
        }
      }

      _studyplanAction() {
        if (isCommon == true && uid == _getStudyplan.creatorId) {
          return PopupMenuButton<String>(
            offset: Offset(50, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_height * 0.01)),
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                  value: 'edit_common',
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("編輯",
                          style: TextStyle(fontSize: _subtitleSize)))),
              PopupMenuDivider(
                height: 1,
              ),
              PopupMenuItem<String>(
                  value: 'cancel',
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("取消分享",
                          style: TextStyle(fontSize: _subtitleSize)))),
            ],
            onSelected: (value) => _selectedItem(context, value),
          );
        } else if (isCommon == false) {
          return PopupMenuButton<String>(
            offset: Offset(50, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_height * 0.01)),
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                  value: 'edit',
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("編輯",
                          style: TextStyle(fontSize: _subtitleSize)))),
              PopupMenuDivider(
                height: 1,
              ),
              PopupMenuItem<String>(
                  value: 'delete',
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("刪除",
                          style: TextStyle(fontSize: _subtitleSize)))),
            ],
            onSelected: (value) => _selectedItem(context, value),
          );
        } else if (_getStudyplan.isAuthority) {
          return PopupMenuButton<String>(
            offset: Offset(50, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_height * 0.01)),
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                  value: 'edit_common',
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("編輯",
                          style: TextStyle(fontSize: _subtitleSize)))),
            ],
            onSelected: (value) => _selectedItem(context, value),
          );
        } else {
          return Container();
        }
      }

      _subjectWidget(
          {int index, bool isRest, String name, String remark, int noteNum}) {
        bool _isNote = noteNum == null ? false : true;
        Widget leading;
        if (typeId == 0) {
          leading = CheckBoxStudyplan(
            value: _check[index],
            onTap: (value) {
              setState(() {
                _check[index] = value;
              });
            },
          );
        } else {
          leading = Container(
              width: _width * 0.08,
              height: _width * 0.08,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: _darkGrey),
                  color: _darkGrey,
                  borderRadius: BorderRadius.circular(_height * 0.01)),
              child: Icon(
                Icons.check,
                size: _width * 0.06,
                color: Colors.white,
              ));
        }

        if (isRest == false && remark != "") {
          return Container(
            margin: EdgeInsets.only(left: _subjectMargin),
            child: ListTile(
              title: Text(name, style: TextStyle(fontSize: _titleSize)),
              subtitle: Text(
                remark,
                style: TextStyle(fontSize: _subtitleSize),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              leading: leading,
              trailing: Visibility(
                visible: _isNote,
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/note.png',
                    height: _width * 1,
                  ),
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => CommonNoteDetailPage(noteNum)))
                      .then((value) => _getStudyplanRequest()),
                ),
              ),
            ),
          );
        } else if (isRest == false && remark == "") {
          return Container(
            margin: EdgeInsets.only(left: _subjectMargin),
            child: ListTile(
                title: Text(name, style: TextStyle(fontSize: _titleSize)),
                leading: leading,
                trailing: Visibility(
                  visible: _isNote,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/note.png',
                      height: _width * 1,
                    ),
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) =>
                                CommonNoteDetailPage(noteNum)))
                        .then((value) => _getStudyplanRequest()),
                  ),
                )),
          );
        } else {
          return Container(
            height: _height * 0.04,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: _subjectMargin),
            child: Text(
              name,
              style: TextStyle(fontSize: _titleSize),
            ),
          );
        }
      }

      Widget _subjectList = ListView.separated(
          key: globalKey,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _getStudyplan.subject.length,
          itemBuilder: (BuildContext context, int index) {
            var _subject = _getStudyplan.subject[index];
            String _remark = _subject.remark == null ? "" : _subject.remark;
            return _subjectWidget(
                index: index,
                isRest: _subject.rest,
                name: _subject.subjectName,
                remark: _remark,
                noteNum: _subject.noteNum);
          },
          separatorBuilder: (context, index) {
            var _subject = _getStudyplan.subject[index];
            String _time = _showTimeString == true
                ? '${_subject.subjectEnd.hour.toString().padLeft(2, '0')}:${_subject.subjectEnd.minute.toString().padLeft(2, '0')}'
                : '';
            return Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: _width * 0.01),
                    child: Text(_time)),
                Expanded(
                  child: Divider(
                    height: 1,
                  ),
                ),
              ],
            );
          });

      Widget _studyplan = Column(
        children: [
          _timeWidget,
          Container(
            child: Expanded(
                child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: _height * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            child: Container(
                              width: _height * 0.015,
                              height: _height * 0.06,
                              color: _bule,
                            ),
                            onTap: () {
                              setState(() {
                                if (_showTimeString == false)
                                  _showTimeString = true;
                                else
                                  _showTimeString = false;
                                _subjectListHeight =
                                    globalKey.currentContext.size.height;
                              });
                            },
                          ),
                          Container(
                            width: _height * 0.015,
                            height: _timeHeight,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: _bule)),
                          )
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Visibility(
                              visible: _showTimeString,
                              child: Container(
                                  margin: EdgeInsets.only(left: _height * 0.01),
                                  child: Text(
                                      "${'${_getStudyplan.subject[0].subjectStart.hour.toString().padLeft(2, '0')}:${_getStudyplan.subject[0].subjectStart.minute.toString().padLeft(2, '0')}'}")),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: _height * 0.01),
                                child: _subjectList),
                            Visibility(
                              visible: _showTimeString,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: _height * 0.01,
                                      top: _endTimeHeight),
                                  child: Text(
                                      "${'${_getStudyplan.subject[_getStudyplan.subject.length - 1].subjectEnd.hour.toString().padLeft(2, '0')}:${_getStudyplan.subject[_getStudyplan.subject.length - 1].subjectEnd.minute.toString().padLeft(2, '0')}'}")),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          )
        ],
      );

      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                toolbarHeight: _height * 0.11,
                backgroundColor: _color,
                title: Container(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                        text: _getStudyplan.title + '\n',
                        style: TextStyle(
                          fontSize: _appBarSize,
                        ),
                        children: <WidgetSpan>[
                          WidgetSpan(
                              child: Container(
                            padding: EdgeInsets.only(top: _height * 0.004),
                            child: Text(_date,
                                style: TextStyle(
                                    fontSize: _pSize,
                                    fontWeight: FontWeight.normal)),
                          )),
                        ]),
                  ),
                ),
                actions: [
                  Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: _height * 0.01),
                      child: _studyplanAction())
                ],
                leading: Container(
                  alignment: Alignment.topCenter,
                  margin:
                      EdgeInsets.only(left: _leadingL, top: _height * 0.022),
                  child: GestureDetector(
                    child: Icon(Icons.chevron_left),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              body: Container(
                  color: Colors.white,
                  child: SafeArea(top: false, child: _studyplan))),
        ),
      );
    } else {
      return Container(
          color: Colors.white,
          child: SafeArea(child: Center(child: CircularProgressIndicator())));
    }
  }
}
