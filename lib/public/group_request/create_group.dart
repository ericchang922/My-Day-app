import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CreateGroup {
  BuildContext context;
  String uid;
  String groupName;
  int type;
  List<Map<String, dynamic>> friend;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.groupCreate(context, data);
    this._isError = await request.getIsError();
  }

  CreateGroup(
      {this.context,
      this.uid,
      this.groupName,
      this.type,
      this.friend}) {
    data = {
      'founder': uid,
      'group_name': groupName,
      'type': type,
      'friend': friend
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
