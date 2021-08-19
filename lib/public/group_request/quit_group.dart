import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class QuitGroup {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.groupQuit(context, data);
    this._isError = await request.getIsError();
  }

  QuitGroup({this.context, this.uid, this.groupNum}) {
    data = {'uid': uid, 'groupNum': groupNum};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
