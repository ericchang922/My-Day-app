import 'package:My_Day_app/models/timetable/main_timetable_list_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class MainTimetableList {
  BuildContext context;
  String uid;

  Map<String, String> _data;

  MainTimetableListGet _response;

  _request()async{
    Request request = Request();
    await request.mainTimetableListGet(context, _data);
    _response = request.getMainTimetableListGet();
  }

  MainTimetableList({this.context, this.uid}) {
    _data = {"uid": uid};
  }

  getData()async{
    await _request();
    return this._response;
  }
}
