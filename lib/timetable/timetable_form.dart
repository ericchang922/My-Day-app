import 'package:My_Day_app/timetable/timetable_create.dart';
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
  bool _allDay = false;
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(Duration(hours: 1));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;

    Color _color = Theme.of(context).primaryColor;

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
            padding: EdgeInsets.fromLTRB(42, 106, 0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        '學校：',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    DropdownButton(
                      hint: Text(
                        ' ',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: dropdownValueSchool,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      iconSize: 24,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(),
                      items: <String>['One', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValueSchool = newValue;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 26, 0, 0),
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
            padding: EdgeInsets.fromLTRB(42, 26, 0, 0),
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
            padding: EdgeInsets.fromLTRB(42, 26, 0, 0),
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
                      width: 150,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () => _datePicker(context, false),
                      ))
                ]),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 26, 0, 0),
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
                      width: 150,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8)),
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
