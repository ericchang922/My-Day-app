import 'package:My_Day_app/models/schedule/schedule_list_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class GetList {
  BuildContext context;
  String uid;
  Map<String, String> _data;
  ScheduleGetList _response;

  _request() async {
    Request request = Request();
    await request.scheduleGetList(context, _data);
    this._response = await request.getScheduleGetList();
  }

  GetList({this.context, this.uid}) {
    _data = {'uid': uid};
  }

  Future<ScheduleGetList> getData() async {
    await _request();
    return this._response;
  }
}
