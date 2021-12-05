import 'package:flutter/material.dart';

import 'package:My_Day_app/models/group/group_invite_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class InviteList {
  BuildContext context;
  String uid;
  Map<String, String> data;
  GroupInviteListModel _response;

  _request() async {
    Request request = Request();
    await request.groupInviteList(context, data);
    _response = await request.getGroupInviteListGet();
  }

  InviteList({this.context, this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
