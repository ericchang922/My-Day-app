import 'dart:convert';

import 'package:My_Day_app/models/get_common_schedule_model.dart';
import 'package:My_Day_app/schedule/create_schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class CommonScheduleEditPage extends StatefulWidget {
  int scheduleNum;
  CommonScheduleEditPage(this.scheduleNum);

  @override
  _CommonScheduleEditWidget createState() =>
      new _CommonScheduleEditWidget(scheduleNum);
}

class _CommonScheduleEditWidget extends State<CommonScheduleEditPage> {
  int scheduleNum;
  _CommonScheduleEditWidget(this.scheduleNum);

  GetCommonScheduleModel _getCommonScheduleModel = null;

  int _type;
  bool _allDay = false;
  String uid = 'lili123';
  String _title = "";
  String _place = "";
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(Duration(hours: 1));

  var _typeNameList = <String>['讀書', '工作', '會議', '休閒', '社團', '吃飯', '班級', '個人'];

  TextEditingController get _titleController =>
      TextEditingController(text: _title);
  TextEditingController get _locationController =>
      TextEditingController(text: _place);

  @override
  void initState() {
    super.initState();
    _getCommonScheduleRequest();
  }

  Future<void> _getCommonScheduleRequest() async {
    // var responseBody =
    //     await rootBundle.loadString('assets/json/get_common_schedule.json');

    var url = Uri.parse("http://myday.sytes.net/schedule/get_common/?uid=" +
        uid +
        "&scheduleNum=" +
        scheduleNum.toString());
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var responseBody = utf8.decode(response.bodyBytes);

    var jsonMap = json.decode(responseBody);

    var getCommonScheduleModel = GetCommonScheduleModel.fromJson(jsonMap);
    setState(() {
      _getCommonScheduleModel = getCommonScheduleModel;

      _title = _getCommonScheduleModel.title;
      _type = _typeNameList.indexOf(_getCommonScheduleModel.typeName) + 1;
      _startDateTime = _getCommonScheduleModel.startTime;
      _endDateTime = _getCommonScheduleModel.endTime;
      if (_getCommonScheduleModel.place != null)
        _place = _getCommonScheduleModel.place;

      String _startString =
          "${_startDateTime.hour.toString().padLeft(2, '0')}:${_startDateTime.minute.toString().padLeft(2, '0')}";
      String _endString =
          "${_endDateTime.hour.toString().padLeft(2, '0')}:${_endDateTime.minute.toString().padLeft(2, '0')}";
      if (_startString == "00:00" && _endString == "00:00") _allDay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double _height = size.height;
    double _width = size.width;
    double _bottomHeight = _height * 0.07;
    double _bottomIconWidth = _width * 0.05;
    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    double _paddingLR = _width * 0.06;
    double _listPaddingLR = _width * 0.1;
    double _listItemHeight = _height * 0.08;
    double _iconSize = _height * 0.05;
    double _h1Size = _height * 0.035;
    double _h2Size = _height * 0.03;
    double _pSize = _height * 0.025;
    double _timeSize = _width * 0.045;
    String _startView = _allDay
        ? '${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_startDateTime.weekday - 1]}'
        : '${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_startDateTime.weekday - 1]} ${_startDateTime.hour.toString().padLeft(2, '0')}:${_startDateTime.minute.toString().padLeft(2, '0')}';
    String _endView = _allDay
        ? '${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_endDateTime.weekday - 1]}'
        : '${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_endDateTime.weekday - 1]} ${_endDateTime.hour.toString().padLeft(2, '0')}:${_endDateTime.minute.toString().padLeft(2, '0')}';

    CupertinoDatePickerMode _mode() {
      if (_allDay)
        return CupertinoDatePickerMode.date;
      else
        return CupertinoDatePickerMode.dateAndTime;
    }

    dynamic getTypeColor(value) {
      dynamic color = value == null ? 0xffFFFFFF : typeColor[value - 1];
      return color;
    }

    // alert --------------------------------------------------------------------------------------------
    alert(String alertTitle, String alertTxt) async {
      return showDialog<String>(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_height * 0.03))),
          title: Text(alertTitle),
          content: Text(alertTxt),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('關閉', style: TextStyle(color: _color)),
            ),
          ],
        ),
      );
    }

    // conection ---------------------------------------------------------------------------------------
    Future<bool> _editSchedule(Map<String, dynamic> data) async {
      bool _isSubmit = false;
      var url = Uri.parse('http://myday.sytes.net/schedule/edit/');
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data));
      var responseBody = json.decode(utf8.decode(response.bodyBytes));
      print('statusCode: ${response.statusCode}');
      print('body: ${utf8.decode(response.bodyBytes)}');
      if (responseBody['response'] == false) {
        await alert('錯誤', responseBody['message']);
      } else if (responseBody['response'] == true) {
        Fluttertoast.showToast(
            msg: "編輯成功",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black45,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: size.height * 0.02);
        _isSubmit = true;
      }
      return _isSubmit;
    }

    // _submit -----------------------------------------------------------------------------------------
    Future<bool> _submit() async {
      String _alertTitle = '編輯行程失敗';
      bool _isNotCreate = false;
      bool _isSubmit = false;
      String title = _titleController.text;
      String startTime;
      String endTime;
      String startTimeString =
          '${_startDateTime.year.toString()}-${_startDateTime.month.toString().padLeft(2, '0')}-${_startDateTime.day.toString().padLeft(2, '0')} 00:00:00';
      String endTimeString =
          '${_endDateTime.year.toString()}-${_endDateTime.month.toString().padLeft(2, '0')}-${_endDateTime.day.toString().padLeft(2, '0')} 23:59:59';
      if (_allDay) {
        startTime = DateTime.parse(startTimeString).toString();
        endTime = DateTime.parse(endTimeString).toString();
      } else {
        startTime = _startDateTime.toString();
        endTime = _endDateTime.toString();
      }
      dynamic typeId = _type;
      String place = _locationController.text;

      if (uid == null) {
        await alert(_alertTitle, '請先登入');
        _isNotCreate = true;
        Navigator.pop(context);
        return false;
      }
      if (title == null || title == '') {
        await alert(_alertTitle, '請輸入標題');
        _isNotCreate = true;
        return false;
      }
      if (startTime == null || startTime == '') {
        await alert(_alertTitle, '請選擇開始時間');
        _isNotCreate = true;
        return false;
      }

      if (endTime == null || endTime == '') {
        await alert(_alertTitle, '請選擇結束時間');
        _isNotCreate = true;
        return false;
      }
      if (typeId == null || typeId <= 0 || typeId > 8) {
        await alert(_alertTitle, '請選擇類別');
        _isNotCreate = true;
        return false;
      }

      Map remind = {'isRemind': false, 'remindTime': []};

      Map<String, dynamic> request = {
        'uid': uid,
        'scheduleNum': scheduleNum,
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
        'remind': remind,
        'typeId': typeId,
        "isCountdown": false,
        'place': place,
        'remark': ""
      };
      if (_isNotCreate) {
        _isNotCreate = false;
        return false;
      } else {
        await _editSchedule(request).then((value) {
          _isSubmit = value;
        });
      }
      return _isSubmit;
    }

    void _datePicker(contex, isStart) {
      DateTime _dateTime;
      if (isStart)
        _dateTime = _startDateTime;
      else
        _dateTime = _endDateTime;
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _height * 0.35,
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
                height: _height * 0.28,
                child: CupertinoDatePicker(
                  mode: _mode(),
                  initialDateTime: _dateTime,
                  onDateTimeChanged: (value) => setState(() {
                    if (isStart)
                      _startDateTime = value;
                    else
                      _endDateTime = value;
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // createScheduleList ------------------------------------------------------------------------------
    Widget createScheduleList = ListView(
      children: [
        // text field ----------------------------------------------------------------------------- title
        Padding(
          padding: EdgeInsets.fromLTRB(
              _paddingLR, _height * 0.03, _paddingLR, _height * 0.02),
          child: TextField(
            style: TextStyle(fontSize: _h1Size),
            decoration: InputDecoration(
                hintText: '標題',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _color))),
            cursorColor: _color,
            controller: _titleController,
            onSubmitted: (_) => FocusScope.of(context)
                .requestFocus(FocusNode()), //按enter傳回空的focus
            onChanged: (text) {
              setState(() {
                _title = text;
              });
            },
          ),
        ),

        //  text ---------------------------------------------------------------------------------- time
        Padding(
          padding: EdgeInsets.fromLTRB(_paddingLR, 0, _paddingLR, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: Text('整天', style: TextStyle(fontSize: _pSize))),
                  Expanded(
                      flex: 1,
                      child: Align(
                        child: CupertinoSwitch(
                          activeColor: _color,
                          value: _allDay,
                          onChanged: (bool value) =>
                              setState(() => _allDay = value),
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // 開始-------------------------------------------------------
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(_paddingLR, 0, _paddingLR, 0),
                    child: Text(
                      '開始',
                      style: TextStyle(fontSize: _pSize),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      _startView,
                      style: TextStyle(
                          fontSize: _timeSize,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    style: ButtonStyle(alignment: Alignment.centerRight),
                    onPressed: () => _datePicker(context, true),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // 結束 ------------------------------------------------------
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(_paddingLR, 0, _paddingLR, 0),
                    child: Text(
                      '結束',
                      style: TextStyle(fontSize: _pSize),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      _endView,
                      style: TextStyle(
                          fontSize: _timeSize,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    style: ButtonStyle(alignment: Alignment.centerRight),
                    onPressed: () => _datePicker(context, false),
                  ),
                ],
              )
            ],
          ),
        ),

        // 分隔線
        Divider(
          height: _height * 0.02,
          indent: _paddingLR,
          endIndent: _paddingLR,
          color: Colors.grey,
          thickness: 0.5,
        ),

        // dropdown buttn ------------------------------------------------------------------------- type
        Padding(
          padding: EdgeInsets.fromLTRB(
              _listPaddingLR, size.height * 0.01, _listPaddingLR, 0),
          child: Container(
            height: _listItemHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/type.png',
                    height: _height * 0.05,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 7,
                  child: DropdownButton(
                    itemHeight: _height * 0.1,
                    hint: Text('類別',
                        style:
                            TextStyle(fontSize: _h2Size, color: Colors.grey)),
                    iconEnabledColor: Colors.grey,
                    underline: Container(),
                    focusColor: _color,
                    value: _type,
                    items: [
                      DropdownMenuItem(
                          child:
                              Text('讀書', style: TextStyle(fontSize: _h2Size)),
                          value: 1),
                      DropdownMenuItem(
                          child:
                              Text('工作', style: TextStyle(fontSize: _h2Size)),
                          value: 2),
                      DropdownMenuItem(
                          child:
                              Text('會議', style: TextStyle(fontSize: _h2Size)),
                          value: 3),
                      DropdownMenuItem(
                          child:
                              Text('休閒', style: TextStyle(fontSize: _h2Size)),
                          value: 4),
                      DropdownMenuItem(
                          child:
                              Text('社團', style: TextStyle(fontSize: _h2Size)),
                          value: 5),
                      DropdownMenuItem(
                          child:
                              Text('吃飯', style: TextStyle(fontSize: _h2Size)),
                          value: 6),
                      DropdownMenuItem(
                          child:
                              Text('班級', style: TextStyle(fontSize: _h2Size)),
                          value: 7),
                      DropdownMenuItem(
                          child:
                              Text('個人', style: TextStyle(fontSize: _h2Size)),
                          value: 8),
                    ],
                    onChanged: (int value) {
                      setState(() => _type = value);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: _height * 0.025,
                      child: CircleAvatar(
                        radius: _height * 0.025,
                        backgroundColor: Color(getTypeColor(_type)),
                      )),
                )
              ],
            ),
          ),
        ),

        // text field ----------------------------------------------------------------------------- location
        Padding(
          padding: EdgeInsets.fromLTRB(_listPaddingLR, 0, _listPaddingLR, 0),
          child: Container(
            height: _listItemHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/location.png',
                    height: _iconSize,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 8,
                  child: TextField(
                    controller: _locationController,
                    style: TextStyle(fontSize: _h2Size),
                    decoration: InputDecoration(
                      hintText: '地點',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _color)),
                    ),
                    cursorColor: _color,
                    onSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    onChanged: (text) {
                      setState(() {
                        _place = text;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      body: GestureDetector(
        // 點擊空白處釋放焦點
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: Center(child: createScheduleList),
          ),
        ),
      ),
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
                    onPressed: () async {
                      _submit().then((value) {
                        if (value == true) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
