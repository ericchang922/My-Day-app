import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class AddItems {
  BuildContext context;
  String uid;
  int voteNum;
  List<Map<String, dynamic>> voteItems;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.voteAddItems(context, data);
    this._isError = await request.getIsError();
  }

  AddItems({
    this.context,
    this.uid,
    this.voteNum,
    this.voteItems,
  }) {
    data = {
      'uid': uid,
      'voteNum': voteNum,
      'voteItems': voteItems,
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
