import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CreateStudyplan {
  BuildContext context;
  String uid;
  int scheduleNum;
  String scheduleName;
  String scheduleStart;
  String scheduleEnd;
  List<Map<String, dynamic>> subjects;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.studyplanCreate(context, data);
    this._isError = await request.getIsError();
  }

  CreateStudyplan(
      {this.context,
      this.uid,
      this.scheduleName,
      this.scheduleNum,
      this.scheduleStart,
      this.scheduleEnd,
      this.subjects}) {
    data = {
      'uid': uid,
      'schedule_name': scheduleName,
      'scheduleNum': scheduleNum,
      'schedule_start': scheduleStart,
      'schedule_end': scheduleEnd,
      'subjects': subjects
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
