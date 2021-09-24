import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class EditStudyplan {
  BuildContext context;
  String uid;
  int studyplanNum;
  String scheduleName;
  String scheduleStart;
  String scheduleEnd;
  bool isAuthority;
  List<Map<String, dynamic>> subjects;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.studyplanEdit(context, data);
    this._isError = await request.getIsError();
  }

  EditStudyplan(
      {this.context,
      this.uid,
      this.studyplanNum,
      this.scheduleName,
      this.scheduleStart,
      this.scheduleEnd,
      this.isAuthority,
      this.subjects}) {
    data = {
      'uid': uid,
      'studyplanNum': studyplanNum,
      'schedule_name': scheduleName,
      'schedule_start': scheduleStart,
      'schedule_end': scheduleEnd,
      'is_authority': isAuthority,
      'subjects': subjects
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
