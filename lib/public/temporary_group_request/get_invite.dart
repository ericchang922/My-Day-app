import 'package:flutter/material.dart';

import 'package:My_Day_app/models/temporary_group/get_temporary_group_invitet_model.dart';
import 'package:My_Day_app/public/request.dart';

class GetInvite {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, String> data;
  GetTemporaryGroupInviteModel _response;

  _request() async {
    Request request = Request();
    await request.temporaryGetInvite(context, data);
    _response = await request.getTemporaryGroupInviteGet();
  }

  GetInvite({this.uid, this.groupNum}) {
    data = {'uid': uid, 'groupNum': groupNum.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
