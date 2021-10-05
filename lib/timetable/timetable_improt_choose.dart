import 'package:My_Day_app/timetable/timetable_receive_preview.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableImprotChoosePage extends StatefulWidget {
  @override
  TimetableImportChoose createState() => new TimetableImportChoose();
}

class TimetableImportChoose extends State<TimetableImprotChoosePage> {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _listLR = _height * 0.02;
    double _textFied = _height * 0.045;
    double _borderRadius = _height * 0.01;
    double _iconWidth = _width * 0.05;
    double _listPaddingH = _width * 0.06;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;

    double _titleSize = _height * 0.025;
    double _pSize = _height * 0.023;
    double _subtitleSize = _height * 0.02;
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: _color,
          title: Text('接收課表', style: TextStyle(fontSize: _appBarSize)),
        ),
        body: ListView(children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: _height * 0.06, top: _height * 0.03),
              child: Row(children: [
                Image.asset(
                  "assets/images/search.png",
                  width: _width * 0.06,
                ),
                Container(
                  margin: EdgeInsets.only(left: _height * 0.06),
                  child:
                      Text('xxxxxx', style: TextStyle(fontSize: _appBarSize)),
                ),
                SizedBox(width: _width * 0.2),
                InkWell(
                  child: Text("刪除", style: TextStyle(fontSize: _pSize)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  
                ),
                SizedBox(width: _width * 0.05),
                InkWell(
                  child: Text("預覽",
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
