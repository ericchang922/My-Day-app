import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class CreateTimetable {
  BuildContext context;

  String uid;
  String school;
  String schoolYear;
  String semester;
  DateTime startDate;
  DateTime endDate;
  List<Map<String, dynamic>> subject = [];
  Map<String, dynamic> _data;
  bool _isError;

  _request() async {
    Request request = Request();
    await request.createTimetable(context, _data);
    this._isError = await request.getIsError();
  }

  CreateTimetable({
    this.context,
    this.uid = '',
    this.school = '',
    this.schoolYear,
    this.semester,
    this.startDate,
    this.endDate,
  }) {
    if (schoolYear == null) {
      schoolYear = (DateTime.now().year - 1911).toString();
    }

    _data = {
      'uid': uid,
      'school': school,
      'schoolYear': schoolYear,
      'semester': semester,
      'startDate': startDate,
      'endDate': endDate,
      'subject': subject,
    };
  }

  addSubject({String subjectName, Duration startTime, Duration endTime, String week, int section}) {
    _data['subject'].add({
      'subjectName': subjectName,
      'startTime': startTime,
      'endTime': endTime,
      'week': week,
      'section': section
    });
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}

// CreateTimetable createTimetable = CreateTimetable(
//     context: context,
//     uid: uid,
//     school: 'ntub',
//     schoolYear: '110',
//     semester: '1',
//     startDate: DateTime.now(),
//     endDate: DateTime.now(),
//   );

//   createTimetable.addSubject(
//       subjectName: '國文',
//       startTime: Duration(hours: 8, minutes: 10),
//       endTime: Duration(hours: 9, minutes: 00),
//       week: '星期一',
//       section: 1);

//   createTimetable.addSubject(
//       subjectName: '數學',
//       startTime: Duration(hours: 9, minutes: 10),
//       endTime: Duration(hours: 10, minutes: 00),
//       week: '星期二',
//       section: 2);