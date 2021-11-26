
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Themes{
  BuildContext context;
  String uid;
  int themeId;
  Map<String,dynamic> data;
  bool _isError;//

  _request() async {
    Request request = Request();
    await request.themes(context, data);
    this._isError = await request.getIsError();
  }

  Themes({this.context, this.uid, this.themeId }) {
    data = {'uid': uid, 'themeId': themeId};
  }

  getData() async {
    await _request();
    return this._isError;
  }
}
