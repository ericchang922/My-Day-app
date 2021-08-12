import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CreateNew {
  BuildContext context;
  String uid;
  String title;
  String startTime = DateTime.now().toString();
  String endTime = DateTime.now().add(Duration(hours: 1)).toString();
  Map remind;
  int typeId;
  bool isCountdown;
  String place;
  String remark;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.createNew(context, data);
    this._isError = await request.getIsError();
  }

  CreateNew({
    this.context,
    this.uid = '',
    this.title = '新增行程',
    this.startTime,
    this.endTime,
    this.remind,
    this.typeId = 8,
    this.isCountdown = false,
    this.place,
    this.remark,
  }) {
    data = {
      'uid': uid,
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