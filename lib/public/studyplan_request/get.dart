import 'package:My_Day_app/models/studyplan/studyplan_model.dart';
import 'package:My_Day_app/public/request.dart';

import 'package:flutter/material.dart';

class Get {
  BuildContext context;
  String uid;
  int studyplanNum;
  Map<String, String> _data;
  StudyplanModel _response;

  _request() async {
    Request request = Request();
    await request.studyplanGet(context, _data);
    this._response = await request.getStudyplan();
  }

  Get({this.context, this.uid, this.studyplanNum}) {
    _data = {'uid': uid, 'studyplanNum': studyplanNum.toString()};
  }

  Future<StudyplanModel> getData() async {
    await _request();
    return this._response;
  }
}
