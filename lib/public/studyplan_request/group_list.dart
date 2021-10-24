import 'package:My_Day_app/models/schedule/group_studyplan_list_model.dart';
import 'package:My_Day_app/public/request.dart';

import 'package:flutter/material.dart';

class GroupList {
  BuildContext context;
  String uid;
  int studyplanNum;
  Map<String, String> _data;
  GroupStudyplanListModel _response;

  _request() async {
    Request request = Request();
    await request.studyplanGroupList(context, _data);
    this._response = await request.getGroupStudyplanList();
  }

  GroupList({this.uid, this.studyplanNum}) {
    _data = {'uid': uid};
  }

  Future<GroupStudyplanListModel> getData() async {
    await _request();
    return this._response;
  }
}
