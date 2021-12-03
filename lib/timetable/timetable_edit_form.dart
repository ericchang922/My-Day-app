import 'package:flutter/material.dart';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/timetable/timetable_list_model.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/timetable_request/get_timetable_list.dart';
import 'package:My_Day_app/timetable/timetable_edit.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableEditFormPage extends StatefulWidget {
  @override
  TimetableEditForm createState() => new TimetableEditForm();
}

class TimetableEditForm extends State<TimetableEditFormPage> with RouteAware {
  get child => null;
  get left => null;

  TimetableListModel _timetableListModel;

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;
    double _titleSize = _height * 0.025;
    double _appBarSize = _width * 0.052;

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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimetableEditPage()));
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
        );
      }

      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: _color,
                  title: Text('編輯課表', style: TextStyle(fontSize: _appBarSize)),
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
                  title: Text('編輯課表', style: TextStyle(fontSize: _appBarSize)),
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
