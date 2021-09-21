import 'package:My_Day_app/timetable/timetable_import_past.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableChoosePastPage extends StatefulWidget {
  @override
  TimetableChoosePast createState() => new TimetableChoosePast();
}

class TimetableChoosePast extends State<TimetableChoosePastPage> {
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
            title: Text('選擇課表', style: TextStyle(fontSize: _appBarSize))),
        body: GestureDetector(
          // 點擊空白處釋放焦點
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            margin: EdgeInsets.only(
                left: _height * 0.03,
                top: _height * 0.02,
                right: _height * 0.03),
            child: Column(children: [
              SizedBox(height: _height * 0.025),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: _width * 0.02,
                  mainAxisSpacing: _width * 0.02,
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
                                  '110學年',
                                  style: TextStyle(fontSize: _titleSize),
                                ),
                                SizedBox(height: _height * 0.025),
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
                                        TimetableImprotPastPage()));
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
