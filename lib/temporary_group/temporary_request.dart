import 'dart:convert';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class _Request {
  static const host = 'http://myday.sytes.net';
  static const path = '/temporary_group';
  static const url = {
    'create_group': '$host$path/create_group/',
    'invite_list': '$host$path/invite_list/',
    'temporary_list': '$host$path/temporary_list/',
    'get_invite': '$host$path/get_invite/',
  };

  // createGroup(BuildContext context, Map<String, dynamic> data) async {
  //   Uri _url = Uri.parse(url['create_group']);
  //   dynamic response = await http.post(_url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: json.encode(data));
  //   var responseBody = json.decode(utf8.decode(response.bodyBytes));
  //   if (responseBody['response'] == false) {
  //     await alert(context, '錯誤', responseBody['message']);
  //   } else if (responseBody['response'] == true) {
  //     toast(context, "建立成功");
  //   }

  //   print('statusCode: ${response.statusCode}');
  //   print('body: ${utf8.decode(response.bodyBytes)}');
  // }
}

class CreateGroup with _Request {
  BuildContext context;
  String uid;
  String groupName;
  String scheduleStart;
  String scheduleEnd;
  int type;
  String place;
  List<Map<String, dynamic>> friend;
  Map<String, dynamic> data;

  CreateGroup(
      {this.context,
      this.uid,
      this.groupName,
      this.scheduleStart,
      this.scheduleEnd,
      this.type,
      this.place,
      this.friend}) {
    data = {
      'founder': uid,
      'group_name': groupName,
      'schedule_start': scheduleStart,
      'schedule_end': scheduleEnd,
      'type': type,
      'place': place,
      'friend': friend
    };
  }

  createGroup() async {
    Uri _url = Uri.parse(_Request.url['create_group']);
    dynamic response = await http.post(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data));
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    if (responseBody['response'] == false) {
      await alert(context, '錯誤', responseBody['message']);
    } else if (responseBody['response'] == true) {
      toast(context, "建立成功");
      return true;
    }

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');
  }
}

class TemporaryList with _Request {
  BuildContext context;
  String uid;
  TemporaryList(this.uid);

  temporaryList() async {
    Uri _url = Uri.parse(_Request.url['temporary_list'] + "?uid=" + uid);
    dynamic response = await http.get(_url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var responseBody = json.decode(utf8.decode(response.bodyBytes));

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');

    if (responseBody["response"] == false) {
      await alert(context, '錯誤', responseBody['message']);
    } else if (responseBody["response"] == true) {
      return responseBody;
    }
  }
}

class TemporaryInviteList with _Request {
  BuildContext context;
  String uid;
  TemporaryInviteList(this.uid);

  temporaryInviteList() async {
    Uri _url = Uri.parse(_Request.url['invite_list'] + "?uid=" + uid);
    dynamic response = await http.get(_url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var responseBody = json.decode(utf8.decode(response.bodyBytes));

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');

    if (responseBody["response"] == false) {
      await alert(context, '錯誤', responseBody['message']);
    } else if (responseBody["response"] == true) {
      return responseBody;
    }
  }
}
