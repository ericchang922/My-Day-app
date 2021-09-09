import 'package:My_Day_app/timetable/timetable_edit.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableEditFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimetableEditForm();
  }
}

class TimetableEditForm extends State {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('編輯課表', style: TextStyle(fontSize: 20)),
          leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).pop();
              })),
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(52, 51, 0, 0),
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: FlatButton(
                        child: Text(
                          '109學年\n第一學期',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        color: Color(0xffFFFAE9),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xffBEB495),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimetableEditPage()));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    ),
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: FlatButton(
                        child: Text('109學年\n第二學期',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                        color: Color(0xffFFFAE9),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xffBEB495),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimetableEditPage()));
                        },
                      ),
                    )
                  ]),
                ],
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(52, 51, 0, 0),
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: FlatButton(
                        child: Text('110學年\n第一學期',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                        color: Color(0xffFFFAE9),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xffBEB495),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimetableEditPage()));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    ),
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: FlatButton(
                        child: Text('111學年\n第二學期',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                        color: Color(0xffFFFAE9),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xffBEB495),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimetableEditPage()));
                        },
                      ),
                    )
                  ]),
                ],
              )),
        ],
      ),
    );
  }
}
