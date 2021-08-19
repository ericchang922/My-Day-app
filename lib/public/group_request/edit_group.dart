import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class EditGroup {
  BuildContext context;
  String uid;
  int groupNum;
  String title;
  int typeId;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.groupEdit(context, data);
    this._isError = await request.getIsError();
  }

  EditGroup({this.context, this.uid, this.groupNum, this.title, this.typeId}) {
    data = {'uid': uid, 'groupNum': groupNum, 'title': title, 'typeId': typeId};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
