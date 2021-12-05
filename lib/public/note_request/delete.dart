

import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class DeleteNote {
  BuildContext context;
  String uid;
  int noteNum;
  
  Map<String, dynamic> data;

  bool _isError;//編輯結果

  _request() async {
    Request request = Request();
    await request.noteDelete(context, data);
    this._isError = await request.getIsError();
  }

  DeleteNote({this.context, this.uid,this. noteNum}) {
    data = {'uid': uid, 'noteNum':  noteNum };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}

