

import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class ForgetPw {
  BuildContext context;
  String uid;
  String verificationCode;
  
  Map<String, dynamic> data;

  bool _isError;//驗證結果

  _request() async {
    Request request = Request();
    await request.forgetpw(context, data);
    this._isError = await request.getIsError();
  }

  ForgetPw({this.context, this.uid, this.verificationCode }) {
    data = {'uid': uid, 'verificationCode': verificationCode };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}

