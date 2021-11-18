import 'package:flutter/material.dart';

import 'package:My_Day_app/public/request.dart';

class PrivacyLocation {
  BuildContext context;
  String uid;
  bool isLocation;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.privacylocation(context, data);
    this._isError = await request.getIsError();
  }

  PrivacyLocation({this.context, this.uid, this.isLocation }) {
    data = {'uid': uid, 'isLocation': isLocation};
  }
  getIsError() async {
    await _request();
    return this._isError;
  }
}
