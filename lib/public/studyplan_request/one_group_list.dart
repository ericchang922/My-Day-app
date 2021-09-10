import 'package:My_Day_app/models/studyplan/share_studyplan_list_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class OneGroupList {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, String> _data;
  ShareStudyplanListModel _response;

  _request() async {
    Request request = Request();
    await request.studyplanOneGroupList(context, _data);
    this._response = await request.getShareStudyplanList();
  }

  OneGroupList({this.uid, this.groupNum}) {
    _data = {'uid': uid, 'groupNum': groupNum.toString()};
  }

  Future<ShareStudyplanListModel> getData() async {
    await _request();
    return this._response;
  }
}
