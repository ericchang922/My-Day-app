import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class AddFriendReply {
  BuildContext context;
  String uid;
  String friendId;
  int relationId;
  Map<String, dynamic> data;

  bool _isError; //註冊結果

  _request() async {
    Request request = Request();
    await request.addReply(context, data);
    this._isError = await request.getIsError();
  }

  AddFriendReply({this.context, this.uid, this.friendId, this.relationId}) {
    data = {'uid': uid, 'friendId': friendId,'relationId': relationId};
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
