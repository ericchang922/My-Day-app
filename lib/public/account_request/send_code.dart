

import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Sendcode {
  BuildContext context;
  String uid;
  Map<String, dynamic> data;

  bool _isError;//驗證帳號結果

  _request() async {
    Request request = Request();
    await request.sendcode(context, data);
    this._isError = await request.getIsError();
  }

  Sendcode({this.context, this.uid}) {
    data = {'uid': uid };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}

