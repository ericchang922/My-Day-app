// flutter
import 'package:flutter/material.dart';
// my day
import 'package:My_Day_app/home/home_page_functions.dart';
import 'package:My_Day_app/home/home_schedule.dart';
import 'package:My_Day_app/models/schedule/schedule_list_model.dart';
import 'package:My_Day_app/models/timetable/main_timetable_list_model.dart';

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
  ScheduleGetList scheduleList;

  ScheduleTable({this.monday, this.sectionList, this.data, this.scheduleList});

  @override
  State<ScheduleTable> createState() => _ScheduleTable(this.monday, this.data);
}

class _ScheduleTable extends State<ScheduleTable> {
  DateTime monday;
  int weekCount;
  MainTimetableListGet data;
  List dateList = [];
  List timeLineList = [];
  Duration dayStart;
  Duration classEnd;
  Duration timeAddNow;
  DateTime check = DateTime.utc(2000, 01, 01, 00, 00);

  _ScheduleTable(this.monday, this.data);

  bool _checkTime() {
    bool ok = false;
    if (check.add(timeAddNow).isAfter(check.add(classEnd)))
      ok = true;
    else if (check.add(timeAddNow).isBefore(check.add(dayStart))) ok = true;
    return ok;
  }

  @override
  void initState() {
    super.initState();
    if (monday != null &&
        data != null &&
        widget.sectionList != null &&
        widget.scheduleList != null) {
      if (widget.sectionList[0]['start'] !=
          widget.sectionList[widget.sectionList.length - 1]['end']) {
        timeLineList = timeLineList..addAll(widget.sectionList);

        dayStart = ConvertString.toDuration(timeLineList[0]['start']);
        classEnd = ConvertString.toDuration(
            timeLineList[timeLineList.length - 1]['end']);
        timeAddNow = Duration(hours: classEnd.inHours + 1);
        timeLineList.add({
          'start': ConvertDuration.toShortTime(classEnd),
          'end': ConvertDuration.toShortTime(timeAddNow)
        });

        while (_checkTime()) {
          if (timeAddNow.inHours + 1 > 24) {
            timeAddNow = Duration(hours: 0);
          }
          if (timeAddNow.inHours == dayStart.inHours) break;

          Map<String, String> add = {
            'start': ConvertDuration.toShortTime(timeAddNow)
          };

          timeAddNow = Duration(hours: timeAddNow.inHours + 1);
          add['end'] = ConvertDuration.toShortTime(timeAddNow);
          timeLineList.add(add);
        }
        timeLineList[timeLineList.length - 1]['end'] =
            ConvertDuration.toShortTime(dayStart);
      } else {
        timeLineList = widget.sectionList;
      }

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

    List<int> sectionNumList = [];
    List<List<String>> sectionDataList = [];
    String semester;

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

      return h * _height * 0.07;
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
    Container _createTop(String date) =>
        _createTableRow(date, _topColor, _height * 0.02);

    Container _createWeekDay(String weekDayTxt) =>
        _createTableRow(weekDayTxt, _weekDayColor, _height * 0.05);

    Container _createTime(String start, String end) => Container(
          color: _weekDayColor,
          height: _timeHeight(start, end),
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
        created = _createTableRow('', null, h);
      } else {
        created = _createTableRow(subjectName, _sectionColor, h);
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
        weekCount = (getMon(monday).difference(getMon(d.startDate)).inDays / 7)
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

          if (space >= _height * 0.07) {
            _contents = [];
            // 大於一小時則會在中間加入空格
            _contents.add(Container(
              color: _weekDayColor,
              height: space,
            ));
            for (int j = 0; j < 7; j++) {
              _contents.add(Container(height: space));
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

    Container theadContainer = Container(
      height: _height * 0.07,
      width: _width,
      child: Table(
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
          children: thead),
    );

    List<Widget> tbodyList = [
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
          children: _tableContent()),
    ];

    List<int> insertList = [];

    for (int i = 0; i < timeLineList.length - 1; i++) {
      DateTime thisEnd =
          check.add(ConvertString.toDuration(timeLineList[i]['end']));
      DateTime nextStart =
          check.add(ConvertString.toDuration(timeLineList[i + 1]['start']));
      if (nextStart.difference(thisEnd).inMinutes /
              Duration(hours: 1).inMinutes >=
          1) {
        insertList.add(i);
      }
    }

    for (int i = 0; i < insertList.length; i++) {
      int index = insertList[i];
      timeLineList.insert(index + 1 + i, {'start': '', 'end': ''});
    }

    addScheduleBtn() {
      DateTime sunday = monday.add(Duration(days: 6));
      Duration dayStartTime =
          ConvertString.toDuration(timeLineList[0]['start']);
      double scheduleHeight;
      double startTop;
      double startLeft;
      List<Widget> scheduleBtnList = [];

      List<List> weekCount = [];
      for (int i = 0; i < timeLineList.length; i++) {
        List<int> aWeekCount = [];
        for (int j = 0; j < 7; j++) {
          aWeekCount.add(0);
        }
        weekCount.add(aWeekCount);
      }

      for (var s in widget.scheduleList.schedule) {
        bool isThisWeek = false;
        bool notStart = true;
        DateTime start = s.startTime;
        DateTime end = s.endTime;
        DateTime weekStart = DateTime.utc(monday.year, monday.month, monday.day)
            .add(dayStartTime);
        DateTime weekEnd = sunday.add(Duration(days: 1)).add(dayStartTime);

        if ((!start.isBefore(weekStart) && !start.isAfter(weekEnd)) ||
            (!end.isAfter(weekEnd) && !end.isBefore(weekStart))) {
          isThisWeek = true;
          //行程在這週
          for (int i = 0; i < 7; i++) {
            scheduleHeight = 0;
            startTop = 0;
            startLeft = _width / 8;
            DateTime today = monday.add(Duration(days: i));
            DateTime todayStart = today.add(dayStartTime);
            DateTime todayEnd = today.add(Duration(days: 1)).add(dayStartTime);
            int max = 0;

            if (!end.isBefore(todayStart) && start.isBefore(todayEnd)) {
              // 行程在今天
              startLeft = (_width / 8) * (i + 1);
              // 要顯示在今天的行程有：
              // 1. 今天開始今天結束 2. 前幾天開始今天結束 3. 前幾天開始後幾天結束 4. 今天開始後幾天結束
              // 條件為： 今天開始之後結束、今天結束之前開始
              max = 0;

              for (int j = 0; j < timeLineList.length; j++) {
                // 從timeLineList裡面的時間開始一格一格比條件如下：
                // 如果行程開始時間在這一格裡面就用開始時間作為開始
                // 如果結束時間在這格裡面就以結束時間作為結束
                // 將長度加到變數中計算按鈕長度
                Duration thisStart;
                Duration thisEnd;
                if (timeLineList[j]['start'] == '') {
                  if (j < timeLineList.length - 1 && j != 0) {
                    thisStart =
                        ConvertString.toDuration(timeLineList[j - 1]['end']);
                    thisEnd =
                        ConvertString.toDuration(timeLineList[j + 1]['start']);
                  }
                } else {
                  thisStart =
                      ConvertString.toDuration(timeLineList[j]['start']);
                  thisEnd = ConvertString.toDuration(timeLineList[j]['end']);
                }

                DateTime thisStartDateTime = today.add(thisStart);
                DateTime thisEndDateTime = today.add(thisEnd);

                if (thisStartDateTime.isBefore(todayStart))
                  thisStartDateTime = thisStartDateTime.add(Duration(days: 1));
                if (!thisEndDateTime.isAfter(todayStart))
                  thisEndDateTime = thisEndDateTime.add(Duration(days: 1));

                Duration heightStart;
                Duration heightEnd;

                // 行程在這格開始的位置
                if (!start.isBefore(thisStartDateTime) &&
                    !start.isAfter(thisEndDateTime)) {
                  // 如果開始時間在這格開始之後 而且 在這格結束之前 => 表示是在這格開始的

                  notStart = false;
                  heightStart = timeOfDateTime(start);
                  weekCount[j][i]++;
                  startTop += _timeHeight(
                      ConvertDuration.toShortTime(thisStart),
                      ConvertDuration.toShortTime(heightStart));
                } else if (!start.isAfter(thisStartDateTime) &&
                    !end.isBefore(thisStartDateTime)) {
                  // 開始時間是在這格開始之前 而且 結束時間是在這格開始之後 => 會經過這格 有可能結束在這格或是之後

                  notStart = false;
                  heightStart = thisStart;
                  weekCount[j][i]++;
                }

                if (!end.isBefore(thisStartDateTime) &&
                    !end.isAfter(thisEndDateTime)) {
                  // 如果結束時間在這格開始之後 而且 在這格結束之前 => 表示是在這格結束的

                  heightEnd = timeOfDateTime(end);
                } else if (!end.isBefore(thisEndDateTime) &&
                    !start.isAfter(thisEndDateTime)) {
                  // 結束時間是在這格結束之後 而且 開始時間是在這格結束之前 => 會經過這格 有可能在這格開始或是之前

                  heightEnd = thisEnd;
                }

                if (notStart) {
                  startTop += _timeHeight(
                      ConvertDuration.toShortTime(thisStart),
                      ConvertDuration.toShortTime(thisEnd));
                }

                if (heightStart != null && heightEnd != null) {
                  scheduleHeight += _timeHeight(
                      ConvertDuration.toShortTime(heightStart),
                      ConvertDuration.toShortTime(heightEnd));
                }
                if (weekCount[j][i] > max) {
                  max = weekCount[j][i];
                }
              }
            }
            if (max <= 4) {
              if (isThisWeek) {
                startLeft += (max - 1) * _width * 0.03;

                scheduleBtnList.add(homeSchedule(
                  context,
                  top: startTop,
                  left: startLeft,
                  height: scheduleHeight,
                  scheduleNum: s.scheduleNum,
                  typeId: s.typeId,
                  count: max,
                ));
              }
            }
          }
        }
      }

      return scheduleBtnList;
    }

    List<Widget> tbody = tbodyList..addAll(addScheduleBtn());

    Container tbodyContainer = Container(
      child: ListView(
          children: [Stack(alignment: Alignment.topLeft, children: tbody)]),
    );

    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          theadContainer,
          Expanded(
            child: tbodyContainer,
          ),
        ],
      ),
    );
  }
}
