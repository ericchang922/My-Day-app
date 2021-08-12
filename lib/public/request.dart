// dart
import 'dart:convert';
// flutter
import 'package:flutter/material.dart';
// therd
import 'package:http/http.dart' as http;
// my day
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/toast.dart';
import 'package:My_Day_app/public/serialize/schedule_serialize.dart';

class Request {
  static const host = 'http://myday.sytes.net';
  static const path = '/schedule';
  static const url = {
    'create_new': '$host$path/create_new/',
    'edit': '$host$path/edit/',
    'delete': '$host$path/delete/',
    'get': '$path/get/',
    'get_list': '$host$path/get_list/',
    'create_common': '$host$path/create_common/',
    'get_common': '$host$path/get_common/',
    'common_list': '$host$path/common_list/',
    'common_hidden': '$host$path/common_hidden/',
    'countdown_list': '$host$path/countdown_list/',
  };

  Map<String, dynamic> _responseBody;
  ScheduleGet _scheduleGet;
  bool _isError;

  Map headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  getScheduleGet() => _scheduleGet;
  getIsError() => _isError;
  httpFunction(BuildContext context, dynamic response, String toastTxt) async {
    Map responseBody = json.decode(utf8.decode(response.bodyBytes));
    if (responseBody['response'] == false) {
      await alert(context, '錯誤', responseBody['message']);
      _responseBody = null;
      _isError = true;
    } else if (responseBody['response'] == true) {
      _isError = false;
      if (toastTxt != null)
        toast(context, toastTxt);
      else
        _responseBody = json.decode(utf8.decode(response.bodyBytes));
    }

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');
  }

  httpGet(BuildContext context, Map<String, String> data, String _url) async {
    Uri _uri = Uri.http('myday.sytes.net', _url, data);
    dynamic response = await http.get(_uri, headers: headers);
    await httpFunction(context, response, null);
  }

  httpPost(BuildContext context, Map<String, dynamic> data, String _url,
      String toastTxt) async {
    Uri _uri = Uri.parse(_url);
    dynamic response =
        await http.post(_uri, headers: headers, body: json.encode(data));
    await httpFunction(context, response, toastTxt);
  }

// create_new -------------------------------------------------------------------------------------
  createNew(BuildContext context, Map<String, dynamic> data) async {
    String _url = url['create_new'];
    await httpPost(context, data, _url, '新增成功');
  }

// edit -------------------------------------------------------------------------------------------
  edit(BuildContext context, Map<String, dynamic> data) async {
    String _url = url['edit'];
    await httpPost(context, data, _url, '編輯成功');
  }

// create_common ----------------------------------------------------------------------------------
  createCommon(BuildContext context, Map<String, dynamic> data) async {
    String _url = url['create_common'];
    await httpPost(context, data, _url, '新增成功');
  }

// get --------------------------------------------------------------------------------------------
  get(BuildContext context, Map<String, dynamic> data) async {
    String _url = url['get'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _scheduleGet = ScheduleGet.fromJson(_responseBody);
    }
  }
}













