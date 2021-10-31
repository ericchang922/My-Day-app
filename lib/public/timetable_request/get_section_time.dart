import 'package:My_Day_app/models/timetable/section_time_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class GetSectionTime {
  BuildContext context;
  String uid;
  Map<String, String> data;
  SectionTime _response;

  _request() async {
    Request request = Request();
    await request.sectionTime(context, data);
    this._response = await request.getSectionTime();
  }

  GetSectionTime({
    this.context,
    this.uid = '',
  }) {
    data = {'uid': uid};
  }

  Future<SectionTime> getData() async {
    await _request();
    return this._response;
  }
}
