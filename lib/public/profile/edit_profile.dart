

import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class EditProfile {
  BuildContext context;
  String uid;
  String userName;
  String photo;
  Map<String, dynamic> data;

  bool _isError;//編輯結果

  _request() async {
    Request request = Request();
    await request.editprofile(context, data);
    this._isError = await request.getIsError();
  }

  EditProfile({this.context, this.uid,this. userName, this. photo}) {
    data = {'uid': uid, 'userName': userName ,'photo':  photo };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}

