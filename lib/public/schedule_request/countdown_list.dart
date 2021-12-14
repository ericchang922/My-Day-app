import 'package:My_Day_app/models/schedule/countdown_list_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class GetCountdownList {
  BuildContext context;
  String uid;
  Map<String, String> _data;
  CountdownList _response;

  _request() async {
    Request request = Request();
    await request.countdownList(context, _data);
    this._response = await request.getCountdownList();
  }

  GetCountdownList({this.context, this.uid}) {
    _data = {'uid': uid};
  }

  Future<CountdownList> getData() async {
    await _request();
    return this._response;
  }
}
