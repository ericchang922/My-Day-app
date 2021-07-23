import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/best_friend_model.dart';
import 'package:My_Day_app/models/friend_model.dart';
import 'package:My_Day_app/models/group_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customer_check_box.dart';

class GroupMemberPage extends StatelessWidget {
  int groupNum;
  GroupMemberPage(this.groupNum);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('群組成員', style: TextStyle(fontSize: 22)),
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
      body: Column(children: [Expanded(child: GroupInviteWidget(groupNum))]),
    );
  }
}

class GroupInviteWidget extends StatefulWidget {
  int groupNum;
  GroupInviteWidget(this.groupNum);

  @override
  State<GroupInviteWidget> createState() => new _GroupInviteState(groupNum);
}

class _GroupInviteState extends State<GroupInviteWidget> {
  GroupMemberModel _groupMemberModel = null;
  List _memberList = [];
  List _inviteMemberList = [];

  String uid = 'lili123';

  int groupNum;
  _GroupInviteState(this.groupNum);

  @override
  void initState() {
    _getGroupMemberRequest();
    super.initState();
  }

  void _getGroupMemberRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/group_members.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/group/member_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var groupMemberModel = GroupMemberModel.fromJson(jsonBody);
    setState(() {
      _groupMemberModel = groupMemberModel;
      for (int i = 0; i < _groupMemberModel.member.length; i++) {
        if (_groupMemberModel.member[i].statusId == 1 ||
            _groupMemberModel.member[i].statusId == 4) {
          _memberList.add(_groupMemberModel.member[i]);
        }
      }

      for (int i = 0; i < _groupMemberModel.member.length; i++) {
        if (_groupMemberModel.member[i].statusId == 2) {
          _inviteMemberList.add(_groupMemberModel.member[i]);
        }
      }
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
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
            child: Text('邀請中',
                style: TextStyle(fontSize: 16, color: Color(0xff7AAAD8))),
          ),
          _buildInviteMemberList(context),
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
            child: Text('成員',
                style: TextStyle(fontSize: 16, color: Color(0xff7AAAD8))),
          ),
          _buildMemberList(context)
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildInviteMemberList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _inviteMemberList.length,
      itemBuilder: (BuildContext context, int index) {
        var members = _inviteMemberList[index];
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
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
