import 'package:flutter/material.dart';

import 'package:My_Day_app/models/group/group_log_model.dart';
import 'package:My_Day_app/public/request.dart';

class GetLog {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, String> data;
  GroupLogModel _response;

  _request() async {
    Request request = Request();
    await request.groupGetLog(context, data);
    _response = await request.getGroupLogGet();
  }

  GetLog({this.context, this.uid, this.groupNum}) {
    data = {'uid': uid, 'groupNum': groupNum.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
