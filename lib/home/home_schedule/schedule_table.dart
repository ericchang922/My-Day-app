// flutter
import 'package:My_Day_app/home/home_schedule/schedule_button.dart';
import 'package:My_Day_app/public/convert.dart';
import 'package:My_Day_app/timetable/template/timetable_template.dart';
import 'package:flutter/material.dart';
// my day
import 'package:My_Day_app/home/home_page_functions.dart';
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
        widget.weekCount =
            ((getMon(monday).difference(getMon(d.startDate)).inDays / 7) + 1)
                .toInt();
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

    TimetableTemplate timetableTemplate = TimetableTemplate(
        context: context,
        type: 'home_page',
        timeLineList: timeLineList,
        sectionDataList: sectionDataList,
        sectionNumList: sectionNumList,
        tableSchedule:
            TableSchedule(monday: monday, scheduleList: widget.scheduleList));

    ScheduleButton scheduleButton = ScheduleButton(
        context: context,
        scheduleList: widget.scheduleList,
        monday: monday,
        timeLineList: timeLineList);

// 在過長的時間間隔加上空白「的時段」
    // List<int> insertList = [];

    // for (int i = 0; i < timeLineList.length - 1; i++) {
    //   DateTime thisEnd =
    //       check.add(ConvertString.toDuration(timeLineList[i]['end']));
    //   DateTime nextStart =
    //       check.add(ConvertString.toDuration(timeLineList[i + 1]['start']));
    //   if (nextStart.difference(thisEnd).inMinutes /
    //           Duration(hours: 1).inMinutes >=
    //       1) {
    //     insertList.add(i);
    //   }
    // }

    // for (int i = 0; i < insertList.length; i++) {
    //   int index = insertList[i];
    //   timeLineList.insert(index + 1 + i, {'start': '', 'end': ''});
    // }

    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          timetableTemplate.thead(),
          Expanded(
            child: timetableTemplate.tbody(),
          ),
        ],
      ),
    );
  }
}
