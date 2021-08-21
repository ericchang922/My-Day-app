// dart
import 'dart:convert';
// flutter
import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/models/group/common_schedule_list_model.dart';
import 'package:My_Day_app/models/group/get_common_schedule_model.dart';
import 'package:My_Day_app/models/group/get_group_model.dart';
import 'package:My_Day_app/models/group/group_invite_friend_list_model.dart';
import 'package:My_Day_app/models/group/group_invite_list_model.dart';
import 'package:My_Day_app/models/group/group_list_model.dart';
import 'package:My_Day_app/models/group/group_log_model.dart';
import 'package:My_Day_app/models/group/group_member_list_model.dart';
import 'package:My_Day_app/models/temporary_group/get_temporary_group_invitet_model.dart';
import 'package:My_Day_app/models/temporary_group/temporary_group_list_model.dart';
import 'package:My_Day_app/models/timetable/main_timetable_list_model.dart';
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
    'common_list': '${path['schedule']}/common_list/',
    'common_hidden': '$host${path['schedule']}/common_hidden/',
    'countdown_list': '$host${path['schedule']}/countdown_list/',
  };
  static Map groupUrl = {
    'create_group': '$host${path['group']}/create_group/',
    'edit_group': '$host${path['group']}/edit_group/',
    'invite_friend': '$host${path['group']}/invite_friend/',
    'setting_manager': '$host${path['group']}/setting_manager/',
    'quit_group': '$host${path['group']}/quit_group/',
    'member_status': '$host${path['group']}/member_status/',
    'group_list': '${path['group']}/group_list/',
    'get_log': '${path['group']}/get_log/',
    'invite_list': '${path['group']}/invite_list/',
    'member_list': '${path['group']}/member_list/',
    'invite_friend_list': '${path['group']}/invite_friend_list/',
    'get': '${path['group']}/get/',
  };
  static Map temporaryGroupUrl = {
    'create_group': '$host${path['temporaryGroup']}/create_group/',
    'invite_list': '${path['temporaryGroup']}/invite_list/',
    'temporary_list': '${path['temporaryGroup']}/temporary_list/',
    'get_invite': '${path['temporaryGroup']}/get_invite/',
  };
  static Map friendUrl = {
    'get': '${path['friend']}/get/',
    'friend_list': '${path['friend']}/friend_list/',
    'make_invite_list': '${path['friend']}/make_invite_list/',
    'best_list': '${path['friend']}/best_list/',
    'add_best': '$host${path['friend']}/add_best/',
    'add': '$host${path['friend']}/add/',
    'add_reply': '$host${path['friend']}/add_reply/',
    'delete': '$host${path['friend']}/delete/',
    'delete_best': '$host${path['friend']}/delete_best/'
  };
  static Map timetableUrl = {
    'main_timetable_list': '${path['timetable']}/main_timetable_list/'
  };

  Map headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Map<String, dynamic> _responseBody;

  ScheduleGet _scheduleGet;
  GetCommonScheduleModel _commenSchedule;
  CommonScheduleListModel _commonScheduleList;

  GroupListModel _groupList;
  GroupInviteListModel _groupInviteList;
  GroupLogModel _groupLog;
  GetGroupModel _group;
  GroupInviteFriendListModel _groupInviteFriendList;
  GroupMemberListModel _groupMemberList;

  TemporaryGroupListModel _temporaryGroupList;
  TemporaryGroupListModel _temporaryGroupInviteList;
  GetTemporaryGroupInviteModel _temporaryGroupInvite;

  FriendListModel _friendList;
  BestFriendListModel _bestFriendList;

  MainTimetableListGet _mainTimetableListGet;

  bool _isError;

  getScheduleGet() => _scheduleGet;
  getCommenScheduleGet() => _commenSchedule;
  getCommonScheduleListGet() => _commonScheduleList;

  getGroupListGet() => _groupList;
  getGroupInviteListGet() => _groupInviteList;
  getGroupLogGet() => _groupLog;
  getGroupGet() => _group;
  getGroupInviteFriendListGet() => _groupInviteFriendList;
  getGroupMemberListGet() => _groupMemberList;

  getTemporaryGroupListGet() => _temporaryGroupList;
  getTemporaryGroupInviteListGet() => _temporaryGroupInviteList;
  getTemporaryGroupInviteGet() => _temporaryGroupInvite;

  getFriendListGet() => _friendList;
  getBestFriendGet() => _bestFriendList;

  getMainTimetableListGet() => _mainTimetableListGet;

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

  httpPatch(BuildContext context, Map<String, dynamic> data, String _url,
      String toastTxt) async {
    Uri _uri = Uri.parse(_url);
    dynamic response =
        await http.patch(_uri, headers: headers, body: json.encode(data));
    await httpFunction(context, response, toastTxt);
  }

  httpDelete(BuildContext context, Map<String, dynamic> data, String _url,
      String toastTxt) async {
    Uri _uri = Uri.parse(_url);
    dynamic response =
        await http.delete(_uri, headers: headers, body: json.encode(data));
    await httpFunction(context, response, toastTxt);
  }

// SCHEDULE ============================================================================================
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

// get_common -------------------------------------------------------------------------------------
  scheduleGetCommon(BuildContext context, Map<String, dynamic> data) async {
    String _url = scheduleUrl['get_common'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _commenSchedule = GetCommonScheduleModel.fromJson(_responseBody);
    }
  }

// common_list ------------------------------------------------------------------------------------
  scheduleCommonList(BuildContext context, Map<String, dynamic> data) async {
    String _url = scheduleUrl['common_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _commonScheduleList = CommonScheduleListModel.fromJson(_responseBody);
    }
  }

// GROUP ===============================================================================================
// goup_list --------------------------------------------------------------------------------------
  groupList(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['group_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _groupList = GroupListModel.fromJson(_responseBody);
    }
  }

  // goup_invite_list -----------------------------------------------------------------------------
  groupInviteList(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['invite_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _groupInviteList = GroupInviteListModel.fromJson(_responseBody);
    }
  }

  // group_create ---------------------------------------------------------------------------------
  groupCreate(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['create_group'];
    await httpPost(context, data, _url, '新增成功');
  }

  // group_member_status --------------------------------------------------------------------------
  groupMemberStatus(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['member_status'];
    String toastText;
    if (data['statusId'] == 1)
      toastText = '加入成功';
    else if (data['statusId'] == 3) toastText = '拒絕成功';
    await httpPatch(context, data, _url, toastText);
  }

  // group_get_log --------------------------------------------------------------------------------
  groupGetLog(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['get_log'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _groupLog = GroupLogModel.fromJson(_responseBody);
    }
  }

  // group_invite_friend_list ---------------------------------------------------------------------
  groupInviteFriendList(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['invite_friend_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _groupInviteFriendList =
          GroupInviteFriendListModel.fromJson(_responseBody);
    }
  }

  // group_get ----------------------------------------------------------------------------------------
  groupGet(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['get'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _group = GetGroupModel.fromJson(_responseBody);
    }
  }

  // group_member_list ----------------------------------------------------------------------------
  groupMemberList(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['member_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _groupMemberList = GroupMemberListModel.fromJson(_responseBody);
    }
  }

  // group_setting_manager ------------------------------------------------------------------------
  groupSettingManager(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['setting_manager'];
    String toastText;
    if (data['statusId'] == 1)
      toastText = '刪除成功';
    else if (data['statusId'] == 4) toastText = '加入成功';
    await httpPatch(context, data, _url, toastText);
  }

  // group_edit ------------------------------------------------------------------------------------
  groupEdit(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['edit_group'];
    await httpPatch(context, data, _url, '編輯成功');
  }

  // group_quit -----------------------------------------------------------------------------------
  groupQuit(BuildContext context, Map<String, dynamic> data) async {
    String _url = groupUrl['quit_group'];
    await httpDelete(context, data, _url, '已退出');
  }

  // TEMPORARYGROUP ====================================================================================
  // temporary_create_group -----------------------------------------------------------------------
  temporaryCreateGroup(BuildContext context, Map<String, dynamic> data) async {
    String _url = temporaryGroupUrl['create_group'];
    await httpPost(context, data, _url, '新增成功');
  }

  // temporary_list -------------------------------------------------------------------------------
  temporaryList(BuildContext context, Map<String, dynamic> data) async {
    String _url = temporaryGroupUrl['temporary_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _temporaryGroupList = TemporaryGroupListModel.fromJson(_responseBody);
    }
  }

  // temporary_invite_list ------------------------------------------------------------------------
  temporaryInviteList(BuildContext context, Map<String, dynamic> data) async {
    String _url = temporaryGroupUrl['invite_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _temporaryGroupInviteList =
          TemporaryGroupListModel.fromJson(_responseBody);
    }
  }

  // temporary_get_invite -------------------------------------------------------------------------
  temporaryGetInvite(BuildContext context, Map<String, dynamic> data) async {
    String _url = temporaryGroupUrl['get_invite'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _temporaryGroupInvite =
          GetTemporaryGroupInviteModel.fromJson(_responseBody);
    }
  }

  // FRIEND ============================================================================================
  // friend_list ----------------------------------------------------------------------------------
  friendList(BuildContext context, Map<String, dynamic> data) async {
    String _url = friendUrl['friend_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _friendList = FriendListModel.fromJson(_responseBody);
    }
  }

  // best_friend_list -----------------------------------------------------------------------------
  bestFriendList(BuildContext context, Map<String, dynamic> data) async {
    String _url = friendUrl['best_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _bestFriendList = BestFriendListModel.fromJson(_responseBody);
    }
  }

  // TIMETABLE =========================================================================================
  mainTimetableListGet(BuildContext context, Map<String, dynamic> data) async {
    String _url = timetableUrl['main_timetable_list'];
    await httpGet(context, data, _url);
    if (_responseBody != null) {
      _mainTimetableListGet = MainTimetableListGet.fromJson(_responseBody);
    }
  }
}
