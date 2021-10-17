import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class FriendPrivacy {
  BuildContext context;
  String uid;
  String friendId;
  bool isPublic;
  bool isTemporary;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.friendprivacy(context, data);
    this._isError = await request.getIsError();
  }

  FriendPrivacy({this.context, this.uid, this.friendId, this.isPublic, this.isTemporary}) {
    data = {'uid': uid, 'friendId': friendId, 'isPublic': isPublic, 'isTemporary': isTemporary};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
