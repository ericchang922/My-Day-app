import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CancelSharing {
  BuildContext context;
  String uid;
  int studyplanNum;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.studyplanCancelSharing(context, data);
    this._isError = await request.getIsError();
  }

  CancelSharing({this.context, this.uid, this.studyplanNum}) {
    data = {'uid': uid, 'studyplanNum': studyplanNum};
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
