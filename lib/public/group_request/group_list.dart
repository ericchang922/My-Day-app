import 'package:flutter/material.dart';

import 'package:My_Day_app/models/group/group_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class GroupList {
  BuildContext context;
  String uid;
  Map<String, String> data;
  GroupListModel _response;

  _request() async {
    Request request = Request();
    await request.groupList(context, data);
    _response = await request.getGroupListGet();
  }

  GroupList({this.context, this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
