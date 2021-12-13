// flutter
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// therd
import 'package:localstorage/localstorage.dart';
// my day
import 'package:My_Day_app/schedule/remind_item.dart';
import 'package:My_Day_app/home/home_page_functions.dart';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/schedule_request/create_new.dart';
import 'package:My_Day_app/public/schedule_request/edit.dart';
import 'package:My_Day_app/public/schedule_request/get_list.dart';
import 'package:My_Day_app/public/convert.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/type_color.dart';
import 'package:My_Day_app/public/sizing.dart';

List<String> weekdayName = ['週一', '週二', '週三', '週四', '週五', '週六', '週日'];

class ScheduleForm extends StatefulWidget {
  String submitType;
  int scheduleNum;
  String title;
  DateTime startDateTime;
  DateTime endDateTime;
  int type;
  String location;
  List remindTimeList;
  bool isCountdown;
  String remark;

  ScheduleForm({
    String submitType = 'create_new',
    int scheduleNum,
    String title,
    DateTime startDateTime,
    DateTime endDateTime,
    int type,
    String location,
    List remindTimeList,
    bool isCountdown = false,
    String remark,
  }) {
    this.submitType = submitType;
    this.scheduleNum = scheduleNum;
    this.title = title;
    this.startDateTime = startDateTime;
    this.endDateTime = endDateTime;
    this.type = type;
    this.location = location;
    this.remindTimeList = remindTimeList;
    this.isCountdown = isCountdown;
    this.remark = remark;
  }

  @override
  State<ScheduleForm> createState() => _ScheduleForm(
      submitType,
      scheduleNum,
      title,
      startDateTime,
      endDateTime,
      type,
      location,
      remindTimeList,
      isCountdown,
      remark);
}

class _ScheduleForm extends State<ScheduleForm> {
  String _uid;
  _uidLoad() async {
    String id = await loadUid();
    setState(() => _uid = id);
  }

  LocalStorage localStorage = LocalStorage('week');

  int scheduleNum;
  String _submitType;
  Map _submitMap = {'create_new': 1, 'edit': 2};
  int _type;

  DateTime _startDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 8, 0);
  DateTime _endDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 9, 0);
  Duration _remindTime;
  String _title;
  String _location;
  String _remark;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  List<Duration> _remindTimeList = [];

  bool _allDay = false;
  bool _isCountdown = false;
  bool _isNotCreate = false;
  bool _remarkIsFocus = false;
  FocusNode _remarkFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _uidLoad();
    _remarkFocus.addListener(
        () => setState(() => _remarkIsFocus = _remarkFocus.hasFocus));
  }

  _ScheduleForm(
      this._submitType,
      this.scheduleNum,
      this._title,
      this._startDateTime,
      this._endDateTime,
      this._type,
      this._location,
      this._remindTimeList,
      this._isCountdown,
      this._remark);

  @override
  Widget build(BuildContext context) {
    DateTime _semesterStart = DateTime.parse(localStorage.getItem('start'));
    DateTime _semesterEnd = DateTime.parse(localStorage.getItem('end'));

    _titleController.text = _title;
    _locationController.text = _location;
    _remarkController.text = _remark;
    if (_startDateTime == null)
      _startDateTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 1, 8, 0);
    if (_endDateTime == null)
      _endDateTime = _startDateTime.add(Duration(hours: 1));
    if (_remindTimeList == null) _remindTimeList = [];
    // values ------------------------------------------------------------------------------------------
    Sizing _sizing = Sizing(context);
    double _bottomHeight = _sizing.height(7);
    double _bottomIconWidth = _sizing.width(5);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;

    double _paddingLR = _sizing.width(6);
    double _paddingTB = _sizing.width(3);
    double _timePaddingLR = _sizing.width(2); //時間選擇區域padding
    double _listPaddingLR = _sizing.width(10);
    double _listItemHeight = _sizing.height(8);

    double _iconSize = _sizing.height(5);
    double _h1Size = _sizing.height(3.5);
    double _h2Size = _sizing.height(3);
    double _pSize = _sizing.height(2.5);
    double _pickerTextSize = _sizing.height(2);
    double _weekSize = _sizing.width(4); // 第幾週字體大小
    double _timeSize = _sizing.width(4);

    String _startWeek = ConvertInt.toChineseWeek(
        getMon(_startDateTime).difference(getMon(_semesterStart)).inDays ~/ 7 +
            1);
    String _endWeek = ConvertInt.toChineseWeek(
        getMon(_endDateTime).difference(getMon(_semesterStart)).inDays ~/ 7 +
            1);

    String _startView = _allDay
        ? '${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_startDateTime.weekday - 1]}'
        : '${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_startDateTime.weekday - 1]} ${_startDateTime.hour.toString().padLeft(2, '0')}:${_startDateTime.minute.toString().padLeft(2, '0')}';
    String _endView = _allDay
        ? '${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_endDateTime.weekday - 1]}'
        : '${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_endDateTime.weekday - 1]} ${_endDateTime.hour.toString().padLeft(2, '0')}:${_endDateTime.minute.toString().padLeft(2, '0')}';

    Widget _counterWidget = Text('');
    _counterWidget = _remarkIsFocus ? null : Text('');

    String _remarkLbl;
    TextStyle _remarkLblStyle;
    _remarkLbl = _remarkIsFocus ? '備註' : null;
    _remarkLblStyle = _remarkIsFocus ? TextStyle(color: _color) : null;

    String _remarkHint = '備註';
    TextStyle _remarkHintStyle =
        TextStyle(fontSize: _h2Size, color: Colors.grey);
    _remarkHint = _remarkIsFocus ? null : '備註';
    _remarkHintStyle = _remarkIsFocus
        ? null
        : TextStyle(fontSize: _h2Size, color: Colors.grey);

    int _totalWeek =
        getMon(_semesterEnd).difference(getMon(_semesterStart)).inDays ~/ 7 + 1;

    List<Widget> _totalWeekList = [];
    for (int i = 0; i < _totalWeek; i++) {
      _totalWeekList.add(Text(
        ConvertInt.toChineseWeek(i + 1),
        style: TextStyle(color: _color),
      ));
    }
    // _submit -----------------------------------------------------------------------------------------
    _submit() async {
      String _alertTitle = '新增行程失敗';
      String title = _titleController.text;
      String startTime;
      String endTime;

      List<String> remindTime = [];
      dynamic typeId = _type;
      bool isCountdown = _isCountdown;
      String place = _locationController.text;
      String remark = _remarkController.text;

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

      for (int i = 0; i < _remindTimeList.length; i++) {
        remindTime.add(_startDateTime.subtract(_remindTimeList[i]).toString());
      }
      if (_uid == null) {
        await alert(context, _alertTitle, '請先登入');
        _isNotCreate = true;
        Navigator.pop(context);
      }
      if (title == null || title == '') {
        await alert(context, _alertTitle, '請輸入標題');
        _isNotCreate = true;
      }
      if (startTime == null || startTime == '') {
        await alert(context, _alertTitle, '請選擇開始時間');
        _isNotCreate = true;
      }

      if (endTime == null || endTime == '') {
        await alert(context, _alertTitle, '請選擇結束時間');
        _isNotCreate = true;
      }
      if (typeId == null || typeId <= 0 || typeId > 8) {
        await alert(context, _alertTitle, '請選擇類別');
        _isNotCreate = true;
      }
      if (isCountdown == null) {
        await alert(context, _alertTitle, '倒數錯誤');
        _isNotCreate = true;
      }

      bool isRemind = remindTime.length > 0 ? true : false;
      Map remind = {'isRemind': isRemind, 'remindTime': remindTime};

      if (_isNotCreate) {
        _isNotCreate = false;
        return true;
      } else {
        var submitWidget;
        _submitWidgetfunc() async {
          switch (_submitMap[_submitType]) {
            case 1:
              return CreateNew(
                  context: context,
                  uid: _uid,
                  title: title,
                  startTime: startTime,
                  endTime: endTime,
                  remind: remind,
                  typeId: typeId,
                  isCountdown: isCountdown,
                  place: place,
                  remark: remark);
            case 2:
              return Edit(
                  context: context,
                  uid: _uid,
                  title: title,
                  scheduleNum: scheduleNum,
                  startTime: startTime,
                  endTime: endTime,
                  remind: remind,
                  typeId: typeId,
                  isCountdown: isCountdown,
                  place: place,
                  remark: remark);
          }
        }

        submitWidget = await _submitWidgetfunc();
        if (await submitWidget.getIsError())
          return true;
        else
          return false;
      }
    }

    Color getTypeColor(value) {
      Color color = value == null ? Color(0xffFFFFFF) : typeColor(value);
      return color;
    }

    // // picker mode ----------------------------------------------------------------------------------
    CupertinoDatePickerMode _mode() {
      if (_allDay)
        return CupertinoDatePickerMode.date;
      else
        return CupertinoDatePickerMode.dateAndTime;
    }

    void _datePicker(contex, isStart) {
      DateTime _date;
      if (isStart)
        _date = _startDateTime;
      else
        _date = _endDateTime;
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
                  mode: _mode(),
                  initialDateTime: _date,
                  onDateTimeChanged: (value) => setState(() {
                    if (isStart) {
                      _startDateTime = value;
                    } else {
                      _endDateTime = value;
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }

    void _timePicker(context) {
      _remindTime = Duration(hours: 0, minutes: 0);
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _sizing.height(40),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(_sizing.width(3)),
                    child: Container(
                      child: Text('距離開始時間',
                          style: TextStyle(
                              fontSize: _pickerTextSize,
                              color: _color,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none)),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton(
                        child: Text('確定', style: TextStyle(color: _color)),
                        onPressed: () => setState(() {
                          if (_remindTimeList.contains(_remindTime)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('時間已經存在')));
                          } else {
                            _remindTimeList.add(_remindTime);
                          }
                          Navigator.of(context).pop();
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: Duration(hours: 0, minutes: 0),
                  onTimerDurationChanged: (value) =>
                      setState(() => _remindTime = value),
                ),
              )
            ],
          ),
        ),
      );
    }

    void _weekPicker(BuildContext context, bool isStart) {
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
                      child: CupertinoPicker(
                        backgroundColor: Colors.white,
                        itemExtent: 30,
                        scrollController:
                            FixedExtentScrollController(initialItem: 1),
                        children: _totalWeekList,
                        onSelectedItemChanged: (int value) {
                          setState(() {
                            DateTime _semesterStartDate = getMon(_semesterStart)
                                .add(Duration(days: value * 7));
                            if (isStart) {
                              _startWeek = ConvertInt.toChineseWeek(value);
                              _startDateTime = DateTime(
                                  _semesterStartDate.year,
                                  _semesterStartDate.month,
                                  _semesterStartDate.day,
                                  _startDateTime.hour,
                                  _startDateTime.minute,
                                  _startDateTime.second);
                            } else {
                              _endWeek = ConvertInt.toChineseWeek(value);
                              _endDateTime = DateTime(
                                  _semesterStartDate.year,
                                  _semesterStartDate.month,
                                  _semesterStartDate.day,
                                  _endDateTime.hour,
                                  _endDateTime.minute,
                                  _endDateTime.second);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ));
    }

    // createScheduleList ------------------------------------------------------------------------------
    Widget createScheduleList = ListView(
      children: [
        // text field ----------------------------------------------------------------------------- title
        Padding(
          padding: EdgeInsets.fromLTRB(
              _paddingLR, _sizing.height(3), _paddingLR, _sizing.height(2)),
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
            controller: TextEditingController.fromValue(TextEditingValue(
                text: _titleController.text,
                selection: TextSelection.fromPosition(TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: _titleController.text.length)))),
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
                    padding: EdgeInsets.fromLTRB(
                        _timePaddingLR, 0, _timePaddingLR * 0.5, 0),
                    child: Text(
                      '開始',
                      style: TextStyle(fontSize: _pSize),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      _startWeek,
                      style: TextStyle(
                          fontSize: _weekSize,
                          color: _color,
                          fontWeight: FontWeight.normal),
                    ),
                    onPressed: () => _weekPicker(context, true),
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
                    padding: EdgeInsets.fromLTRB(
                        _timePaddingLR, 0, _timePaddingLR * 0.5, 0),
                    child: Text(
                      '結束',
                      style: TextStyle(fontSize: _pSize),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      _endWeek,
                      style: TextStyle(
                          fontSize: _weekSize,
                          color: _color,
                          fontWeight: FontWeight.normal),
                    ),
                    onPressed: () => _weekPicker(context, false),
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
          height: _sizing.height(2),
          indent: _paddingLR,
          endIndent: _paddingLR,
          color: Colors.grey,
          thickness: 0.5,
        ),

        // 個人
        Padding(
          padding: EdgeInsets.fromLTRB(
              _paddingLR, _sizing.height(2), _paddingLR * 13, 0),
          child: Container(
            padding: EdgeInsets.all(_sizing.width(1.3)),
            child: Text(
              '個人',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _timeSize,
                color: _color,
                fontWeight: FontWeight.w400,
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: _color),
                borderRadius: BorderRadius.circular(_sizing.width(3.5))),
          ),
        ),

        // dropdown button ------------------------------------------------------------------------- type
        Padding(
          padding: EdgeInsets.fromLTRB(_listPaddingLR, 0, _listPaddingLR, 0),
          child: Container(
            height: _listItemHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/type.png',
                    height: _sizing.height(5),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 7,
                  child: DropdownButton(
                    itemHeight: _sizing.height(10),
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
                      height: _sizing.height(2.5),
                      child: CircleAvatar(
                        radius: _sizing.height(2.5),
                        backgroundColor: getTypeColor(_type),
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
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            text: _locationController.text,
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: _locationController.text.length)))),
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
                        _location = text;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        // Text ----------------------------------------------------------------------------------- remind
        Padding(
          padding: EdgeInsets.fromLTRB(_listPaddingLR, 0, _listPaddingLR, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 8,
                child: RemindItem(_remindTimeList),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              _listPaddingLR, 0, _listPaddingLR, _paddingTB),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('新增提醒', style: TextStyle(fontSize: _h2Size)),
                    IconButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _timePicker(context);
                        },
                        icon:
                            Icon(Icons.add, size: _h2Size * 1.2, color: _color))
                  ],
                ),
              )
            ],
          ),
        ),
        // is countdown ---------------------------------------------------------------------------
        Padding(
          padding: EdgeInsets.fromLTRB(
              _listPaddingLR, 0, _listPaddingLR, _paddingTB),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('倒數', style: TextStyle(fontSize: _h2Size)),
                    CupertinoSwitch(
                      activeColor: _color,
                      value: _isCountdown,
                      onChanged: (bool value) =>
                          setState(() => _isCountdown = value),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.fromLTRB(_listPaddingLR * 0.7, 0, _listPaddingLR, 0),
          child: Row(
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 8,
                child: new TextField(
                    controller: _remarkController,
                    focusNode: _remarkFocus,
                    maxLines: null,
                    maxLength: 255,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: _remarkHint,
                      hintStyle: _remarkHintStyle,
                      labelText: _remarkLbl,
                      labelStyle: _remarkLblStyle,
                      counter: _counterWidget,
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _color)),
                    ),
                    cursorColor: _color,
                    onSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(FocusNode())),
              ),
            ],
          ),
        )
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
                    onPressed: () => Navigator.pop(context, 'return'),
                  ),
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
                      if (_startDateTime.isBefore(_endDateTime)) {
                        if (await _submit() != true) {
                          Navigator.pop(
                              context, GetList(context: context, uid: _uid));
                        }
                      } else {
                        alert(context, '時間錯誤', '結束時間必須在開始時間之後');
                      }
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
