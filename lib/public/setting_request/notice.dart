import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class Notice {
  BuildContext context;
  String uid;
  bool isSchedule;
  bool isCountdown;
  bool isGroup;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.notice(context, data);
    this._isError = await request.getIsError();
  }

  Notice({this.context, this.uid, this.isSchedule, this.isCountdown, this.isGroup  }) {
    data = {'uid': uid, 'isSchedule': isSchedule, 'isCountdown': isCountdown, 'isGroup': isGroup};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
