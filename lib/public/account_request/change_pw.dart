import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class ChangePw {
  BuildContext context;
  String uid;
  String password;
  
  Map<String, dynamic> data;

  bool _isError;//註冊結果

  _request() async {
    Request request = Request();
    await request.changepw(context, data);
    this._isError = await request.getIsError();
  }

  ChangePw({this.context, this.uid, this.password }) {
    data = {'uid': uid, 'password': password };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}

