import 'package:My_Day_app/models/setting/get_notice.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class GetNotice {
  BuildContext context;
  String uid;
  Map<String, String> data;
  GetNoticeModel _response;

  _request() async {
    Request request = Request();
    await request.getNotice(context, data);
    _response = await request.getNoticeGet();
  }

  GetNotice({this.context, this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
