import 'package:flutter/material.dart';

import 'package:My_Day_app/models/group/get_group_model.dart';
import 'package:My_Day_app/public/request.dart';

class Get {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, String> data;
  GetGroupModel _response;

  _request() async {
    Request request = Request();
    await request.groupGet(context, data);
    _response = await request.getGroupGet();
  }

  Get({this.uid, this.groupNum}) {
    data = {'uid': uid, 'groupNum': groupNum.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
