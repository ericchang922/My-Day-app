import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CreateNewNote {
  BuildContext context;
  String uid;
  String typeName;
  String title;
  String content;
  Map<String, dynamic> data;

  bool _isError;//註冊結果

  _request() async {
    Request request = Request();
    await request.createNew(context, data);
    this._isError = await request.getIsError();
  }

  CreateNewNote({this.context, this.uid, this. typeName, this.title, this.content }) {
    data = {'uid': uid, 'typeName':  typeName , 'title':title, 'content':content};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}