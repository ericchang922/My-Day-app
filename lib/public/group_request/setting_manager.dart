import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class SettingManager {
  BuildContext context;
  String uid;
  String friendId;
  int groupNum;
  int statusId;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.groupSettingManager(context, data);
    this._isError = await request.getIsError();
  }

  SettingManager({this.context, this.uid, this.friendId, this.groupNum, this.statusId}) {
    data = {'uid': uid, 'friendId': friendId, 'groupNum': groupNum, 'statusId': statusId};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}