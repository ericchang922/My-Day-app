import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Delete {
  BuildContext context;
  String uid;
  int scheduleNum;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.scheduleDelete(context, data);
    this._isError = await request.getIsError();
  }

  Delete({
    this.context,
    this.uid,
    this.scheduleNum,
  }) {
    data = {
      'uid': uid,
      'scheduleNum': scheduleNum,
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
