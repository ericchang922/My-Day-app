import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Delete {
  BuildContext context;
  String uid;
  int voteNum;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.voteDelete(context, data);
    this._isError = await request.getIsError();
  }

  Delete({
    this.context,
    this.uid,
    this.voteNum,
  }) {
    data = {
      'uid': uid,
      'voteNum': voteNum,
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
