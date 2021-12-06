import 'package:My_Day_app/models/setting/get_temporary_notice.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class GetTimetableNotice {
  BuildContext context;
  String uid;
  Map<String, String> data;
  GetTimetableNoticeModel _response;

  _request() async {
    Request request = Request();
    await request.getTimetableNotice(context, data);
    _response = await request.getTimetableNoticeGet();
  }

  GetTimetableNotice({this.context, this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
