import 'package:flutter/material.dart';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/timetable/timetable_share.dart';
import 'package:My_Day_app/models/timetable/sharecode_model.dart';
import 'package:My_Day_app/models/timetable/timetable_list_model.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/timetable_request/get_sharecode.dart';
import 'package:My_Day_app/public/timetable_request/get_timetable_list.dart';
import 'package:My_Day_app/public/sizing.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableChooseSharePage extends StatefulWidget {
  @override
  TimetableChooseShare createState() => new TimetableChooseShare();
}

class TimetableChooseShare extends State<TimetableChooseSharePage>
    with RouteAware {
  get child => null;
  get left => null;

  TimetableListModel _timetableListModel;
  SharecodeModel _sharecode;

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _timetableListRequest();
  }

  @override
  void initState() {
    super.initState();
    _uid();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    _timetableListRequest();
  }

  _timetableListRequest() async {
    TimetableListModel _request = await GetTimetableList(uid: uid).getData();

    setState(() {
      _timetableListModel = _request;
    });
  }

  _sharecodeRequest(int timetableNo) async {
    SharecodeModel _request =
        await Sharecode(uid: uid, timetableNo: timetableNo).getData();

    setState(() {
      _sharecode = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _titleSize = _sizing.height(2.5);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;

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
              left: _sizing.height(3),
              top: _sizing.height(2),
              right: _sizing.height(3)),
          child: Column(children: [
            SizedBox(height: _sizing.height(2.5)),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: _sizing.width(2),
                mainAxisSpacing: _sizing.width(2),
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
                                SizedBox(height: _sizing.height(2.5)),
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
