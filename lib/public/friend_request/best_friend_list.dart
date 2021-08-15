import 'package:flutter/material.dart';

import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class BestFriendList {
  BuildContext context;
  String uid;
  Map<String, String> data;
  BestFriendListModel _response;

  _request() async {
    Request request = Request();
    await request.bestFriendList(context, data);
    _response = await request.bestFriendGet();
  }

  BestFriendList({this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
