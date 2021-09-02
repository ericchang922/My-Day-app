import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CancelShare {
  BuildContext context;
  String uid;
  int noteNum;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.noteCancelShare(context, data);
    this._isError = await request.getIsError();
  }

  CancelShare({this.context, this.uid, this.noteNum}) {
    data = {'uid': uid, 'noteNum': noteNum};
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
