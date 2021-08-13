import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class MemberStatus {
  BuildContext context;
  String uid;
  int groupNum;
  int statusId;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.memberStatus(context, data);
    this._isError = await request.getIsError();
  }

  MemberStatus({this.context, this.uid, this.groupNum, this.statusId}) {
    data = {'uid': uid, 'groupNum': groupNum, 'statusId': statusId};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
