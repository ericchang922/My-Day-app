import 'package:My_Day_app/models/setting/get_friend_privacy.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class GetFriendPrivacy {
  BuildContext context;
  String uid;
  String friendId;
  Map<String, String> data;
  GetFriendPrivacyModel _response;

  _request() async {
    Request request = Request();
    await request.getfriendprivacy(context, data);
    _response = await request.getFriendPrivacyGet();
  }

  GetFriendPrivacy({this.uid,this.friendId}) {
    data = {'uid': uid,'friendId': friendId};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
