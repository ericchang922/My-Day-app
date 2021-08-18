import 'package:flutter/material.dart';

import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class FriendList {
  BuildContext context;
  String uid;
  Map<String, String> data;
  FriendListModel _response;

  _request() async {
    Request request = Request();
    await request.friendList(context, data);
    _response = await request.getFriendListGet();
  }

  FriendList({this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
