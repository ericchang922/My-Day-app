

import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class DeleteBestFriend {
  BuildContext context;
  String uid;
  String friendId;
  
  Map<String, dynamic> data;

  bool _isError;//註冊結果

  _request() async {
    Request request = Request();
    await request.bestFriendDelete(context, data);
    this._isError = await request.getIsError();
  }

  DeleteBestFriend({this.context, this.uid, this.friendId }) {
    data = {'uid': uid, 'friendId': friendId };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}

