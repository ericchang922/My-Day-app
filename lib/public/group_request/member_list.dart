import 'package:flutter/material.dart';

import 'package:My_Day_app/models/group/group_member_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class MemberList {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, String> data;
  GroupMemberListModel _response;

  _request() async {
    Request request = Request();
    await request.groupMemberList(context, data);
    _response = await request.getGroupMemberListGet();
  }

  MemberList({this.uid, this.groupNum}) {
    data = {'uid': uid, 'groupNum': groupNum.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
