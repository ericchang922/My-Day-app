// dart
import 'dart:convert';
// flutter
import 'package:My_Day_app/models/group/get_common_schedule_model.dart';
import 'package:flutter/material.dart';
// therd
import 'package:http/http.dart' as http;
// my day
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/toast.dart';
import 'package:My_Day_app/models/schedule/schedule_model.dart';

class Request {
  static const host = 'http://myday.sytes.net';
  static const Map path = {
    'account': '/account',
    'friend': '/friend',
    'group': '/group',
    'note': '/note',
    'schedule': '/schedule',
    'setting': '/setting',
    'studyplan': '/studyplan',
    'temporaryGroup': '/temporary_group',
    'timetable': '/timetable',
    'profile': '/profile',
    'vote': '/vote'
  };
  static Map scheduleUrl = {
    'create_new': '$host${path['schedule']}/create_new/',
    'edit': '$host${path['schedule']}/edit/',
    'delete': '$host${path['schedule']}/delete/',
    'get': '${path['schedule']}/get/',
    'get_list': '$host${path['schedule']}/get_list/',
    'create_common': '$host${path['schedule']}/create_common/',
    'get_common': '${path['schedule']}/get_common/',
    'common_list': '$host${path['schedule']}/common_list/',
    'common_hidden': '$host${path['schedule']}/common_hidden/',
    'countdown_list': '$host${path['schedule']}/countdown_list/',
  };

  Map<String, dynamic> _responseBody;
  ScheduleGet _scheduleGet;
  GetCommonScheduleModel _commenSchedule;
  bool _isError;

  Map headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  getScheduleGet() => _scheduleGet;
  getCommenSchedule() => _commenSchedule;
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
  scheduleCreateNew(BuildContext context, Map<String, dynamic> data) async {
    String _url = scheduleUrl['create_new'];
    await httpPost(context, data, _url, '新增成功');
  }

// edit -------------------------------------------------------------------------------------------
  scheduleEdit(BuildContext context, Map<String, dynamic> data) async {
    String _url = scheduleUrl['edit'];
    await httpPost(context, data, _url, '編輯成功');
  }

// create_common ----------------------------------------------------------------------------------
  scheduleCreateCommon(BuildContext context, Map<String, dynamic> data) async {
    String _url = scheduleUrl['create_common'];
    await httpPost(context, data, _url, '新增成功');
  }

// get --------------------------------------------------------------------------------------------
  scheduleGet(BuildContext context, Map<String, dynamic> data) async {
    String _url = scheduleUrl['get'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _scheduleGet = ScheduleGet.fromJson(_responseBody);
    }
  }
// get common -------------------------------------------------------------------------------------
  scheduleGetCommon(BuildContext context,Map<String,dynamic> data) async {
    String _url = scheduleUrl['get_common'];
    await httpGet(context, data, _url);
    if(_responseBody !=null){
      _commenSchedule = GetCommonScheduleModel.fromJson(_responseBody);
    }

  }
}
