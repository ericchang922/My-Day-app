import 'package:My_Day_app/timetable/timetable_edit.dart';
import 'package:My_Day_app/timetable/timetable_form.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableActionListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimetableActionList();
  }
}

class TimetableActionList extends State {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('課表', style: TextStyle(fontSize: 20)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TimetableFormPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '新增課表',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xffE3E3E3),
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                margin: EdgeInsets.only(top: 4.0),
                color: Color(0xffE3E3E3),
                constraints: BoxConstraints.expand(height: 1.0),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TimetableEditPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '編輯課表',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xffE3E3E3),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
