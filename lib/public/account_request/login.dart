import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Login {
  BuildContext context;
  String uid;
  String password;
  Map<String, String> data;
  bool _isError;//回傳姓名

 _request() async {
    Request request = Request();
    await request.login(context, data);
    this._isError = await request.getIsError();
  }

  Login({this.context, this.uid, this.password }) {
    data = {'uid': uid, 'password': password };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
