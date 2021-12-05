import 'package:flutter/material.dart';

import 'package:My_Day_app/models/temporary_group/temporary_group_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class TemporaryList {
  BuildContext context;
  String uid;
  Map<String, String> data;
  TemporaryGroupListModel _response;

  _request() async {
    Request request = Request();
    await request.temporaryList(context, data);
    _response = await request.getTemporaryGroupListGet();
  }

  TemporaryList({this.context, this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
