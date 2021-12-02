import 'package:My_Day_app/models/setting/get_location.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class GetLocation {
  BuildContext context;
  String uid;
  Map<String, String> data;
  GetLocationModel _response;

  _request() async {
    Request request = Request();
    await request.getlocation(context, data);
    _response = await request.getLocationGet();
  }

  GetLocation({this.context, this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
