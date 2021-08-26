import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Vote {
  BuildContext context;
  int voteNum;
  List<int> voteItemNum;
  String uid;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.vote(context, data);
    this._isError = await request.getIsError();
  }

  Vote({
    this.context,
    this.voteNum,
    this.voteItemNum,
    this.uid,
  }) {
    data = {
      'voteNum': voteNum,
      'voteItemNum': voteItemNum,
      'uid': uid,
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
