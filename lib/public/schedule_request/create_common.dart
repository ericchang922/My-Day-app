import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CreateCommon {
  BuildContext context;
  String uid;
  int groupNum;
  String title;
  String startTime;
  String endTime;
  int typeId;
  String place;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.createCommon(context, data);
    this._isError = await request.getIsError();
  }

  CreateCommon({
    this.context,
    this.uid,
    this.title,
    this.groupNum,
    this.startTime,
    this.endTime,
    this.typeId,
    this.place,
  }) {
    data = {
      'uid': uid,
      'groupNum': groupNum,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'typeId': typeId,
      'place': place,
    };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
