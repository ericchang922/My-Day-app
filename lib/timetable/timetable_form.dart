import 'package:My_Day_app/timetable/timetable_create.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableFormPage extends StatefulWidget {
  @override
  TimetableForm createState() => new TimetableForm();
}

class TimetableForm extends State<TimetableFormPage> {
  String dropdownValueSemester = '1';
  String dropdownValueSchool = 'One';
  String dropdownValueYear = '109';
  get child => null;
  get left => null;
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(Duration(hours: 1));

  @override
  Widget build(BuildContext context) {
    final _schoolNameController = TextEditingController();
    String _schoolName;
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _leadingL = _height * 0.02;
    double _listPaddingH = _width * 0.08;
    double _subtitleT = _height * 0.005;

    double _appBarSize = _width * 0.052;
    double _pSize = _height * 0.023;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _iconWidth = _width * 0.05;
    double _borderRadius = _height * 0.03;
    double _textLBR = _height * 0.02;
    double _textFied = _height * 0.045;
    double _inkwellH = _height * 0.06;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    double _timeSize = _width * 0.045;

    String _startView =
        '${_startDateTime.year.toString().padLeft(4, '0')} 年 ${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ';

    String _endView =
        '${_endDateTime.year.toString().padLeft(4, '0')} 年 ${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ';

    void _datePicker(contex, isStart) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _height * 0.4,
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
              contentPadding: EdgeInsets.only(top: _height * 0.02),
              content: Container(
                  width: _width * 0.2,
                  height: _height * 0.25,
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
                                    top: _height * 0.015),
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
                                            horizontal: _height * 0.01,
                                            vertical: _height * 0.01),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(_height * 0.01)),
                                          borderSide: BorderSide(
                                            color: _textFiedBorder,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(_height * 0.01)),
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
                                      top: _height * 0.015,
                                      bottom: _height * 0.015),
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
                                      top: _height * 0.015,
                                      bottom: _height * 0.015),
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
        backgroundColor: Color(0xffF86D67),
        title: Text('新增課表', style: TextStyle(fontSize: 20)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: _listPaddingH, vertical: 0.0),
                  title: Text('學校', style: TextStyle(fontSize: _titleSize)),
                  subtitle: Container(
                      margin: EdgeInsets.only(top: _subtitleT),
                      child: Text('北商大',
                          style: TextStyle(fontSize: _subtitleSize))),
                  onTap: () async {
                    await timetableEditDialog(context);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 18, 0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        '學年：',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    DropdownButton(
                      hint: Text(
                        ' ',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: dropdownValueYear,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      iconSize: 24,
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
          Padding(
            padding: EdgeInsets.fromLTRB(30, 18, 0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        '學期：',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    DropdownButton(
                      hint: Text(
                        ' ',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: dropdownValueSemester,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      iconSize: 24,
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
          Padding(
            padding: EdgeInsets.fromLTRB(30, 18, 0, 0),
            child: Column(
              children: [
                Row(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      '學校開始日期：',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                      width: _width * 0.5,
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
                                width: _width * 0.001))),
                        onPressed: () => _datePicker(context, true),
                      ))
                ]),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 18, 0, 0),
            child: Column(
              children: [
                Row(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      '學校結束日期：',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                      width: _width * 0.5,
                      child: TextButton(
                        child: Text(
                          _endView,
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
                                width: _width * 0.001))),
                        onPressed: () => _datePicker(context, false),
                      ))
                ]),
              ],
            ),
          ),
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
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: RawMaterialButton(
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/cancel.png',
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    fillColor: Theme.of(context).primaryColorLight,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ), // 取消按鈕
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: RawMaterialButton(
                      elevation: 0,
                      child: Image.asset(
                        'assets/images/confirm.png',
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      fillColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TimetableCreatePage()));
                      }),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
