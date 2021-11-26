import 'package:My_Day_app/models/setting/themes_model.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class GetThemes {
  BuildContext context;
  String uid;
  Map<String, String> data;
  GetThemesModel _response;

  _request() async {
    Request request = Request();
    await request.getthemes(context, data);
    _response = await request.getThemesGet();
  }

  GetThemes({this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
