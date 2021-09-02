import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Share {
  BuildContext context;
  String uid;
  int groupNum;
  int noteNum;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.noteShare(context, data);
    this._isError = await request.getIsError();
  }

  Share({this.context, this.uid, this.groupNum, this.noteNum}) {
    data = {'uid': uid, 'groupNum': groupNum, 'noteNum': noteNum};
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
