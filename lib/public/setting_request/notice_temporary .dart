import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class NoticeTemporary {
  BuildContext context;
  String uid;
  bool isTemporary	;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.noticeTemporary(context, data);
    this._isError = await request.getIsError();
  }

  NoticeTemporary({this.context, this.uid, this.isTemporary	}) {
    data = {'uid': uid, 'isTemporary	': isTemporary	};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
