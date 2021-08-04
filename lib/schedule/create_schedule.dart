import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:My_Day_app/schedule/remind_item.dart';

List<String> weekdayName = ['週一', '週二', '週三', '週四', '週五', '週六', '週日'];

final List<dynamic> typeColor = [
  0xffF78787,
  0xffFFD51B,
  0xffFFA800,
  0xffB6EB3A,
  0xff53DAF0,
  0xff4968BA,
  0xffCE85E4,
  0xff8E7A42
];

class CreateSchedule extends StatefulWidget {
  @override
  State<CreateSchedule> createState() => _CreateSchedule();
}

class _CreateSchedule extends State<CreateSchedule> {
  int _value;
  bool _allDay = false;
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(Duration(hours: 1));
  Duration _remindTime;
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _remarkController = TextEditingController();
  List<Duration> _remindTimeList = [];
  bool _isCountdown = false;

  FocusNode _remarkFocus = FocusNode();
  bool _remarkIsFocus = false;
  @override
  void initState() {
    super.initState();
    _remarkFocus.addListener(() => setState(()=>_remarkIsFocus = _remarkFocus.hasFocus));
  }

  @override
  Widget build(BuildContext context) {
    // values ------------------------------------------------------------------------------------------
    var size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _bottomHeight = _height * 0.07;
    double _bottomIconWidth = _width * 0.05;
    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    double _paddingLR = _width * 0.06;
    double _paddingTB = _width * 0.03;
    double _listPaddingLR = _width * 0.1;
    double _listItemHeight = _height * 0.08;
    double _iconSize = _height * 0.05;
    double _h1Size = _height * 0.035;
    double _h2Size = _height * 0.03;
    double _pSize = _height * 0.025;
    double _pickerTextSize = _height * 0.02;
    double _timeSize = _width * 0.045;
    final _tilteFocus = FocusNode();
    final _locationFocus = FocusNode();

    String _startView = _allDay
        ? '${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_startDateTime.weekday - 1]}'
        : '${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_startDateTime.weekday - 1]} ${_startDateTime.hour.toString().padLeft(2, '0')}:${_startDateTime.minute.toString().padLeft(2, '0')}';
    String _endView = _allDay
        ? '${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_endDateTime.weekday - 1]}'
        : '${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_endDateTime.weekday - 1]} ${_endDateTime.hour.toString().padLeft(2, '0')}:${_endDateTime.minute.toString().padLeft(2, '0')}';

    Widget _counterWidget = Text('');
    String _remarkLbl;
    TextStyle _remarkLblStyle;
    String _remarkHint ='備註';
    TextStyle _remarkHintStyle= TextStyle(fontSize: _h2Size, color: Colors.grey);
    _counterWidget = _remarkIsFocus? null:Text('');
    _remarkLbl = _remarkIsFocus? '備註':null;
    _remarkLblStyle = _remarkIsFocus? TextStyle(color: _color):null;
    _remarkHint = _remarkIsFocus? null:'備註';
    _remarkHintStyle = _remarkIsFocus? null:TextStyle(fontSize: _h2Size, color: Colors.grey);

    // _submit -----------------------------------------------------------------------------------------
    void _submitValue() {
      print(_titleController.text);
      print(_value);
      print(_startDateTime);
      print(_endDateTime);
      print(_locationController.text);
      print(_remindTimeList);
      print(_isCountdown);
      print(_remarkController.text);
      Navigator.pop(context);
    }

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

    void _datePicker(contex, isStart) {
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
                  initialDateTime: DateTime.now(),
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

    void _timePicker(context, index) {
      _remindTime = Duration(hours: 0, minutes: 0);
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _height * 0.35,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(_width * 0.03),
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
                          _remindTimeList.add(_remindTime);
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

    // createScheduleList ------------------------------------------------------------------------------
    Widget createScheduleList = ListView(
      children: [
        // text field ----------------------------------------------------------------------------- title
        Padding(
          padding: EdgeInsets.fromLTRB(
              _paddingLR, _height * 0.03, _paddingLR, _height * 0.02),
          child: TextField(
            focusNode: _tilteFocus,
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

        // 個人
        Padding(
          padding: EdgeInsets.fromLTRB(
              _paddingLR, _height * 0.02, _paddingLR * 13, 0),
          child: Container(
            padding: EdgeInsets.all(_width * 0.013),
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
                borderRadius: BorderRadius.circular(_width * 0.035)),
          ),
        ),

        // dropdown buttn ------------------------------------------------------------------------- type
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
                    value: _value,
                    items: [
                      DropdownMenuItem(
                          child:
                              Text('讀書', style: TextStyle(fontSize: _h2Size)),
                          value: 1),
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
                      setState(() => _value = value);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: _height * 0.025,
                      child: CircleAvatar(
                        radius: _height * 0.025,
                        backgroundColor: Color(getTypeColor(_value)),
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
                    focusNode: _locationFocus,
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
                  ),
                )
              ],
            ),
          ),
        ),
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

        // Text ----------------------------------------------------------------------------------- remind
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
                        onPressed: () => _timePicker(context, 0),
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
                      hintStyle:_remarkHintStyle,
                      labelText: _remarkLbl,
                      labelStyle: _remarkLblStyle,
                      counter: _counterWidget,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none),
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
                    onPressed: () => Navigator.pop(context),
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
                    onPressed: _submitValue,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
