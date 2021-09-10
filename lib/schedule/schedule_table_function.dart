import 'package:My_Day_app/models/schedule/schedule_list_model.dart';
import 'package:My_Day_app/schedule/schedule_dialog.dart';
import 'package:flutter/material.dart';

double timeHeight(String start, String end, double fullHeight) {
  DateTime startTime = DateTime.parse('2000-01-01 ' + start);
  DateTime endTime = DateTime.parse('2000-01-01 ' + end);
  double h =
      endTime.difference(startTime).inMinutes / Duration(hours: 1).inMinutes;
  if (h < 0) h = h * -1;
  if (h >= 24) h = 0;

  return h * fullHeight * 0.07;
}

class Create {
  BuildContext context;
  double height;
  double width;
  Color _topColor = Color(0xffF6E0A4);
  Color _weekDayColor = Color(0xffF6F6F6);
  Color _sectionColor = Color(0xffFFFAF0);

  Create({this.context, this.height = 0, this.width = 0});

  static Container _createTableRow(String txt, Color bkcolor, double _height) =>
      Container(
        color: bkcolor,
        height: _height,
        child: Center(
          child: Text(
            txt,
            textAlign: TextAlign.center,
          ),
        ),
      );

  Container top(String date) => _createTableRow(date, _topColor, height * 0.02);

  Container weekDay(String weekDayTxt) =>
      _createTableRow(weekDayTxt, _weekDayColor, height * 0.05);

  Container time(String start, String end) => Container(
        color: _weekDayColor,
        height: timeHeight(start, end, height),
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

  Container subject(String subjectName, double h) {
    Container created;
    if (subjectName == null || subjectName == 'null') {
      created = _createTableRow('', null, h);
    } else {
      created = _createTableRow(subjectName, _sectionColor, h);
    }
    return created;
  }

  List<Widget> dateBtn(List<DateTime> dateList, double _tableContentHeight, ScheduleGetList scheduleList) {
    List<Widget> dateBtnList = [];
    for (DateTime d in dateList) {
      dateBtnList.add(
        Container(
          height: _tableContentHeight,
          width: width / 8,
          child: TextButton(
            style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
            child: Text(''),
            onPressed: () => scheduleDialog(context, d, scheduleList),
          ),
        ),
      );
    }
    return dateBtnList;
  }
}
