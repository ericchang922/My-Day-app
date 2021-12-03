import 'package:My_Day_app/models/profile/profile_list.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class GetProfileList {
  BuildContext context;
  String uid;
  Map<String, String> data;
  GetProfileListModel _response;

  _request() async {
    Request request = Request();
    await request.getprofilelist(context, data);
    _response = await request.getProfileListGet();
  }

  GetProfileList({this.context, this.uid}) {
    data = {'uid': uid};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
