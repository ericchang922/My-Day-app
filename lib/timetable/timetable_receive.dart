import 'package:flutter/material.dart';

import 'package:My_Day_app/timetable/timetable_import_share.dart';
import 'package:My_Day_app/timetable/timetable_improt_choose.dart';
import 'package:My_Day_app/public/sizing.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableReceivePage extends StatefulWidget {
  @override
  TimetableReceive createState() => new TimetableReceive();
}

class TimetableReceive extends State<TimetableReceivePage> {
  get child => null;
  get left => null;
  final _shareCodeController = TextEditingController();
  String _shareCode;

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _textFied = _sizing.height(4.5);
    double _borderRadius = _sizing.height(1);

    double _titleSize = _sizing.height(2.5);
    double _pSize = _sizing.height(2.3);
    double _subtitleSize = _sizing.height(2);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;
    Color _bule = Color(0xff7AAAD8);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: _color,
          title: Text('接收課表', style: TextStyle(fontSize: _appBarSize)),
        ),
        body: GestureDetector(
          // 點擊空白處釋放焦點
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            margin: EdgeInsets.only(
                left: _sizing.height(3),
                top: _sizing.height(2),
                right: _sizing.height(3)),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    '分享碼：',
                    style: TextStyle(fontSize: _subtitleSize),
                  ),
                  Flexible(
                    child: Container(
                      height: _textFied,
                      width: _sizing.width(60),
                      child: TextField(
                        style: TextStyle(fontSize: _pSize),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: _sizing.height(1),
                                vertical: _sizing.height(1)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_borderRadius)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_borderRadius)),
                              borderSide: BorderSide(color: _bule),
                            )),
                        controller: _shareCodeController,
                        onChanged: (text) {
                          setState(() {
                            _shareCode = _shareCodeController.text;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: _sizing.width(5)),
                  InkWell(
                    child: Text("送出", style: TextStyle(fontSize: _pSize)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TimetableImprotSharePage()));
                    },
                  )
                ],
              ),
              SizedBox(height: _sizing.height(2.5)),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: _sizing.width(2),
                  mainAxisSpacing: _sizing.width(2),
                  crossAxisCount: 2,
                  children: List.generate(
                    10,
                    (index) {
                      return Card(
                        child: InkWell(
                          child: Container(
                            color: Color(0xffFFFAE9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '109學年',
                                  style: TextStyle(fontSize: _titleSize),
                                ),
                                SizedBox(height: _sizing.height(2.5)),
                                Text(
                                  '第一學期',
                                  style: TextStyle(fontSize: _titleSize),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TimetableImprotChoosePage()));
                          },
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            side: BorderSide(
                              color: Color(0xffBEB495),
                              width: 1,
                            )),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
