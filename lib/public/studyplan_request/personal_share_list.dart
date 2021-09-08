import 'package:My_Day_app/models/studyplan/personal_share_studyplan.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class PersonalShareList {
  BuildContext context;
  String uid;
  int shareStatus;
  Map<String, String> _data;
  PersonalShareStudyplanListModel _response;

  _request() async {
    Request request = Request();
    await request.studyplanPersonalShareList(context, _data);
    this._response = await request.getPersonalShareStudyplanList();
  }

  PersonalShareList({this.uid, this.shareStatus}) {
    _data = {'uid': uid, 'shareStatus': shareStatus.toString()};
  }

  Future<PersonalShareStudyplanListModel> getData() async {
    await _request();
    return this._response;
  }
}
