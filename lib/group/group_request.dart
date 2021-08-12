import 'dart:convert';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class _Request {
  static const host = 'http://myday.sytes.net';
  static const path = '/group';
  static const url = {
    'create_group': '$host$path/create_group/',
    'edit_group': '$host$path/edit_group/',
    'invite_friend': '$host$path/invite_friend/',
    'setting_manager': '$host$path/setting_manager/',
    'quit_group': '$host$path/quit_group/',
    'member_status': '$host$path/member_status/',
    'group_list': '$host$path/group_list/',
    'get_log': '$host$path/get_log/',
    'invite_list': '$host$path/invite_list/',
    'member_list': '$host$path/member_list/',
    'invite_friend_list': '$host$path/invite_friend_list/',
    'get': '$host$path/get/',
  };
}

class MemberStatus with _Request {
  BuildContext context;
  String uid;
  int groupNum;
  int statusId;

  Map<String, dynamic> data;
  MemberStatus({this.context, this.uid, this.groupNum, this.statusId}) {
    data = {'uid': uid, 'groupNum': groupNum, 'statusId': statusId};
  }
  memberStatus() async {
    Uri _url = Uri.parse(_Request.url['member_status']);
    dynamic response = await http.patch(_url,
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
      if (statusId == 1) {
        toast(context, "加入成功");
      } else if (statusId == 3) {
        toast(context, "拒絕成功");
      }
      return true;
    }
  }
}

class GroupList with _Request {
  BuildContext context;
  String uid;
  GroupList(this.uid);

  groupList() async {
    Uri _url = Uri.parse(_Request.url['group_list'] + "?uid=" + uid);
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

class InviteList with _Request {
  BuildContext context;
  String uid;
  InviteList(this.uid);

  inviteList() async {
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
