import 'package:My_Day_app/models/setting/get_timetable.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class GetTimetable {
  BuildContext context;
  String uid;
  Map<String, String> data;
  GetTimetableModel _response;

  _request() async {
    Request request = Request();
    await request.gettimetable(context, data);
    _response = await request.getTimetableGet();
  }

  GetTimetable({this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
