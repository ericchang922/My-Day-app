import 'package:My_Day_app/models/timetable/sharecode_model.dart';
import 'package:My_Day_app/models/timetable/timetable_list_model.dart';
import 'package:My_Day_app/public/timetable_request/get_sharecode.dart';
import 'package:My_Day_app/public/timetable_request/get_timetable_list.dart';
import 'package:My_Day_app/timetable/timetable_share.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableChooseSharePage extends StatefulWidget {
  @override
  TimetableChooseShare createState() => new TimetableChooseShare();
}

class TimetableChooseShare extends State<TimetableChooseSharePage> {
  get child => null;
  get left => null;

  TimetableListModel _timetableListModel;
  SharecodeModel _sharecode;

  String uid = 'lili123';

  @override
  void initState() {
    super.initState();
    _timetableListRequest();
  }

  _timetableListRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/get_timetable_list.json');
    // var responseBody = json.decode(response);
    // var _request = TimetableListModel.fromJson(responseBody);

    TimetableListModel _request = await GetTimetableList(uid: uid).getData();

    setState(() {
      _timetableListModel = _request;
    });
  }

  _sharecodeRequest(int timetableNo) async {
    // var response =
    //     await rootBundle.loadString('assets/json/get_timetable_list.json');
    // var responseBody = json.decode(response);
    // var _request = TimetableListModel.fromJson(responseBody);

    SharecodeModel _request =
        await Sharecode(uid: uid, timetableNo: timetableNo).getData();

    setState(() {
      _sharecode = _request;
    });
  }

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

    Widget timetalbeList;

    semester(String value) {
      String semester;
      switch (value) {
        case '1':
          semester = '一';
          break;
        case '2':
          semester = '二';
          break;
      }
      return semester;
    }

    if (_timetableListModel != null) {
      if (_timetableListModel.timetable.length == 0) {
        timetalbeList = Center(child: Text('目前沒有任何課表喔！'));
      } else {
        timetalbeList = Container(
          margin: EdgeInsets.only(
              left: _height * 0.03, top: _height * 0.02, right: _height * 0.03),
          child: Column(children: [
            SizedBox(height: _height * 0.025),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: _width * 0.02,
                mainAxisSpacing: _width * 0.02,
                crossAxisCount: 2,
                children: List.generate(
                  _timetableListModel.timetable.length,
                  (index) {
                    var timetable = _timetableListModel.timetable[index];
                    return Card(
                      child: InkWell(
                          child: Container(
                            color: Color(0xffFFFAE9),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${timetable.schoolYear}學年',
                                  style: TextStyle(fontSize: _titleSize),
                                ),
                                SizedBox(height: _height * 0.025),
                                Text(
                                  '第${semester(timetable.semester)}學期',
                                  style: TextStyle(fontSize: _titleSize),
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            _sharecodeRequest(timetable.timetableNo);
                            await timetableShare(context,
                                '_sharecode.sharecode', timetable.timetableNo);
                            // if (_sharecode != null) {
                            //   await timetableShare(context, _sharecode.sharecode,timetable.timetableNo);
                            // }
                          }),
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
        );
      }

      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: _color,
                  title: Text('選擇課表', style: TextStyle(fontSize: _appBarSize)),
                  leading: IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })),
              body: Container(
                  color: Colors.white,
                  child: SafeArea(top: false, child: timetalbeList))),
        ),
      );
    } else {
      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: _color,
                  title: Text('選擇課表', style: TextStyle(fontSize: _appBarSize)),
                  leading: IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })),
              body: Container(
                  color: Colors.white,
                  child: SafeArea(
                      top: false,
                      child: Center(child: CircularProgressIndicator())))),
        ),
      );
    }
  }
}
