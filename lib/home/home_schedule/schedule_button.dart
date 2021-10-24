// dart
// flutter
import 'package:flutter/material.dart';
// therd
// my day
import 'package:My_Day_app/home/home_page_functions.dart';
import 'package:My_Day_app/home/home_schedule.dart';
import 'package:My_Day_app/home/home_schedule/schedule_table_function.dart';
import 'package:My_Day_app/models/schedule/schedule_list_model.dart';
import 'package:My_Day_app/public/convert.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/public/type_color.dart';

class ScheduleButton {
  Color _weekDayColor = Color(0xffF6F6F6);
  double _allDayRowHeight;

  BuildContext context;
  ScheduleGetList scheduleList;
  DateTime monday;
  List timeLineList;
  Sizing _sizing;
  double _fullHeight;

  List<Widget> _allDay = [];
  List<Widget> _schedules = [];
  double _position;

  void _scheduleArrange() {
    DateTime _today;
    List<List> _scheduleCount = [
      for (var i = 0; i < timeLineList.length; i++)
        [for (var j = 0; j < 7; j++) 0]
    ]; // 計算一個時段的行程數量 // 時間區段數量*7 的陣列
    // [[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],...]

    for (int i = 0; i < 7; i++) {
      // 從本週一開始每天跑一次
      _today = monday.add(Duration(days: i));

      int _max = 0; // 檢查經過時段的行程數量

      List<Widget> _column = [];

      for (var s in scheduleList.schedule) {
        int _scheduleNumber = s.scheduleNum;
        String _scheduleTitle = s.title;
        DateTime _startTime = s.startTime;
        DateTime _endTime = s.endTime;
        int _scheduleType = s.typeId;
        _position = 0;

        TimeRange _startTimeRange = TimeRange(_startTime);
        TimeRange _endTimeRange = TimeRange(_endTime);

        if (_startTimeRange.notAfter(_today) &&
            _endTimeRange
                .notBefore(_today.add(Duration(hours: 23, minutes: 59)))) {
          // 開始和結束都不在今天 表示是整天行程

          _column.add(Container(
            height: _sizing.height(1),
            child: TextButton(
              child: Container(),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      typeColor(_scheduleType))),
            ),
          ));
        } else {
          // 整天的行程不執行
          DateTime _thisStart;
          DateTime _thisEnd;
          double _scheduleHeight = 0;

          for (int j = 0; j < timeLineList.length; j++) {
            // 表格的每一個時間段檢查一遍
            bool isStart = false;

            String timeLineStart = timeLineList[j]['start'];
            String timeLineEnd = timeLineList[j]['end'];

            Duration _heightStart;
            Duration _heightEnd;
            // 用 _heightStart 和 _heightEnd 計算在這格中行程的長度
            // => 將每隔中行程的長度相加為行程總長

            if (timeLineStart == '' || timeLineEnd == '') {
              timeLineStart = timeLineList[j - 1]['end'];
              timeLineEnd = timeLineList[j + 1]['start'];
            } // 如果「開始」和「結束」為空上一段的結束作為「開始」下一段的開始作為「結束」

            _thisStart = _today.add(ConvertString.toDuration(timeLineStart));
            _thisEnd = _today.add(ConvertString.toDuration(timeLineEnd));

            if (_thisStart.isBefore(_today
                .add(ConvertString.toDuration(timeLineList[0]['start'])))) {
              // 如果此段時間在今天表格開始之前 => 加一天表示明天的這個時段
              // 例如課表是 8:00 開始 如果出現 7:00 表示是明天的時間（在表格最下方）=
              _thisStart = _thisStart.add(Duration(days: 1));
              _thisEnd = _thisEnd.add(Duration(days: 1));
            }

            if (_startTimeRange.inTime(_thisStart, _thisEnd)) {
              // 在這格開始 => 開始時間＝行程開始
              isStart = true;
              _heightStart = timeOfDateTime(_startTime);

              _position += timeHeight(
                  timeLineStart,
                  ConvertDuration.toShortTime(timeOfDateTime(_startTime)),
                  _fullHeight); // 如果在這格開始 => 上方的空間增加「這格開始～行程開始」

            } else if (_startTimeRange.notAfter(_thisStart)) {
              // 在這格之前開始(不在這格之後) => 開始時間=這格開始
              isStart = true;
              _heightStart = timeOfDateTime(_thisStart);
            } else if (_startTimeRange.notBefore(_thisStart)) {
              // 在這格之後開始(不在這格之前) => 沒有開始時間
              _heightStart = null;

              if (!isStart) {
                _position += timeHeight(timeLineStart, timeLineEnd,
                    _fullHeight); // 如果行程還沒開始 => 上方的空間增加
              }
            }

            if (_endTimeRange.inTime(_thisStart, _thisEnd)) {
              // 在這格結束 => 結束時間=行程結束
              _heightEnd = timeOfDateTime(_endTime);
            } else if (_endTimeRange.notBefore(_thisEnd)) {
              // 在這格之後結束(不在這格之後) => 結束時間=這格結束
              _heightEnd = timeOfDateTime(_thisEnd);
            } else if (_endTimeRange.notAfter(_thisEnd)) {
              // 在這格之前結束(不再這格之後) => 沒有開始時間
              _heightEnd = null;
            }

            if (_heightStart != null && _heightEnd != null) {
              _scheduleCount[j][i]++;

              _scheduleHeight += timeHeight(
                  ConvertDuration.toShortTime(_heightStart),
                  ConvertDuration.toShortTime(_heightEnd),
                  _fullHeight);
              // 此行程在這天的總長累積
            }
            // 如果開始時間在結束時間之後
            if (_scheduleCount[j][i] > _max) {
              _max = _scheduleCount[j][i];
            }
          }

          double _left = (_sizing.width(100) / 8) * (i + 1);

          if (_max <= 4) {
            _left += (_max - 1) * _sizing.width(3);

            _schedules.add(homeSchedule(context,
                top: _position,
                left: _left,
                height: _scheduleHeight,
                scheduleNum: _scheduleNumber,
                typeId: _scheduleType,
                count: _max));
          }
        }
      }

      _allDay.add(Container(
        height: _allDayRowHeight,
        width: _sizing.width(100) / 8,
        child: ListView(children: _column),
      ));
    }
  }

  ScheduleButton(
      {this.context, this.scheduleList, this.monday, this.timeLineList}) {
    _sizing = Sizing(context);
    _fullHeight = _sizing.height(100);
    _allDayRowHeight = _sizing.height(3);
    _allDay = [
      Container(
        color: _weekDayColor,
        height: _sizing.height(3),
        alignment: Alignment.center,
        child: Text('整日'),
      )
    ];
    _scheduleArrange();
  }

  getAllDay() => _allDay; // 整天行程按鈕列表
  getSchedules() => _schedules; // 行程按鈕列表
}

class TimeRange {
  // 時間範圍
  DateTime time;
  TimeRange(this.time);
  bool inTime(DateTime start, DateTime end) {
    bool isInTime = true;
    DateTime _start = start;
    DateTime _end = end;

    if (_start.isAfter(_end)) {
      _start = end;
      _end = start;
    } // 若開始在結束之後則交換位置

    if (time.isBefore(start)) isInTime = false;
    if (time.isAfter(end)) isInTime = false;
    // 時間要在區間開始之後、結束之前
    // => 不能在開始前和結束後
    return isInTime;
  }

  bool notAfter(DateTime dateTime) {
    bool isNotAfter = true;
    if (time.isAfter(dateTime)) isNotAfter = false;
    return isNotAfter;
  }

  bool notBefore(DateTime dateTime) {
    bool isNotBefore = true;
    if (time.isBefore(dateTime)) isNotBefore = false;
    return isNotBefore;
  }
}

//  1       2       3       4       5       6
//                         ||
//                         ||      ||
//                 ||              ||
// ----------------------------------------------
//                 ||              ||
//  ||             ||              ||
//  ||     ||                      ||
// ----------------------------------------------
//         ||                      ||
//                                 ||       || 
//                                          ||
//
// 在這格開始
//    |______ 在這格結束      1
//    |______ 在這格之後結束   2
// 在這格之前開始
//    |______ 在這格結束      3
//    |______ 在這格之前結束   4
//    |______ 在這格之後結束   5
// 在這格之後開始
//    |______ 在這格之後結束   6
//
// 對於這格而言只需判斷: 1235