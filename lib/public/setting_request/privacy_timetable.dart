import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class PrivacyTimetable {
  BuildContext context;
  String uid;
  bool isPublic;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.privacyTimetable(context, data);
    this._isError = await request.getIsError();
  }

  PrivacyTimetable({this.context, this.uid, this.isPublic }) {
    data = {'uid': uid, 'isPublic': isPublic};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
