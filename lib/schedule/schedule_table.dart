// flutter
import 'package:My_Day_app/public/convert.dart';
import 'package:My_Day_app/public/type_color.dart';
import 'package:My_Day_app/schedule/schedule_table_function.dart';
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
  List dayList = [];
  List<DateTime> dateList = [];
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
        dateList.add(days);
        dayList.add((days.day).toString());
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
    double _allDayRowHeight = _height * 0.03;
    double _tableContentHeight = 0;

    Create _create = Create(context: context, height: _height, width: _width);

    FixedColumnWidth _tableWidth = FixedColumnWidth(_width / 8);
    Color _tableBorderColor = Color(0xffE3E3E3);
    Color _weekDayColor = Color(0xffF6F6F6);

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
        double _timeHeight = timeHeight(_start, _end, _height);

        if (i + 1 < timeLineList.length)
          _nextStart = timeLineList[i + 1]['start'];

        _contents = [_create.time(section['start'], section['end'])];
        _tableContentHeight += _timeHeight;
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
          _contents.add(_create.subject(sectionSubject[j], _timeHeight));
        }
        _tableRowList.add(TableRow(children: _contents));

        if (_nextStart != null) {
          double space = timeHeight(_end, _nextStart, _height);
          // 取得此行程和下一個行程之間的間隔（以小時計算）

          if (space >= _height * 0.07) {
            _contents = [];
            // 大於一小時則會在中間加入空格
            _contents.add(Container(
              color: _weekDayColor,
              height: space,
            ));
            _tableContentHeight += space;
            for (int j = 0; j < 7; j++) {
              _contents.add(Container(height: space));
            }
            _tableRowList.add(TableRow(children: _contents));
          }
        }
      }
      return _tableRowList;
    }

    _allDaySchedule() {
      List<Widget> _allDayChildren = [];
      Duration _dayStartTime =
          ConvertString.toDuration(timeLineList[0]['start']);

      _allDayChildren.add(Container(
        color: _weekDayColor,
        height: _height * 0.03,
        alignment: Alignment.center,
        child: Text('整日'),
      ));
      for (DateTime d in dateList) {
        DateTime _todayStart = d.add(_dayStartTime);
        DateTime _todayEnd = _todayStart.add(Duration(days: 1));
        List<Widget> columnChildren = [];

        for (var s in widget.scheduleList.schedule) {
          DateTime _start = s.startTime;
          DateTime _end = s.endTime;

          if ((!_start.isAfter(_todayStart) && !_end.isBefore(_todayEnd)) ||
              (_start == d &&
                  !_end.isBefore(d.add(Duration(hours: 23, minutes: 59))))) {
            columnChildren.add(Container(
              height: _height * 0.01,
              child: TextButton(
                  child: Container(),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          typeColor(s.typeId)))),
            ));
          }
        }
        _allDayChildren.add(Container(
          height: _allDayRowHeight,
          width: _width / 8,
          child: ListView(
            children: columnChildren,
          ),
        ));
      }

      return TableRow(children: _allDayChildren);
    }

    List<TableRow> thead = [
      TableRow(children: [
        _create.top(''),
        _create.top(dayList[0]),
        _create.top(dayList[1]),
        _create.top(dayList[2]),
        _create.top(dayList[3]),
        _create.top(dayList[4]),
        _create.top(dayList[5]),
        _create.top(dayList[6])
      ]),
      TableRow(children: [
        _create.weekDay(''),
        _create.weekDay('一'),
        _create.weekDay('二'),
        _create.weekDay('三'),
        _create.weekDay('四'),
        _create.weekDay('五'),
        _create.weekDay('六'),
        _create.weekDay('日'),
      ]),
      _allDaySchedule()
    ];

    Container theadContainer = Container(
      height: _height * 0.07 + _allDayRowHeight,
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
      Positioned(
          left: _width / 8,
          child: Row(
              children: _create.dateBtn(
                  dateList, _tableContentHeight, widget.scheduleList)))
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

    _addScheduleBtn() {
      DateTime _sunday = monday.add(Duration(days: 6));
      Duration _dayStartTime =
          ConvertString.toDuration(timeLineList[0]['start']);
      double _scheduleHeight;
      double _startTop;
      double _startLeft;
      List<Widget> _scheduleBtnList = [];

      List<List> _weekCount = [];
      for (int i = 0; i < timeLineList.length; i++) {
        List<int> aWeekCount = [];
        for (int j = 0; j < 7; j++) {
          aWeekCount.add(0);
        }
        _weekCount.add(aWeekCount);
      }

      for (var s in widget.scheduleList.schedule) {
        bool _isThisWeek = false;
        bool _notStart = true;
        DateTime _start = s.startTime;
        DateTime _end = s.endTime;
        DateTime _weekStart =
            DateTime.utc(monday.year, monday.month, monday.day)
                .add(_dayStartTime);
        DateTime _weekEnd = _sunday.add(Duration(days: 1)).add(_dayStartTime);

        if ((!_start.isBefore(_weekStart) && !_start.isAfter(_weekEnd)) ||
            (!_end.isAfter(_weekEnd) && !_end.isBefore(_weekStart))) {
          _isThisWeek = true;
          //行程在這週
          for (int i = 0; i < 7; i++) {
            _scheduleHeight = 0;
            _startTop = 0;
            _startLeft = _width / 8;
            DateTime _today = monday.add(Duration(days: i));
            DateTime _todayStart = _today.add(_dayStartTime);
            DateTime _todayEnd =
                _today.add(Duration(days: 1)).add(_dayStartTime);
            int _max = 0;
            bool _isAllDay = false;

            if ((!_start.isAfter(_todayStart) && !_end.isBefore(_todayEnd)) ||
                (_start == _today &&
                    !_end.isBefore(
                        _today.add(Duration(hours: 23, minutes: 59))))) {
              _isAllDay = true;
            } else {
              if (!_end.isBefore(_todayStart) && _start.isBefore(_todayEnd)) {
                // 行程在今天
                _startLeft = (_width / 8) * (i + 1);
                // 要顯示在今天的行程有：
                // 1. 今天開始今天結束 2. 前幾天開始今天結束 3. 前幾天開始後幾天結束 4. 今天開始後幾天結束
                // 條件為： 今天開始之後結束、今天結束之前開始
                _max = 0;

                for (int j = 0; j < timeLineList.length; j++) {
                  // 從timeLineList裡面的時間開始一格一格比條件如下：
                  // 如果行程開始時間在這一格裡面就用開始時間作為開始
                  // 如果結束時間在這格裡面就以結束時間作為結束
                  // 將長度加到變數中計算按鈕長度
                  Duration _thisStart;
                  Duration _thisEnd;
                  if (timeLineList[j]['start'] == '') {
                    if (j < timeLineList.length - 1 && j != 0) {
                      _thisStart =
                          ConvertString.toDuration(timeLineList[j - 1]['end']);
                      _thisEnd = ConvertString.toDuration(
                          timeLineList[j + 1]['start']);
                    }
                  } else {
                    _thisStart =
                        ConvertString.toDuration(timeLineList[j]['start']);
                    _thisEnd = ConvertString.toDuration(timeLineList[j]['end']);
                  }

                  DateTime _thisStartDateTime = _today.add(_thisStart);
                  DateTime _thisEndDateTime = _today.add(_thisEnd);

                  if (_thisStartDateTime.isBefore(_todayStart))
                    _thisStartDateTime =
                        _thisStartDateTime.add(Duration(days: 1));
                  if (!_thisEndDateTime.isAfter(_todayStart))
                    _thisEndDateTime = _thisEndDateTime.add(Duration(days: 1));

                  Duration _heightStart;
                  Duration _heightEnd;

                  // 行程在這格開始的位置
                  if (!_start.isBefore(_thisStartDateTime) &&
                      !_start.isAfter(_thisEndDateTime)) {
                    // 如果開始時間在這格開始之後 而且 在這格結束之前 => 表示是在這格開始的

                    _notStart = false;
                    _heightStart = timeOfDateTime(_start);
                    _weekCount[j][i]++;
                    _startTop += timeHeight(
                        ConvertDuration.toShortTime(_thisStart),
                        ConvertDuration.toShortTime(_heightStart),
                        _height);
                  } else if (!_start.isAfter(_thisStartDateTime) &&
                      !_end.isBefore(_thisStartDateTime)) {
                    // 開始時間是在這格開始之前 而且 結束時間是在這格開始之後 => 會經過這格 有可能結束在這格或是之後

                    _notStart = false;
                    _heightStart = _thisStart;
                    _weekCount[j][i]++;
                  }

                  if (!_end.isBefore(_thisStartDateTime) &&
                      !_end.isAfter(_thisEndDateTime)) {
                    // 如果結束時間在這格開始之後 而且 在這格結束之前 => 表示是在這格結束的

                    _heightEnd = timeOfDateTime(_end);
                  } else if (!_end.isBefore(_thisEndDateTime) &&
                      !_start.isAfter(_thisEndDateTime)) {
                    // 結束時間是在這格結束之後 而且 開始時間是在這格結束之前 => 會經過這格 有可能在這格開始或是之前

                    _heightEnd = _thisEnd;
                  }

                  if (_notStart) {
                    _startTop += timeHeight(
                        ConvertDuration.toShortTime(_thisStart),
                        ConvertDuration.toShortTime(_thisEnd),
                        _height);
                  }

                  if (_heightStart != null && _heightEnd != null) {
                    _scheduleHeight += timeHeight(
                        ConvertDuration.toShortTime(_heightStart),
                        ConvertDuration.toShortTime(_heightEnd),
                        _height);
                  }
                  if (_weekCount[j][i] > _max) {
                    _max = _weekCount[j][i];
                  }
                }
              }
              if (_max <= 4) {
                if (_isThisWeek) {
                  _startLeft += (_max - 1) * _width * 0.03;

                  _scheduleBtnList.add(homeSchedule(
                    context,
                    top: _startTop,
                    left: _startLeft,
                    height: _scheduleHeight,
                    scheduleNum: s.scheduleNum,
                    typeId: s.typeId,
                    count: _max,
                  ));
                }
              }
            }
          }
        }
      }

      return _scheduleBtnList;
    }

    List<Widget> tbody = tbodyList..addAll(_addScheduleBtn());

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
