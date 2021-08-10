import 'dart:convert';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/toast.dart';
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

  edit(BuildContext context, Map<String, dynamic> data) async {
    Uri _url = Uri.parse(url['edit']);
    dynamic response = await http.post(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data));
    var responseBody = json.decode(utf8.decode(response.bodyBytes));

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');

    if (responseBody['response'] == false) {
      await alert(context, '錯誤', responseBody['message']);
    } else if (responseBody['response'] == true) {
      toast(context, "編輯成功");
    }
  }

  createCommon(BuildContext context, Map<String, dynamic> data) async {
    Uri _url = Uri.parse(url['create_common']);
    dynamic response = await http.post(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data));
    var responseBody = json.decode(utf8.decode(response.bodyBytes));

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');

    if (responseBody['response'] == false) {
      await alert(context, '錯誤', responseBody['message']);
    } else if (responseBody['response'] == true) {
      toast(context, "新增成功");
    }
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

class Edit {
  BuildContext context;
  String uid;
  int scheduleNum;
  String title;
  String startTime;
  String endTime;
  Map remind;
  int typeId;
  bool isCountdown;
  String place;
  String remark;
  Map<String, dynamic> data;

  Edit({
    this.context,
    this.uid,
    this.scheduleNum,
    this.title,
    this.startTime,
    this.endTime,
    this.remind,
    this.typeId,
    this.isCountdown,
    this.place,
    this.remark,
  }) {
    data = {
      'uid': uid,
      'scheduleNum': scheduleNum,
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
    request.edit(context, data);
  }
}

class CreateCommon {
  BuildContext context;
  String uid;
  int groupNum;
  String title;
  String startTime = DateTime.now().toString();
  String endTime = DateTime.now().add(Duration(hours: 1)).toString();
  int typeId;
  String place;
  Map<String, dynamic> data;

  CreateCommon({
    this.context,
    this.uid,
    this.title,
    this.groupNum,
    this.startTime,
    this.endTime,
    this.typeId,
    this.place,
  }) {
    data = {
      'uid': uid,
      'groupNum': groupNum,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'typeId': typeId,
      'place': place,
    };
    _Request request = _Request();
    request.createCommon(context, data);
  }
}

class CommonList with _Request {
  BuildContext context;
  String uid;
  int groupNum;
  CommonList(this.uid, this.groupNum);

  commonList() async {
    Uri _url = Uri.parse(_Request.url['common_list'] +
        "?uid=" +
        uid +
        "&groupNum=" +
        groupNum.toString());
    dynamic response = await http.get(_url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var responseBody = json.decode(utf8.decode(response.bodyBytes));

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');
    print(responseBody);
    print(responseBody["response"]);

    if (responseBody["response"] == false) {
      await alert(context, '錯誤', responseBody['message']);
    } else if (responseBody["response"] == true) {
      return responseBody;
    }
  }
}

class GetCommon with _Request {
  BuildContext context;
  String uid;
  int scheduleNum;
  GetCommon(this.uid, this.scheduleNum);

  getCommon() async {
    Uri _url = Uri.parse(_Request.url['get_common'] +
        "?uid=" +
        uid +
        "&scheduleNum=" +
        scheduleNum.toString());
    dynamic response = await http.get(_url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var responseBody = json.decode(utf8.decode(response.bodyBytes));

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');
    print(responseBody);
    print(responseBody["response"]);

    if (responseBody["response"] == false) {
      await alert(context, '錯誤', responseBody['message']);
    } else if (responseBody["response"] == true) {
      return responseBody;
    }
  }
}
