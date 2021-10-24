import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Delete {
  BuildContext context;
  String uid;
  int studyplanNum;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.studyplanDelete(context, data);
    this._isError = await request.getIsError();
  }

  Delete({this.context, this.uid, this.studyplanNum}) {
    data = {
      'uid': uid,
      'studyplanNum': studyplanNum,
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
