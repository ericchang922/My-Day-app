import 'package:My_Day_app/models/friend/make_friend_invite_list_model.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class MakeFriendInviteList {
  BuildContext context;
  String uid;
  Map<String, String> data;
  MakeFriendInviteListModel _response;

  _request() async {
    Request request = Request();
    await request.makeFriendInviteList(context, data);
    _response = await request.getMakeFriendInviteListGet();
  }

  MakeFriendInviteList({this.context, this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
