import 'package:flutter/material.dart';

import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/timetable/timetable_receive_preview.dart';

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
    Sizing _sizing = Sizing(context);

    double _pSize = _sizing.height(2.3);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: _color,
          title: Text('接收課表', style: TextStyle(fontSize: _appBarSize)),
        ),
        body: ListView(children: <Widget>[
          Container(
              margin: EdgeInsets.only(
                  left: _sizing.height(6), top: _sizing.height(3)),
              child: Row(children: [
                Image.asset(
                  "assets/images/search.png",
                  width: _sizing.width(6),
                ),
                Container(
                  margin: EdgeInsets.only(left: _sizing.height(6)),
                  child:
                      Text('xxxxxx', style: TextStyle(fontSize: _appBarSize)),
                ),
                SizedBox(width: _sizing.width(20)),
                InkWell(
                  child: Text("刪除", style: TextStyle(fontSize: _pSize)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: _sizing.width(5)),
                InkWell(
                  child: Text("接收",
                      style: TextStyle(
                          fontSize: _pSize, color: Color(0xffF86D67))),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TimetableReceivePreviewPage()));
                  },
                ),
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
