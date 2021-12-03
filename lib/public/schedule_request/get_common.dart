import 'package:flutter/material.dart';

import 'package:My_Day_app/models/group/get_common_schedule_model.dart';
import 'package:My_Day_app/public/request.dart';

class GetCommon {
  BuildContext context;
  String uid;
  int scheduleNum;
  Map<String, String> data;
  GetCommonScheduleModel _response;

  _request() async {
    Request request = Request();
    await request.scheduleGetCommon(context, data);
    _response = await request.getCommenScheduleGet();
  }

  GetCommon({this.context, this.uid, this.scheduleNum}) {
    data = {'uid': uid, 'scheduleNum': scheduleNum.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
