import 'package:flutter/material.dart';

class ScheduleTable extends StatefulWidget {
  List<Map<String, String>> sectionList;
  DateTime monday;
  ScheduleTable({this.monday, this.sectionList});
  @override
  State<ScheduleTable> createState() =>
      _ScheduleTable(this.monday, this.sectionList);
}

class _ScheduleTable extends State<ScheduleTable> {
  List<Map<String, String>> sectionList;
  DateTime monday;
  _ScheduleTable(this.monday, this.sectionList);
  List dateList = [];

  void initState(){
    super.initState();
    for(int i = 0; i<7; i++){
      DateTime days = monday.add(Duration(days: i));
      dateList.add((days.day).toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    List timeLineList = sectionList;

    Duration _convertToDuration(String s) {
      int hour = 0;
      int minute = 0;
      List<String> time = s.split(':');
      if (time.length >= 2) {
        hour = int.parse(time[0]);
        minute = int.parse(time[1]);
      }
      return Duration(hours: hour, minutes: minute);
    }

    String _convertToShortTime(Duration d) {
      List<String> time = d.toString().split(':');
      return '${time[0].padLeft(2, '0')}:${time[1]}';
    }

    DateTime check = DateTime.utc(2000, 01, 01, 00, 00);

    Duration dayStart = _convertToDuration(sectionList[0]['start']);
    Duration classEnd =
        _convertToDuration(sectionList[sectionList.length - 1]['end']);
    Duration timeAddNow = Duration(hours: classEnd.inHours + 1);

    timeLineList.add({
      'start': _convertToShortTime(classEnd),
      'end': _convertToShortTime(timeAddNow)
    });

    bool _checkTime() {
      bool ok = false;
      if (check.add(timeAddNow).isAfter(check.add(classEnd)))
        ok = true;
      else if (check.add(timeAddNow).isBefore(check.add(dayStart))) ok = true;
      return ok;
    }

    while (_checkTime()) {
      if (timeAddNow.inHours + 1 > 24) {
        timeAddNow = Duration(hours: 0);
      }
      if (timeAddNow.inHours == dayStart.inHours) break;

      Map<String, String> add = {'start': _convertToShortTime(timeAddNow)};

      timeAddNow = Duration(hours: timeAddNow.inHours + 1);
      add['end'] = _convertToShortTime(timeAddNow);
      timeLineList.add(add);
    }
    timeLineList[timeLineList.length - 1]['end'] =
        _convertToShortTime(dayStart);

    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    FixedColumnWidth _tableWidth = FixedColumnWidth(_width / 8);
    Color _topColor = Color(0xffF6E0A4);
    Color _tableBorderColor = Color(0xffE3E3E3);
    Color _weekDayColor = Color(0xffF6F6F6);
    Color _sectionColor = Color(0xffFFFAF0);

    double _timeHeight(String start, String end) {
      DateTime startTime = DateTime.parse('2000-01-01 ' + start);
      DateTime endTime = DateTime.parse('2000-01-01 ' + end);
      double h = endTime.difference(startTime).inMinutes /
          Duration(hours: 1).inMinutes;
      if (h < 0) h = h * -1;
      if (h >= 24) h = 0;

      return h;
    }

    Container _createTableRow(String txt, Color bkcolor, double height) =>
        Container(
          color: bkcolor,
          height: height,
          child: Center(
            child: Text(
              txt,
              textAlign: TextAlign.center,
            ),
          ),
        );
    Container _createTop(String date) => _createTableRow(date, _topColor, null);

    Container _createWeekDay(String weekDayTxt) =>
        _createTableRow(weekDayTxt, _weekDayColor, _height * 0.05);

    Container _createTime(String start, String end) => Container(
          color: _weekDayColor,
          height: _height * 0.07 * _timeHeight(start, end),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                start.toString(),
                textAlign: TextAlign.center,
              ),
              Text(
                end.toString(),
                textAlign: TextAlign.center,
              )
            ],
          )),
        );

    Container _createSubject(String subjectName, double h) =>
        _createTableRow(subjectName, _sectionColor, _height * 0.07 * h);

    List<TableRow> _tableContent() {
      List<TableRow> _tableRowList = [];
      Map<String, String> section;
      List<Widget> _contents;

      for (int i = 0; i < timeLineList.length; i++) {
        section = timeLineList[i];
        String _start = section['start'];
        String _end = section['end'];
        String _nextStart;

        if (i + 1 < timeLineList.length)
          _nextStart = timeLineList[i + 1]['start'];

        _contents = [_createTime(section['start'], section['end'])];

        for (int j = 0; j < 7; j++) {
          _contents.add(_createSubject('國文', _timeHeight(_start, _end)));
        }
        _tableRowList.add(TableRow(children: _contents));

        if (_nextStart != null) {
          double space = _timeHeight(_end, _nextStart);
          // 取得此行程和下一個行程之間的間隔（以小時計算）

          if (space >= 1) {
            _contents = [];
            // 大於一小時則會在中間加入空格
            _contents.add(Container(
              color: _weekDayColor,
              height: _height * 0.07 * space,
            ));
            for (int j = 0; j < 7; j++) {
              _contents.add(Container(height: _height * 0.05 * space));
            }
            _tableRowList.add(TableRow(children: _contents));
          }
        }
      }
      return _tableRowList;
    }

    List<TableRow> thead = [
      TableRow(children: [
        _createTop(''),
        _createTop(dateList[0]),
        _createTop(dateList[1]),
        _createTop(dateList[2]),
        _createTop(dateList[3]),
        _createTop(dateList[4]),
        _createTop(dateList[5]),
        _createTop(dateList[6])
      ]),
      TableRow(children: [
        _createWeekDay(''),
        _createWeekDay('一'),
        _createWeekDay('二'),
        _createWeekDay('三'),
        _createWeekDay('四'),
        _createWeekDay('五'),
        _createWeekDay('六'),
        _createWeekDay('日'),
      ])
    ];
    List<TableRow> _tableChildren = thead..addAll(_tableContent());

    return ListView(children: [
      Table(
          columnWidths: <int, TableColumnWidth>{
            0: _tableWidth,
            1: _tableWidth,
            2: _tableWidth,
            3: _tableWidth,
            4: _tableWidth,
            5: _tableWidth,
            6: _tableWidth
          },
          border: TableBorder.all(
              color: _tableBorderColor, width: 1, style: BorderStyle.solid),
          children: _tableChildren),
    ]);
  }
}
