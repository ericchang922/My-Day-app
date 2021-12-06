import 'package:My_Day_app/models/studyplan/studyplan_list_model.dart';
import 'package:My_Day_app/public/request.dart';

import 'package:flutter/material.dart';

class PersonalList {
  BuildContext context;
  String uid;
  int studyplanNum;
  Map<String, String> _data;
  StudyplanListModel _response;

  _request() async {
    Request request = Request();
    await request.studyplanPersonalList(context, _data);
    this._response = await request.getStudyplanList();
  }

  PersonalList({this.context, this.uid, this.studyplanNum}) {
    _data = {'uid': uid};
  }

  Future<StudyplanListModel> getData() async {
    await _request();
    return this._response;
  }
}
