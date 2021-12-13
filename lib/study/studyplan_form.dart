import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/study/select_note_page.dart';
import 'package:My_Day_app/public/studyplan_request/create_studyplan.dart';
import 'package:My_Day_app/public/studyplan_request/edit_studyplan.dart';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:flutter/services.dart';

class StudyPlanForm extends StatefulWidget {
  int studyplanNum;
  int groupNum;
  String submitType;
  String title;
  DateTime date;
  DateTime startDateTime;
  DateTime endDateTime;
  bool isAuthority;
  List<List> subjectTimeList = [];
  List subjectNameList = [];
  List remarkList = [];
  List noteNumList = [];
  List restList = [];
  bool isCreate;

  StudyPlanForm(
      {int studyplanNum,
      int groupNum,
      String submitType = 'create_studyplan',
      String title,
      DateTime date,
      DateTime startDateTime,
      DateTime endDateTime,
      bool isAuthority,
      List<List> subjectTimeList,
      List subjectNameList,
      List remarkList,
      List noteNumList,
      List restList,
      bool isCreate}) {
    this.studyplanNum = studyplanNum;
    this.groupNum = groupNum;
    this.submitType = submitType;
    this.title = title;
    this.date = date;
    this.startDateTime = startDateTime;
    this.endDateTime = endDateTime;
    this.isAuthority = isAuthority;
    this.subjectTimeList = subjectTimeList;
    this.subjectNameList = subjectNameList;
    this.remarkList = remarkList;
    this.noteNumList = noteNumList;
    this.restList = restList;
    this.isCreate = isCreate;
  }

  @override
  _StudyPlanForm createState() => new _StudyPlanForm(
      studyplanNum,
      groupNum,
      submitType,
      title,
      date,
      startDateTime,
      endDateTime,
      isAuthority,
      subjectTimeList,
      subjectNameList,
      remarkList,
      noteNumList,
      restList,
      isCreate);
}

class _StudyPlanForm extends State<StudyPlanForm> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);
  }

  int studyplanNum;
  int groupNum;

  String _title;
  String _value = '';
  String _submitType;
  Map _submitMap = {'create_studyplan': '新增', 'edit_studyplan': '編輯'};

  DateTime _date;
  DateTime _startDateTime;
  DateTime _endDateTime;
  bool _isAuthority = false;
  List<List> _subjectTimeList;
  List _subjectNameList;
  List _remarkList;
  List _noteNumList;
  List _restList;
  bool _isCreate;

  _StudyPlanForm(
      this.studyplanNum,
      this.groupNum,
      this._submitType,
      this._title,
      this._date,
      this._startDateTime,
      this._endDateTime,
      this._isAuthority,
      this._subjectTimeList,
      this._subjectNameList,
      this._remarkList,
      this._noteNumList,
      this._restList,
      this._isCreate);

  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  TextEditingController get _subjectNameController =>
      TextEditingController(text: _value);

  FocusNode _contentFocusNode = FocusNode();

  bool _addSubject = true;
  bool _isNotCreate = false;

  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _uid();
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listLR = _sizing.height(2);
    double _textFied = _sizing.height(4.5);
    double _borderRadius = _sizing.height(1);
    double _iconWidth = _sizing.width(5);
    double _leadingL = _sizing.height(2);
    double _bottomHeight = _sizing.height(7);

    double _pSize = _sizing.height(2.3);
    double _subtitleSize = _sizing.height(2);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);

    // values ------------------------------------------------------------------------------------------
    if (_date == null) _date = DateTime.now().add(Duration(days: 1));
    if (_startDateTime == null)
      _startDateTime = DateTime(_date.year, _date.month, _date.day, 8, 0);
    if (_endDateTime == null)
      _endDateTime = DateTime(_date.year, _date.month, _date.day, 10, 0);
    if (_subjectTimeList == null) {
      setState(() {
        _subjectTimeList = [];
        _subjectNameList = [];
        _remarkList = [];
        _noteNumList = [];
        _restList = [];
        _subjectTimeList
            .add([_startDateTime, _startDateTime.add(Duration(hours: 1))]);
        _subjectTimeList
            .add([_startDateTime.add(Duration(hours: 1)), _endDateTime]);
        for (int i = 0; i <= 1; i++) {
          _subjectNameList.add('');
          _remarkList.add(null);
          _noteNumList.add(null);
          _restList.add(false);
          _isCreate = false;
          _isAuthority = false;
        }
      });
    }

    String _dateView =
        '${_date.year.toString()}年${_date.month.toString().padLeft(2, '0')}月${_date.day.toString().padLeft(2, '0')}日';
    String _startTime =
        '${_startDateTime.hour.toString().padLeft(2, '0')}:${_startDateTime.minute.toString().padLeft(2, '0')}';
    String _endTime =
        '${_endDateTime.hour.toString().padLeft(2, '0')}:${_endDateTime.minute.toString().padLeft(2, '0')}';
    _titleController.text = _title;
    _dateController.text = _dateView;
    _startTimeController.text = _startTime;
    _endTimeController.text = _endTime;

    _submit() async {
      String _alertTitle = '${_submitMap[_submitType]}讀書計畫失敗';
      String scheduleName = _title;
      String scheduleStart = _startDateTime.toString();
      String scheduleEnd = _endDateTime.toString();
      bool isAuthority = _isAuthority;
      List<Map<String, dynamic>> subjects = [];
      for (int i = 0; i < _subjectTimeList.length; i++) {
        subjects.add({
          'subject': _subjectNameList[i],
          'plan_start': _subjectTimeList[i].first.toString(),
          'plan_end': _subjectTimeList[i].last.toString(),
          'remark': _remarkList[i],
          'note_no': _noteNumList[i],
          'is_rest': _restList[i]
        });
        if (_subjectNameList[i] == null || _subjectNameList[i] == '') {
          await alert(context, _alertTitle, '請輸入科目名稱');
          _isNotCreate = true;
        }
      }
      if (scheduleName == null || scheduleName == '') {
        await alert(context, _alertTitle, '請輸入標題');
        _isNotCreate = true;
      }
      if (_isNotCreate) {
        _isNotCreate = false;
        return true;
      } else {
        var submitWidget;
        _submitWidgetfunc() async {
          switch (_submitMap[_submitType]) {
            case '編輯':
              return EditStudyplan(
                  context: context,
                  uid: uid,
                  studyplanNum: studyplanNum,
                  scheduleName: scheduleName,
                  scheduleStart: scheduleStart,
                  scheduleEnd: scheduleEnd,
                  isAuthority: isAuthority,
                  subjects: subjects);
            case '新增':
              return CreateStudyplan(
                  context: context,
                  uid: uid,
                  scheduleNum: null,
                  scheduleName: scheduleName,
                  scheduleStart: scheduleStart,
                  scheduleEnd: scheduleEnd,
                  subjects: subjects);
          }
        }

        submitWidget = await _submitWidgetfunc();
        if (await submitWidget.getIsError())
          return true;
        else
          return false;
      }
    }

    void _datePicker(contex) {
      DateTime _dateTime = _date;
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _sizing.height(40),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    child: Text('確定', style: TextStyle(color: _color)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              Container(
                height: _sizing.height(28),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _dateTime,
                  onDateTimeChanged: (value) => setState(() {
                    _dateTime = value;
                    _date = _dateTime;
                    _startDateTime = DateTime(_date.year, _date.month,
                        _date.day, _startDateTime.hour, _startDateTime.minute);
                    _endDateTime = DateTime(_date.year, _date.month, _date.day,
                        _endDateTime.hour, _endDateTime.minute);
                    for (int i = 0; i < _subjectTimeList.length; i++) {
                      _subjectTimeList[i].first = DateTime(
                          _date.year,
                          _date.month,
                          _date.day,
                          _subjectTimeList[i].first.hour,
                          _subjectTimeList[i].first.minute);
                      _subjectTimeList[i].last = DateTime(
                          _date.year,
                          _date.month,
                          _date.day,
                          _subjectTimeList[i].last.hour,
                          _subjectTimeList[i].last.minute);
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }

    void _timePicker(contex, bool isStart) {
      DateTime _dateTime = isStart ? _startDateTime : _endDateTime;
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _sizing.height(40),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    child: Text('確定', style: TextStyle(color: _color)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              Container(
                height: _sizing.height(28),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  minimumDate:
                      (DateTime(_date.year, _date.month, _date.day, 0, 0)),
                  maximumDate:
                      (DateTime(_date.year, _date.month, _date.day, 24, 0)),
                  initialDateTime: _dateTime,
                  onDateTimeChanged: (value) => setState(() {
                    _dateTime = value;
                    if (isStart) {
                      if (_dateTime.isBefore(_subjectTimeList[0].last)) {
                        _startDateTime = _dateTime;
                        _subjectTimeList[0].first = _dateTime;
                      }
                    } else {
                      if (_dateTime.isAfter(
                          _subjectTimeList[_subjectTimeList.length - 1]
                              .first)) {
                        _endDateTime = _dateTime;
                        _subjectTimeList[_subjectTimeList.length - 1].last =
                            _dateTime;
                      }
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }

    void _subjectTimePicker(contex, int index, bool isStart) {
      DateTime _dateTime = isStart
          ? _subjectTimeList[index].first
          : _subjectTimeList[index].last;
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _sizing.height(40),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    child: Text('確定', style: TextStyle(color: _color)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        if (index == 0) {
                          if (isStart) {
                            _subjectTimeList[index].first = _dateTime;
                            _startDateTime = _dateTime;
                          } else {
                            _subjectTimeList[index].last = _dateTime;
                            _subjectTimeList[index + 1].first = _dateTime;
                          }
                        } else if (index == _subjectTimeList.length - 1) {
                          _subjectTimeList[index].last = _dateTime;
                          _endDateTime = _dateTime;
                        } else {
                          _subjectTimeList[index].last = _dateTime;
                          _subjectTimeList[index + 1].first = _dateTime;
                        }
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: _sizing.height(28),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  minimumDate:
                      (DateTime(_date.year, _date.month, _date.day, 0, 0)),
                  maximumDate:
                      (DateTime(_date.year, _date.month, _date.day, 24, 0)),
                  initialDateTime: _dateTime,
                  onDateTimeChanged: (value) => setState(() {
                    if (isStart && value.isBefore(_subjectTimeList[index].last))
                      _dateTime = value;
                    if (index == _subjectTimeList.length - 1 &&
                        value.isAfter(_subjectTimeList[index].first)) {
                      _dateTime = value;
                      if (_dateTime ==
                          (DateTime(_date.year, _date.month, _date.day, 24, 0)))
                        _addSubject = false;
                      else
                        _addSubject = true;
                    } else if (!isStart &&
                        value.isAfter(_subjectTimeList[index].first) &&
                        value.isBefore(_subjectTimeList[index].last)) {
                      _dateTime = value;
                      if (_dateTime ==
                          (DateTime(_date.year, _date.month, _date.day, 24, 0)))
                        _addSubject = false;
                      else
                        _addSubject = true;
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Future<String> remarkDialog(BuildContext context, int index) async {
      Sizing _sizing = Sizing(context);

      double _borderRadius = _sizing.height(3);
      double _textLBR = _sizing.height(2);
      double _textFied = _sizing.height(10);
      double _inkwellH = _sizing.height(6);

      double _pSize = _sizing.height(2.3);
      double _subtitleSize = _sizing.height(2);

      Color _bule = Color(0xff7AAAD8);
      Color _color = Theme.of(context).primaryColor;
      Color _light = Theme.of(context).primaryColorLight;

      final _remarkController = TextEditingController();
      _remarkController.text = _remarkList[index];

      return showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_borderRadius))),
              contentPadding: EdgeInsets.only(top: _sizing.height(2)),
              content: Container(
                width: _sizing.width(20),
                height: _sizing.height(23),
                child: GestureDetector(
                  // 點擊空白處釋放焦點
                  behavior: HitTestBehavior.translucent,
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            "備註",
                            style: TextStyle(fontSize: _pSize),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: _textLBR,
                              left: _textLBR,
                              right: _textLBR,
                              bottom: _sizing.height(1),
                            ),
                            height: _textFied,
                            child: TextField(
                              style: TextStyle(fontSize: _pSize),
                              maxLength: 30,
                              maxLines: null,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: _sizing.height(1),
                                      vertical: _sizing.height(1)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_sizing.height(1))),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_sizing.height(1))),
                                    borderSide: BorderSide(color: _bule),
                                  )),
                              controller: _remarkController,
                            ),
                          )
                        ],
                      )),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: _inkwellH,
                                padding: EdgeInsets.only(
                                    top: _sizing.height(1.5),
                                    bottom: _sizing.height(1.5)),
                                decoration: BoxDecoration(
                                  color: _light,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(_borderRadius),
                                  ),
                                ),
                                child: Text(
                                  "取消",
                                  style: TextStyle(
                                      fontSize: _subtitleSize,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: _inkwellH,
                                padding: EdgeInsets.only(
                                    top: _sizing.height(1.5),
                                    bottom: _sizing.height(1.5)),
                                decoration: BoxDecoration(
                                  color: _color,
                                  borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(_borderRadius)),
                                ),
                                child: Text(
                                  "確認",
                                  style: TextStyle(
                                      fontSize: _subtitleSize,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _remarkList[index] = _remarkController.text;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    Widget title = Container(
      margin: EdgeInsets.only(
        left: _listLR,
        bottom: _listLR,
        top: _sizing.height(1),
        right: _listLR,
      ),
      child: Row(
        children: [
          Text('標題：', style: TextStyle(fontSize: _pSize)),
          Flexible(
            child: Container(
              height: _textFied,
              child: TextField(
                style: TextStyle(fontSize: _pSize),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: _sizing.height(1),
                        vertical: _sizing.height(1)),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius)),
                      borderSide: BorderSide(color: _bule),
                    )),
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: _titleController.text,
                    // 保持光標在最後
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _titleController.text.length)))),
                onChanged: (text) {
                  setState(() {
                    _title = text;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );

    Widget date = Container(
      margin: EdgeInsets.only(
        left: _listLR,
        bottom: _listLR,
        top: _sizing.height(1),
        right: _listLR,
      ),
      child: Row(
        children: [
          Text('日期：', style: TextStyle(fontSize: _pSize)),
          Flexible(
            child: Container(
              height: _textFied,
              width: _sizing.width(40),
              child: TextField(
                  style: TextStyle(fontSize: _pSize),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: _sizing.height(1),
                          vertical: _sizing.height(1)),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                        borderSide: BorderSide(color: _bule),
                      )),
                  focusNode: _contentFocusNode,
                  controller: _dateController..text,
                  onTap: () {
                    _contentFocusNode.unfocus();
                    _datePicker(context);
                  }),
            ),
          ),
        ],
      ),
    );

    Widget time = Container(
      margin: EdgeInsets.only(
        left: _listLR,
        bottom: _listLR,
        top: _sizing.height(1),
        right: _listLR,
      ),
      child: Row(
        children: [
          Text('時間：', style: TextStyle(fontSize: _pSize)),
          Padding(
            padding: EdgeInsets.only(right: _sizing.width(1)),
            child: Container(
              height: _textFied,
              width: _sizing.width(17),
              child: TextField(
                  style: TextStyle(fontSize: _pSize),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: _sizing.height(1),
                          vertical: _sizing.height(1)),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                        borderSide: BorderSide(color: _bule),
                      )),
                  focusNode: _contentFocusNode,
                  controller: _startTimeController,
                  onTap: () {
                    _contentFocusNode.unfocus();
                    _timePicker(context, true);
                  }),
            ),
          ),
          Text('-', style: TextStyle(fontSize: _pSize)),
          Padding(
            padding: EdgeInsets.only(left: _sizing.width(1)),
            child: Container(
              height: _textFied,
              width: _sizing.width(17),
              child: TextField(
                  style: TextStyle(fontSize: _pSize),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: _sizing.height(1),
                          vertical: _sizing.height(1)),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                        borderSide: BorderSide(color: _bule),
                      )),
                  focusNode: _contentFocusNode,
                  controller: _endTimeController,
                  onTap: () {
                    _contentFocusNode.unfocus();
                    _timePicker(context, false);
                  }),
            ),
          ),
        ],
      ),
    );

    Widget authority = Container(
      margin: EdgeInsets.only(
        left: _listLR,
        bottom: _listLR,
        right: _listLR,
      ),
      child: Row(
        children: [
          Text('編輯權限：', style: TextStyle(fontSize: _pSize)),
          Radio(
            value: true,
            activeColor: _color,
            onChanged: (value) {
              setState(() {
                _isAuthority = value;
              });
            },
            groupValue: _isAuthority,
          ),
          Text('開', style: TextStyle(fontSize: _pSize)),
          SizedBox(
            width: _sizing.width(1),
          ),
          Radio(
            value: false,
            activeColor: _color,
            onChanged: (value) {
              setState(() {
                _isAuthority = value;
              });
            },
            groupValue: _isAuthority,
          ),
          Text('關', style: TextStyle(fontSize: _pSize)),
        ],
      ),
    );

    Widget subjectList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _subjectTimeList.length,
        itemBuilder: (BuildContext context, int index) {
          DateTime startTime = _subjectTimeList[index].first;
          DateTime endTime = _subjectTimeList[index].last;
          String startView =
              '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
          String endView =
              '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
          _value = _subjectNameList[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: _sizing.height(1), vertical: 0),
            leading: Container(
              margin: EdgeInsets.only(left: _sizing.height(1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                        child:
                            Text(startView, style: TextStyle(fontSize: _pSize)),
                        onTap: () {
                          if (index == 0)
                            _subjectTimePicker(context, index, true);
                        }),
                  ),
                  SizedBox(height: _sizing.height(1)),
                  Expanded(
                    child: InkWell(
                        child:
                            Text(endView, style: TextStyle(fontSize: _pSize)),
                        onTap: () => _subjectTimePicker(context, index, false)),
                  )
                ],
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: _sizing.height(1)),
                  height: _textFied,
                  child: TextField(
                    style: TextStyle(fontSize: _pSize),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _sizing.height(1),
                            vertical: _sizing.height(1)),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(_borderRadius)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(_borderRadius)),
                          borderSide: BorderSide(color: _bule),
                        )),
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            text: _subjectNameController.text,
                            // 保持光標在最後
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: _subjectNameController.text.length)))),
                    onChanged: (text) {
                      setState(() {
                        _subjectNameList[index] = text;
                        _endDateTime =
                            _subjectTimeList[_subjectTimeList.length - 1].last;
                      });
                    },
                  ),
                ),
                Container(
                  height: _sizing.height(3.8),
                  child: Row(
                    children: [
                      Text('休息：', style: TextStyle(fontSize: _subtitleSize)),
                      Radio(
                        value: false,
                        activeColor: _color,
                        onChanged: (value) {
                          setState(() {
                            _restList[index] = value;
                          });
                        },
                        groupValue: _restList[index],
                      ),
                      SizedBox(
                        width: _sizing.width(1),
                      ),
                      Text('否', style: TextStyle(fontSize: _subtitleSize)),
                      Radio(
                        value: true,
                        activeColor: _color,
                        onChanged: (value) {
                          setState(() {
                            _restList[index] = value;
                          });
                        },
                        groupValue: _restList[index],
                      ),
                      Text('是', style: TextStyle(fontSize: _subtitleSize)),
                    ],
                  ),
                ),
              ],
            ),
            trailing: PopupMenuButton(
              offset: Offset(-40, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_sizing.height(1))),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'remark',
                    child: Container(
                        alignment: Alignment.center,
                        child: Text("備註",
                            style: TextStyle(fontSize: _subtitleSize))),
                  ),
                  PopupMenuItem(
                    value: 'note',
                    child: Container(
                        alignment: Alignment.center,
                        child: Text("筆記",
                            style: TextStyle(fontSize: _subtitleSize))),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Container(
                        alignment: Alignment.center,
                        child: Text("刪除",
                            style: TextStyle(fontSize: _subtitleSize))),
                  ),
                ];
              },
              onSelected: (String value) async {
                switch (value) {
                  case 'remark':
                    await remarkDialog(context, index);
                    break;
                  case 'note':
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => SelectNotePage(
                                groupNum, _noteNumList[index], _isCreate)))
                        .then((value) => _noteNumList[index] = value);
                    break;
                  case 'delete':
                    if (_subjectTimeList.length > 1) {
                      setState(() {
                        _subjectTimeList.removeAt(index);
                        _subjectNameList.removeAt(index);
                        _remarkList.removeAt(index);
                        _noteNumList.removeAt(index);
                        _restList.removeAt(index);
                        _endDateTime =
                            _subjectTimeList[_subjectTimeList.length - 1].last;
                        _startDateTime = _subjectTimeList[0].first;
                        for (int i = 0; i < _subjectTimeList.length; i++) {
                          if (i != 0 && i != _subjectTimeList.length) {
                            _subjectTimeList[i].first =
                                _subjectTimeList[i - 1].last;
                          }
                        }
                      });
                    } else {
                      await alert(context, '錯誤', '至少需有一個行程');
                    }
                    break;
                }
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
          );
        });

    Widget addSubject = TextButton(
      style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            size: _iconWidth,
            color: _color,
          ),
          Text('新增', style: TextStyle(fontSize: _pSize, color: _color))
        ],
      ),
      onPressed: () {
        setState(() {
          DateTime _dateTime =
              _subjectTimeList[_subjectTimeList.length - 1].last;
          if (_dateTime
              .isBefore(DateTime(_date.year, _date.month, _date.day, 23, 0))) {
            _subjectTimeList
                .add([_dateTime, _dateTime.add(Duration(hours: 1))]);
            _subjectNameList.add('');
            _remarkList.add(null);
            _noteNumList.add(null);
            _restList.add(false);
          } else if (_dateTime
              .isBefore(DateTime(_date.year, _date.month, _date.day, 24, 0))) {
            _subjectTimeList.add([
              _dateTime,
              DateTime(_date.year, _date.month, _date.day, 24, 0)
            ]);
            _subjectNameList.add('');
            _remarkList.add(null);
            _noteNumList.add(null);
            _restList.add(false);
            _addSubject = false;
          }
          print(_dateTime);
        });
      },
    );

    return Container(
      color: _color,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title: Text('${_submitMap[_submitType]}讀書計畫',
                  style: TextStyle(fontSize: _appBarSize)),
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
            body: GestureDetector(
                // 點擊空白處釋放焦點
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Container(
                    color: Colors.white,
                    child: Container(
                      color: Colors.white,
                      child: ListView(
                        children: [
                          SizedBox(height: _sizing.height(2)),
                          title,
                          date,
                          time,
                          Visibility(visible: _isCreate, child: authority),
                          Divider(
                            height: 1,
                          ),
                          subjectList,
                          Divider(
                            height: 1,
                          ),
                          Visibility(visible: _addSubject, child: addSubject)
                        ],
                      ),
                    ))),
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
                              width: _iconWidth,
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
                              width: _iconWidth,
                            ),
                            fillColor: _color,
                            onPressed: () async {
                              if (await _submit() != true) {
                                Navigator.pop(context);
                              }
                            }),
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
