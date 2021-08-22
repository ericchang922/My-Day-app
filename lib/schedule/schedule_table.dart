import 'package:My_Day_app/models/timetable/main_timetable_list_model.dart';
import 'package:flutter/material.dart';

Map<String, int> weekDay = {
  '星期一': 1,
  '星期二': 2,
  '星期三': 3,
  '星期四': 4,
  '星期五': 5,
  '星期六': 6,
  '星期日': 7
};

class ScheduleTable extends StatefulWidget {
  getMonday() => monday;
  getWeekCount() => weekCount;
  List<Map<String, String>> sectionList;
  DateTime monday;
  int weekCount;
  MainTimetableListGet data;
  ScheduleTable({this.monday, this.sectionList, this.data});

  @override
  State<ScheduleTable> createState() =>
      _ScheduleTable(this.monday, this.sectionList, this.data);
}

class _ScheduleTable extends State<ScheduleTable> {
  List<Map<String, String>> sectionList;
  DateTime monday;
  int weekCount;
  MainTimetableListGet data;
  _ScheduleTable(this.monday, this.sectionList, this.data);
  List dateList = [];

  _getMon(DateTime today) {
    int daysAfter = today.weekday - 1;
    return DateTime.utc(today.year, today.month, today.day - daysAfter);
  }

  @override
  void initState() {
    super.initState();
    if (monday == null) {
    } else {
      for (int i = 0; i < 7; i++) {
        DateTime days = monday.add(Duration(days: i));
        dateList.add((days.day).toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (monday == null) {
      return Container();
    }
    List timeLineList = sectionList;
    List<int> sectionNumList = [];
    List<List<String>> sectionDataList = [];
    String semester;

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

    bool _checkTime() {
      bool ok = false;
      if (check.add(timeAddNow).isAfter(check.add(classEnd)))
        ok = true;
      else if (check.add(timeAddNow).isBefore(check.add(dayStart))) ok = true;
      return ok;
    }

    timeLineList.add({
      'start': _convertToShortTime(classEnd),
      'end': _convertToShortTime(timeAddNow)
    });

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

    Container _createSubject(String subjectName, double h) {
      Container created;
      if (subjectName == null || subjectName == 'null') {
        created = _createTableRow('', null, _height * 0.07 * h);
      } else {
        created =
            _createTableRow(subjectName, _sectionColor, _height * 0.07 * h);
      }
      return created;
    }

    _addSectionInList(s) {
      if (sectionNumList.contains(s.section) != true) {
        sectionNumList.add(s.section);
        sectionDataList.insert(sectionNumList.indexOf(s.section),
            [null, null, null, null, null, null, null]);
      }
      sectionDataList[sectionNumList.indexOf(s.section)][weekDay[s.week] - 1] =
          s.subjectName;
    }

    _runSection(var d, int count, bool isStart) {
      semester = '${d.schoolYear}-${d.semester}';

      setState(() {
        weekCount =
            (_getMon(monday).difference(_getMon(d.startDate)).inDays / 7)
                    .toInt() +
                1;
        widget.weekCount = weekCount;
      });
      if (isStart == null) {
        for (var s in d.subject) {
          _addSectionInList(s);
        }
      } else if (isStart == true) {
        for (var s in d.subject) {
          if (weekDay[s.week] > count) {
            _addSectionInList(s);
          }
        }
      } else if (isStart == false) {
        for (var s in d.subject) {
          if (weekDay[s.week] <= count + 1) {
            _addSectionInList(s);
          }
        }
      }
    }

    _getSection() async {
      for (var d in data.timetable) {
        // 週一在開學後，週日在結業前
        if (!monday.isBefore(d.startDate) &&
            !monday.add(Duration(days: 6)).isAfter(d.endDate)) {
          _runSection(d, null, null);
        } else if (!monday
                .add(Duration(days: 6))
                .isBefore(d.startDate) && // 週日在開學後，週一在結業前
            !monday.isAfter(d.startDate)) {
          int count;
          countloop:
          for (int c = 0; c < 6; c++) {
            if (!monday.add(Duration(days: c + 1)).isBefore(d.startDate)) {
              count = c + 1;
              break countloop;
            }
          }
          _runSection(d, count, true);
        } else if (!monday.isBefore(d.startDate) &&
            !monday.isAfter(d.endDate) &&
            !monday.add(Duration(days: 6)).isBefore(d.endDate)) {
          int count;
          countloop:
          for (int c = 0; c < 6; c++) {
            if (!monday.add(Duration(days: c + 1)).isBefore(d.endDate)) {
              count = c + 1;
              break countloop;
            }
          }
          _runSection(d, count, false);
        }
        break;
      }
    }

    _getSection();

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
        List<String> sectionSubject = [
          null,
          null,
          null,
          null,
          null,
          null,
          null
        ];
        if (sectionDataList.length > 0) {
          if (sectionNumList.indexOf(i + 1) < 0) {
            sectionSubject = [null, null, null, null, null, null, null];
          } else {
            sectionSubject = sectionDataList[sectionNumList.indexOf(i + 1)];
          }
        }

        for (int j = 0; j < 7; j++) {
          _contents.add(
              _createSubject(sectionSubject[j], _timeHeight(_start, _end)));
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
