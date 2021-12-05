import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/public/sizing.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableInformationPage extends StatefulWidget {
  @override
  TimetableInformation createState() => new TimetableInformation();
}

class TimetableInformation extends State<TimetableInformationPage> {
  String dropdownValueSemester = '1';
  String dropdownValueYear = '109';
  get child => null;
  get left => null;
  bool _allDay = false;
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(Duration(hours: 1));

  @override
  Widget build(BuildContext context) {
    final _schoolNameController = TextEditingController();
    String _schoolName;
    Sizing _sizing = Sizing(context);

    double _listPaddingH = _sizing.width(8);
    double _subtitleT = _sizing.height(0.5);

    double _pSize = _sizing.height(2.3);
    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);
    double _borderRadius = _sizing.height(3);
    double _textLBR = _sizing.height(2);
    double _textFied = _sizing.height(4.5);
    double _inkwellH = _sizing.height(6);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    double _timeSize = _sizing.width(4.5);

    String _startView =
        '${_startDateTime.year.toString().padLeft(4, '0')} 年 ${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ';

    String _endView =
        '${_endDateTime.year.toString().padLeft(4, '0')} 年 ${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ';
    CupertinoDatePickerMode _mode() {
      if (_allDay)
        return CupertinoDatePickerMode.date;
      else
        return CupertinoDatePickerMode.dateAndTime;
    }

    void _datePicker(contex, isStart) {
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
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (dateTime) => setState(() {
                          if (isStart)
                            _startDateTime = dateTime;
                          else
                            _endDateTime = dateTime;
                        })),
              ),
            ],
          ),
        ),
      );
    }

    Future<bool> timetableEditDialog(BuildContext context) async {
      return showDialog<bool>(
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
                  height: _sizing.height(25),
                  child: GestureDetector(
                    // 點擊空白處釋放焦點
                    behavior: HitTestBehavior.translucent,
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "更改學校名稱",
                                    style: TextStyle(fontSize: _pSize),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: _textLBR,
                                    right: _textLBR,
                                    bottom: _textLBR,
                                    top: _sizing.height(1.5)),
                                child: Text('學校名稱：',
                                    style: TextStyle(fontSize: _pSize)),
                              ),
                              Container(
                                  height: _textFied,
                                  margin: EdgeInsets.only(
                                    left: _textLBR,
                                    right: _textLBR,
                                  ),
                                  child: new TextField(
                                    style: TextStyle(fontSize: _pSize),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: _sizing.height(1),
                                            vertical: _sizing.height(1)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  _sizing.height(1))),
                                          borderSide: BorderSide(
                                            color: _textFiedBorder,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  _sizing.height(1))),
                                          borderSide: BorderSide(color: _bule),
                                        )),
                                    controller: _schoolNameController,
                                    onChanged: (text) {
                                      setState(() {
                                        _schoolName =
                                            _schoolNameController.text;
                                      });
                                    },
                                  )),
                            ],
                          ),
                        ),
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
                                      bottomLeft:
                                          Radius.circular(_borderRadius),
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
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text('課表資訊', style: TextStyle(fontSize: 20)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            title: Text('學校', style: TextStyle(fontSize: _titleSize)),
            subtitle: Container(
                margin: EdgeInsets.only(top: _subtitleT),
                child: Text('北商大', style: TextStyle(fontSize: _subtitleSize))),
            onTap: () async {
              await timetableEditDialog(context);
            },
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(
                _sizing.width(7.9), _sizing.height(1), 0, 0),
            child: Row(
              children: [
                Text(
                  '學年',
                  style: TextStyle(
                    fontSize: _titleSize,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                _sizing.width(7.9), _sizing.height(1), 0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    DropdownButton(
                      hint: Text(
                        ' ',
                        style: TextStyle(fontSize: _titleSize),
                      ),
                      value: dropdownValueYear,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      iconSize: _sizing.height(3),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(),
                      items: <String>['109', '110', '111', '112']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValueYear = newValue;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(
                _sizing.width(7.9), _sizing.height(1), 0, 0),
            child: Row(
              children: <Widget>[
                Text(
                  '學期',
                  style: TextStyle(
                    fontSize: _titleSize,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                _sizing.width(7.9), _sizing.height(1), 0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    DropdownButton(
                      hint: Text(
                        ' ',
                        style: TextStyle(fontSize: _titleSize),
                      ),
                      value: dropdownValueSemester,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      iconSize: _sizing.height(3),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(),
                      items: <String>['1', '2']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValueSemester = newValue;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(
                _sizing.width(5.5), _sizing.height(1), 0, 0),
            child: Column(
              children: [
                Row(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(_sizing.width(2.5), 0, 0, 0),
                    child: Text(
                      '學校開始日期：',
                      style: TextStyle(fontSize: _titleSize),
                    ),
                  ),
                  SizedBox(
                      width: _sizing.width(50),
                      child: TextButton(
                        child: Text(
                          _startView,
                          style: TextStyle(
                              fontSize: _timeSize,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            side: MaterialStateProperty.all(BorderSide(
                                color: Color(0xff707070),
                                width: _sizing.width(0.1)))),
                        onPressed: () => _datePicker(context, true),
                      ))
                ]),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(
                _sizing.width(5.5), _sizing.height(1), 0, 0),
            child: Column(
              children: [
                Row(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(_sizing.width(2.5), 0, 0, 0),
                    child: Text(
                      '學校結束日期：',
                      style: TextStyle(fontSize: _titleSize),
                    ),
                  ),
                  SizedBox(
                      width: _sizing.width(50),
                      child: TextButton(
                        child: Text(
                          _startView,
                          style: TextStyle(
                              fontSize: _timeSize,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            side: MaterialStateProperty.all(BorderSide(
                                color: Color(0xff707070),
                                width: _sizing.width(0.1)))),
                        onPressed: () => _datePicker(context, true),
                      ))
                ]),
              ],
            ),
          ),
          Divider(),
        ],
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
                  height: _sizing.height(7),
                  child: RawMaterialButton(
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/cancel.png',
                      width: _sizing.width(5),
                    ),
                    fillColor: Theme.of(context).primaryColorLight,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ), // 取消按鈕
              Expanded(
                child: SizedBox(
                  height: _sizing.height(7),
                  child: RawMaterialButton(
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/confirm.png',
                      width: _sizing.width(5),
                    ),
                    fillColor: Theme.of(context).primaryColor,
                    onPressed: () => Navigator.pop(context),
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
