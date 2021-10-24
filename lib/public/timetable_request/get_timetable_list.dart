import 'package:My_Day_app/models/timetable/timetable_list_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class GetTimetableList {
  BuildContext context;
  String uid;

  Map<String, String> _data;

  TimetableListModel _response;

  _request()async{
    Request request = Request();
    await request.timetableList(context, _data);
    _response = request.getTimetableList();
  }

  GetTimetableList({this.context, this.uid}) {
    _data = {"uid": uid};
  }

  Future<TimetableListModel> getData()async{
    await _request();
    return this._response;
  }
}
