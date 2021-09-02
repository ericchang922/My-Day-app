import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Sharing {
  BuildContext context;
  String uid;
  int studyplanNum;
  int groupNum;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.studyplanSharing(context, data);
    this._isError = await request.getIsError();
  }

  Sharing({this.context, this.uid, this.studyplanNum, this.groupNum}) {
    data = {'uid': uid, 'studyplanNum': studyplanNum, 'groupNum': groupNum};
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
