import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CreateGroup {
  BuildContext context;
  String uid;
  String groupName;
  String scheduleStart;
  String scheduleEnd;
  int type;
  String place;
  List<Map<String, dynamic>> friend;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.temporaryCreateGroup(context, data);
    this._isError = await request.getIsError();
  }

  CreateGroup(
      {this.context,
      this.uid,
      this.groupName,
      this.scheduleStart,
      this.scheduleEnd,
      this.type,
      this.place,
      this.friend}) {
    data = {
      'founder': uid,
      'group_name': groupName,
      'schedule_start': scheduleStart,
      'schedule_end': scheduleEnd,
      'type': type,
      'place': place,
      'friend': friend
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
