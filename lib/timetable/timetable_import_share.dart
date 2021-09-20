import 'package:My_Day_app/timetable/timetable_receive.dart';
import 'package:My_Day_app/timetable/timetable_receive_preview.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableImprotSharePage extends StatefulWidget {
  @override
  TimetableImportShare createState() => new TimetableImportShare();
}

class TimetableImportShare extends State<TimetableImprotSharePage> {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('接收課表', style: TextStyle(fontSize: 20)),
        ),
        body: ListView(children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 35, top: 20),
              child: Row(children: [
                Image.asset(
                  "assets/images/search.png",
                  width: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 35),
                  child: Text('xxxxxx', style: TextStyle(fontSize: 20)),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 90, 0)),
                SizedBox(
                    child: FlatButton(
                  minWidth: 10,
                  child: Text("刪除", style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimetableReceivePage()));
                  },
                )),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                SizedBox(
                    child: FlatButton(
                  minWidth: 10,
                  child: Text(
                    "接收",
                    style: TextStyle(fontSize: 18, color: Color(0xffF86D67)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TimetableReceivePreviewPage()));
                  },
                )),
              ])),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                color: Color(0xffE3E3E3),
                constraints: BoxConstraints.expand(height: 1.0),
              )),
        ]));
  }
}
