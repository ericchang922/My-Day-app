

import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Register {
  BuildContext context;
  String uid;
  String userName;
  String password;
  
  Map<String, dynamic> data;

  bool _isError;//註冊結果

  _request() async {
    Request request = Request();
    await request.register(context, data);
    this._isError = await request.getIsError();
  }

  Register({this.context, this.uid, this.userName, this.password }) {
    data = {'uid': uid, 'userName': userName, 'password': password };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}

