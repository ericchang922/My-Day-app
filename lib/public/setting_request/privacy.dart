import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class Privacy {
  BuildContext context;
  String uid;
  bool isLocation;
  bool isPublic;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.privacy(context, data);
    this._isError = await request.getIsError();
  }

  Privacy({this.context, this.uid, this.isLocation, this.isPublic }) {
    data = {'uid': uid, 'isLocation': isLocation, 'isPublic': isPublic};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
