import 'package:My_Day_app/models/schedule/schedule_list_model.dart';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/convert.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/public/toast.dart';
import 'package:My_Day_app/public/type_color.dart';
import 'package:My_Day_app/public/schedule_request/delete.dart';
import 'package:My_Day_app/schedule/create_schedule.dart';
import 'package:My_Day_app/schedule/edit_schedule.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> scheduleDialog(
    BuildContext context, DateTime date, ScheduleGetList scheduleList) {
  Sizing _sizing = Sizing(context);
  Color _color = Theme.of(context).primaryColor;

  double _fabDimension = 56.0;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_sizing.height(3))),
          child: Container(
            alignment: Alignment.centerLeft,
            height: _sizing.height(50),
            width: _sizing.width(70),
            child: Stack(children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: _sizing.height(1.5), left: _sizing.width(8)),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Text(
                            '${date.day}日',
                            style: TextStyle(
                                color: _color, fontSize: _sizing.height(4)),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            ConvertInt.toWeekDay(date.weekday),
                            style: TextStyle(
                                color: _color,
                                fontSize: _sizing.height(2),
                                height: _sizing.height(0.1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: _sizing.height(2),
                    indent: _sizing.width(5),
                    endIndent: _sizing.width(5),
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: _sizing.width(5), right: _sizing.width(5)),
                    child: Container(
                        height: _sizing.height(35),
                        child: ListView(
                            children: listItems(
                                context, date, scheduleList, _sizing.height(100), _sizing.width(100)))),
                  )
                ],
              ),
              
            ]),
          ),
        );
      });
}

List<Widget> listItems(BuildContext context, DateTime date,
    ScheduleGetList scheduleList, double height, double width) {

  String _uid;
  _uidLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _uid = prefs.getString('uid');
  }
  
  _uidLoad();
  List<Widget> itemList = [];
  DateTime dayStart = DateTime.utc(date.year, date.month, date.day, 0, 0, 0);
  DateTime dayEnd = dayStart.add(Duration(hours: 24));
  for (var s in scheduleList.schedule) {
    DateTime start = s.startTime;
    DateTime end = s.endTime;

    String showStart;
    String showEnd;
    if (!start.isBefore(dayStart) &&
        !start.isAfter(dayEnd) &&
        !end.isBefore(dayStart) &&
        !end.isAfter(dayEnd)) {
      // 在今天結束之前開始 在今天開始之後結束
      showStart =
          '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
      showEnd =
          '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    } else if (start.isBefore(dayStart) && !end.isBefore(dayStart)) {
      // 在今天之前開始 在今天開始之後結束
      showStart = '00:00';
      if (end.isAfter(dayEnd)) {
        // 在今天結束之後結束
        showEnd = '24:00';
      } else if (!end.isAfter(dayEnd)) {
        showEnd =
            '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
      }
    } else if (!start.isBefore(dayStart) &&
        !start.isAfter(dayEnd) &&
        end.isAfter(dayEnd)) {
      // 在今天開始之後開始 在今天之後結束
      showStart =
          '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
      showEnd = '24:00';
    }

    if (showStart != null && showEnd != null) {
      itemList.add(Container(
        width: width * 0.06,
        child: TextButton(
            child: Row(
              children: [
                Container(
                  height: height * 0.025,
                  child: CircleAvatar(
                    radius: height * 0.025,
                    backgroundColor: typeColor(s.typeId),
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: width * 0.4,
                    child: Text(
                      s.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    '$showStart-$showEnd',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ),
                  )
                ])
              ],
            ),
            onPressed: () {
              return null;
            },
            
      )));
    }
  }

  return itemList;
}
