import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/get_common_schedule_model.dart';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/schedule/schedule_form.dart';
import 'package:My_Day_app/schedule/schedule_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonScheduleDetailPage extends StatefulWidget {
  int scheduleNum;
  CommonScheduleDetailPage(this.scheduleNum);

  @override
  _CommonScheduleDetailWidget createState() =>
      new _CommonScheduleDetailWidget(scheduleNum);
}

class _CommonScheduleDetailWidget extends State<CommonScheduleDetailPage>
    with RouteAware {
  int scheduleNum;
  _CommonScheduleDetailWidget(this.scheduleNum);

  GetCommonScheduleModel _getCommonScheduleModel = null;

  int _type;
  bool _allDay = false;
  bool _isNotCreate = false;
  String uid = 'lili123';
  String _title;
  String _location;
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(Duration(hours: 1));

  List _typeNameList = <String>['讀書', '工作', '會議', '休閒', '社團', '吃飯', '班級', '個人'];

  TextEditingController get _titleController =>
      TextEditingController(text: _title);
  TextEditingController get _locationController =>
      TextEditingController(text: _location);

  @override
  void initState() {
    super.initState();
    _getCommonScheduleRequest();
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

  _getCommonScheduleRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/get_common_schedule.json');
    // var responseBody = json.decode(response);

    await GetCommon(uid, scheduleNum).getCommon().then((responseBody) {
      var getCommonScheduleModel =
          GetCommonScheduleModel.fromJson(responseBody);
      setState(() {
        _getCommonScheduleModel = getCommonScheduleModel;
      });
    });

    setState(() {
      _title = _getCommonScheduleModel.title;
      _type = _typeNameList.indexOf(_getCommonScheduleModel.typeName) + 1;
      _startDateTime = _getCommonScheduleModel.startTime;
      _endDateTime = _getCommonScheduleModel.endTime;
      if (_getCommonScheduleModel.place != null)
        _location = _getCommonScheduleModel.place;

      String _startString =
          "${_startDateTime.hour.toString().padLeft(2, '0')}:${_startDateTime.minute.toString().padLeft(2, '0')}";
      String _endString =
          "${_endDateTime.hour.toString().padLeft(2, '0')}:${_endDateTime.minute.toString().padLeft(2, '0')}";

      if (_startDateTime.day == _endDateTime.day) {
        if (_startString == "00:00" && _endString == "00:00" ||
            _startString == "00:00" && _endString == "23:59") {
          _allDay = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = _title;
    _locationController.text = _location;
    // values ------------------------------------------------------------------------------------------
    Size size = MediaQuery.of(context).size;
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

    dynamic getTypeColor(value) {
      dynamic color = value == null ? 0xffFFFFFF : typeColor[value - 1];
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
      DateTime _dateTime;
      if (isStart)
        _dateTime = _startDateTime;
      else
        _dateTime = _startDateTime.add(Duration(hours: 1));
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
                    if (isStart) {
                      _startDateTime = value;
                      _endDateTime = value.add(Duration(hours: 1));
                    } else
                      _endDateTime = value;
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_getCommonScheduleModel != null) {
      // createScheduleList ------------------------------------------------------------------------------
      Widget scheduleList = ListView(
        children: [
          // text field ----------------------------------------------------------------------------- title
          Padding(
            padding: EdgeInsets.fromLTRB(
                _paddingLR, _height * 0.03, _paddingLR, 0.0),
            child: TextField(
              enabled: false,
              style: TextStyle(fontSize: _h1Size),
              decoration: InputDecoration(
                hintText: '標題',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
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
          // 分隔線
          Divider(
            height: _height * 0.02,
            indent: _paddingLR,
            endIndent: _paddingLR,
            color: Colors.grey,
            thickness: 0.5,
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
                              onChanged: (bool value) {}),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // 開始-------------------------------------------------------
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(_paddingLR, 0, _paddingLR, 0),
                      child: Text(
                        '開始',
                        style: TextStyle(fontSize: _pSize),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: _height * 0.01, top: _height * 0.01),
                      child: Text(
                        _startView,
                        style: TextStyle(
                            fontSize: _timeSize,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // 結束 ------------------------------------------------------
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(_paddingLR, 0, _paddingLR, 0),
                      child: Text(
                        '結束',
                        style: TextStyle(fontSize: _pSize),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: _height * 0.01, top: _height * 0.015, bottom: _height * 0.015),
                      child: Text(
                        _endView,
                        style: TextStyle(
                            fontSize: _timeSize,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
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
                    child: Text(_typeNameList[_type],
                        style: TextStyle(fontSize: _h2Size)),
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
                      enabled: false,
                      controller: _locationController,
                      style: TextStyle(fontSize: _h2Size),
                      decoration: InputDecoration(
                        hintText: '地點',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
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
        ],
      );

      return Scaffold(
        body: GestureDetector(
          child: Container(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Center(child: scheduleList),
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
                        fillColor: _color,
                        onPressed: () => Navigator.pop(context)),
                  ),
                ), // 取消按鈕
              ]),
            ),
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
