import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class EditNote {
  BuildContext context;
  String uid;
  int noteNum;
  String typeName;
  String title;
  String content;
  Map<String, dynamic> data;

  bool _isError; //編輯結果

  _request() async {
    Request request = Request();
    await request.noteEdit(context, data);
    this._isError = await request.getIsError();
  }

  EditNote(
      {this.context,
      this.uid,
      this.noteNum,
      this.typeName,
      this.title,
      this.content}) {
    data = {
      'uid': uid,
      'noteNum': noteNum,
      'typeName': typeName,
      'title': title,
      'content': content
    };
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
