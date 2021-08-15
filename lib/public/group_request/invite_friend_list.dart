import 'package:flutter/material.dart';

import 'package:My_Day_app/models/group/group_invite_friend_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class InviteFriendList {
  BuildContext context;
  String uid;
  int groupNum;
  int friendStatusId;

  Map<String, String> data;
  GroupInviteFriendListModel _response;

  _request() async {
    Request request = Request();
    await request.groupInviteFriendList(context, data);
    _response = await request.groupInviteFriendListGet();
  }

  InviteFriendList({this.uid, this.groupNum, this.friendStatusId}) {
    data = {'uid': uid, 'groupNum': groupNum.toString(), 'friendStatusId':friendStatusId.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
