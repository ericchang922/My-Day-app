import 'package:My_Day_app/models/timetable/sharecode_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class Sharecode {
  BuildContext context;
  String uid;
  int timetableNo;

  Map<String, String> _data;

  SharecodeModel _response;

  _request() async {
    Request request = Request();
    await request.sharecode(context, _data);
    _response = request.getSharecode();
  }

  Sharecode({this.context, this.uid, this.timetableNo}) {
    _data = {"uid": uid, 'timetableNo': timetableNo.toString()};
  }

  Future<SharecodeModel> getData() async {
    await _request();
    return this._response;
  }
}
