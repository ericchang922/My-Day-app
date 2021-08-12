import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:My_Day_app/public/serialize/schedule_serialize.dart';

class Get {
  BuildContext context;
  String uid;
  int scheduleNum;
  Map<String, String> data;
  ScheduleGet _response;

  _request() async {
    Request request = Request();
    await request.get(context, data);
    this._response = await request.getScheduleGet();
  }

  Get({
    this.context,
    this.uid = '',
    this.scheduleNum = 0,
  }) {
    data = {'uid': uid, 'scheduleNum': scheduleNum.toString()};
  }

  Future<ScheduleGet> getData() async {
    await _request();
    return this._response;
  }
}