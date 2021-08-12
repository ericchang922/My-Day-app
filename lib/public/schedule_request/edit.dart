import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Edit {
  BuildContext context;
  String uid;
  int scheduleNum;
  String title;
  String startTime;
  String endTime;
  Map remind;
  int typeId;
  bool isCountdown;
  String place;
  String remark;
  Map<String, dynamic> data = {};

  bool _isError;

  _request() async {
    Request request = Request();
    await request.edit(context, data);
    this._isError = await request.getIsError();
  }

  Edit({
    this.context,
    this.uid,
    this.scheduleNum,
    this.title,
    this.startTime,
    this.endTime,
    this.remind,
    this.typeId,
    this.isCountdown,
    this.place,
    this.remark,
  }) {
    data = {
      'uid': uid,
      'scheduleNum': scheduleNum,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'typeId': typeId,
      'isCountdown': isCountdown,
      'place': place,
      'remark': remark
    };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
