import 'package:flutter/material.dart';

import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/timetable/timetable_edit_form.dart';
import 'package:My_Day_app/timetable/timetable_form.dart';


const PrimaryColor = const Color(0xFFF86D67);

class TimetableActionListPage extends StatefulWidget {
  @override
  TimetableActionList createState() => new TimetableActionList();
}

class TimetableActionList extends State<TimetableActionListPage> {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text('課表', style: TextStyle(fontSize: _appBarSize)),
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
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TimetableFormPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '新增課表',
                    style: TextStyle(
                      fontSize: _appBarSize,
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
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TimetableEditFormPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '編輯課表',
                    style: TextStyle(
                      fontSize: _appBarSize,
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
