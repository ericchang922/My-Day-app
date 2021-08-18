import 'package:flutter/material.dart';

import 'package:My_Day_app/models/group/common_schedule_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class CommonList {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, String> data;
  CommonScheduleListModel _response;

  _request() async {
    Request request = Request();
    await request.scheduleCommonList(context, data);
    _response = await request.getCommonScheduleListGet();
  }

  CommonList({this.uid, this.groupNum}) {
    data = {'uid': uid, 'groupNum': groupNum.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
