import 'dart:convert';
import 'package:My_Day_app/public/alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class _Request {
  static const host = 'http://myday.sytes.net';
  static const path = '/schedule';
  static const url = {
    'create_new': '$host$path/create_new/',
    'edit': '$host$path/edit/',
    'delete': '$host$path/delete/',
    'get': '$host$path/get/',
    'get_list': '$host$path/get_list/',
    'create_common': '$host$path/create_common/',
    'get_common': '$host$path/get_common/',
    'common_list': '$host$path/common_list/',
    'common_hidden': '$host$path/common_hidden/',
    'countdown_list': '$host$path/countdown_list/',
  };

  createNew(BuildContext context, Map<String, dynamic> data) async {
    Uri _url = Uri.parse(url['create_new']);
    dynamic response = await http.post(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data));
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    if (responseBody['response'] == false) {
      await alert(context, '錯誤', responseBody['message']);
    }

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');
  }
}

class CreateNew {
  BuildContext context;
  String uid;
  String title;
  String startTime = DateTime.now().toString();
  String endTime = DateTime.now().add(Duration(hours: 1)).toString();
  Map remind;
  int typeId;
  bool isCountdown;
  String place;
  String remark;
  Map<String, dynamic> data;

  CreateNew({
    this.context,
    this.uid = '',
    this.title = '新增行程',
    this.startTime,
    this.endTime,
    this.remind,
    this.typeId = 8,
    this.isCountdown = false,
    this.place,
    this.remark,
  }) {
    data = {
      'uid': uid,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'typeId': typeId,
      'isCountdown': isCountdown,
      'place': place,
      'remark': remark
    };

    _Request request = _Request();
    request.createNew(context, data);
  }
}
