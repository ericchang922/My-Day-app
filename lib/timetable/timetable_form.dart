import 'package:My_Day_app/timetable/timetable_create.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimetableForm();
  }
}

class TimetableForm extends State {
  String dropdownValueSemester = '1';
  String dropdownValueSchool = 'One';
  String dropdownValueYear = '109';
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
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
                      icon: const Icon(Icons.arrow_downward),
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
                      icon: const Icon(Icons.arrow_downward),
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
                      icon: const Icon(Icons.arrow_downward),
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
                        onPressed: () async {
                          var result = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2025));
                          print('$result');
                        },
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
                        onPressed: () async {
                          var result = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2025));
                          print('$result');
                        },
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
