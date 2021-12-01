import 'package:My_Day_app/models/schedule/schedule_list_model.dart';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/convert.dart';
import 'package:My_Day_app/public/toast.dart';
import 'package:My_Day_app/public/type_color.dart';
import 'package:My_Day_app/public/schedule_request/delete.dart';
import 'package:My_Day_app/schedule/create_schedule.dart';
import 'package:My_Day_app/schedule/edit_schedule.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

Future<void> scheduleDialog(
    BuildContext context, DateTime date, ScheduleGetList scheduleList) {
  Size _size = MediaQuery.of(context).size;
  double _height = _size.height;
  double _width = _size.width;
  Color _color = Theme.of(context).primaryColor;

  double _fabDimension = 56.0;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_height * 0.03)),
          child: Container(
            alignment: Alignment.centerLeft,
            height: _height * 0.5,
            width: _width * 0.7,
            child: Stack(children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: _height * 0.015, left: _width * 0.08),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Text(
                            '${date.day}日',
                            style: TextStyle(
                                color: _color, fontSize: _height * 0.04),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            ConvertInt.toWeekDay(date.weekday),
                            style: TextStyle(
                                color: _color,
                                fontSize: _height * 0.02,
                                height: _height * 0.001),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: _height * 0.02,
                    indent: _width * 0.05,
                    endIndent: _width * 0.05,
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: _width * 0.05, right: _width * 0.05),
                    child: Container(
                        height: _height * 0.35,
                        child: ListView(
                            children: listItems(
                                context, date, scheduleList, _height, _width))),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 20.0, bottom: 16.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    openBuilder: (BuildContext context, VoidCallback _) {
                      return CreateSchedule();
                    },
                    closedElevation: 6.0,
                    closedShape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_fabDimension / 2)),
                    ),
                    closedColor: _color,
                    closedBuilder:
                        (BuildContext context, VoidCallback openContainer) {
                      return SizedBox(
                        height: _fabDimension,
                        width: _fabDimension,
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        );
      });
}

List<Widget> listItems(BuildContext context, DateTime date,
    ScheduleGetList scheduleList, double height, double width) {
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
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditSchedule(
                          uid: 'amy123',
                          scheduleNum: s.scheduleNum,
                        ))),
            onLongPress: () => msgBox(context, '警告', '確定要刪除行程嗎？', () async {
                  Delete delete = Delete(
                      context: context,
                      uid: 'amy123',
                      scheduleNum: s.scheduleNum);
                  bool isError = await delete.getIsError();
                  if (isError) {
                    toast(context, '刪除行程錯誤');
                  }
                })),
      ));
    }
  }

  return itemList;
}
