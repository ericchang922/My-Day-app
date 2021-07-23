import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/best_friend_model.dart';
import 'package:My_Day_app/models/friend_model.dart';
import 'package:My_Day_app/models/group_member_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customer_check_box.dart';

class GroupManagerPage extends StatelessWidget {
  int groupNum;
  GroupManagerPage(this.groupNum);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('管理者', style: TextStyle(fontSize: 22)),
        leading: Container(
          margin: EdgeInsets.only(left: 5),
          child: GestureDetector(
            child: Icon(Icons.chevron_left),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Column(children: [Expanded(child: GroupManagerWidget(groupNum))]),
    );
  }
}

class GroupManagerWidget extends StatefulWidget {
  int groupNum;
  GroupManagerWidget(this.groupNum);

  @override
  State<GroupManagerWidget> createState() => new _GroupManagerState(groupNum);
}

class _GroupManagerState extends State<GroupManagerWidget> {
  GroupMemberModel _groupMemberModel = null;
  List _memberList = [];
  List _managerList = [];
  List _checkIsManagerList = [];

  String uid = 'lili123';

  int groupNum;
  _GroupManagerState(this.groupNum);

  @override
  void initState() {
    _getGroupMemberRequest();
    super.initState();
  }

  void _getGroupMemberRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/group_members.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
        '/group/member_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var groupMemberModel = GroupMemberModel.fromJson(jsonBody);
    setState(() {
      _groupMemberModel = groupMemberModel;

      for (int i = 0; i < _groupMemberModel.member.length; i++) {
        if (_groupMemberModel.member[i].statusId == 4) {
          _managerList.add(_groupMemberModel.member[i]);
        }
      }

      for (int i = 0; i < _groupMemberModel.member.length; i++) {
        if (_groupMemberModel.member[i].statusId == 1) {
          _memberList.add(_groupMemberModel.member[i]);
        }
      }

      // for (int i = 0; i < _groupMemberModel.member.length; i++) {
      //   if (_groupMemberModel.member[i].memberName == uid) {
      //     _checkIsManagerList.add(_groupMemberModel.member[i]);
      //   }
      // }
      // print(_checkIsManagerList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    if (_groupMemberModel != null) {
      return _buildSettingManagerWidget(context);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildSettingManagerWidget(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
          child: Text('管理者',
              style: TextStyle(fontSize: 16, color: Color(0xff7AAAD8))),
        ),
        _buildDeleteManagerList(context),
        Container(
          margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
          child: Text('新增管理者',
              style: TextStyle(fontSize: 16, color: Color(0xff7AAAD8))),
        ),
        _buildMemberList(context)
      ],
    );
  }

  Widget _buildMemberList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _memberList.length,
      itemBuilder: (BuildContext context, int index) {
        var members = _memberList[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          leading: ClipOval(
            child: Image.memory(base64.decode(members.memberPhoto), width: 40),
          ),
          title: Text(
            members.memberName,
            style: TextStyle(fontSize: 18),
          ),
          trailing: FlatButton(
            height: 0,
            minWidth: 0,
            padding: EdgeInsets.all(0),
            onPressed: () {},
            child: Text('新增',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor)),
          ),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildDeleteManagerList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _managerList.length,
      itemBuilder: (BuildContext context, int index) {
        var members = _managerList[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          leading: ClipOval(
            child: Image.memory(base64.decode(members.memberPhoto), width: 40),
          ),
          title: Text(
            members.memberName,
            style: TextStyle(fontSize: 18),
          ),
          trailing: FlatButton(
            height: 0,
            minWidth: 0,
            padding: EdgeInsets.all(0),
            onPressed: () {},
            child: Text('刪除',
                style: TextStyle(fontSize: 16, color: Color(0xffAAAAAA))),
          ),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildManagerList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _managerList.length,
      itemBuilder: (BuildContext context, int index) {
        var members = _managerList[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          leading: ClipOval(
            child: Image.memory(base64.decode(members.memberPhoto), width: 40),
          ),
          title: Text(
            members.memberName,
            style: TextStyle(fontSize: 18),
          ),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
