import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class InviteFriend {
  BuildContext context;
  String uid;
  int groupNum;
  List<Map<String, dynamic>> friend;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.groupInviteFriend(context, data);
    this._isError = await request.getIsError();
  }

  InviteFriend(
      {this.context,
      this.uid,
      this.groupNum,
      this.friend}) {
    data = {
      'uid': uid,
      'groupNum': groupNum,
      'friend': friend
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
