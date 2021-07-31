import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend_list_model.dart';
import 'package:My_Day_app/models/group_member_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customer_check_box.dart';

class GroupMemberPage extends StatelessWidget {
  int groupNum;
  GroupMemberPage(this.groupNum);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('群組成員', style: TextStyle(fontSize: screenSize.width * 0.052)),
        leading: Container(
          margin: EdgeInsets.only(left: screenSize.height * 0.02),
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
  GroupMemberListModel _groupMemberListModel = null;
  List _memberList = [];
  List _inviteMemberList = [];

  String uid = 'lili123';

  int groupNum;
  _GroupInviteState(this.groupNum);

  @override
  void initState() {
    _groupMemberListRequest();
    super.initState();
  }

  void _groupMemberListRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/group_members.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
        '/group/member_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var groupMemberListModel = GroupMemberListModel.fromJson(jsonBody);
    setState(() {
      _groupMemberListModel = groupMemberListModel;
      for (int i = 0; i < _groupMemberListModel.member.length; i++) {
        if (_groupMemberListModel.member[i].statusId == 1 ||
            _groupMemberListModel.member[i].statusId == 4) {
          _memberList.add(_groupMemberListModel.member[i]);
        }
      }

      for (int i = 0; i < _groupMemberListModel.member.length; i++) {
        if (_groupMemberListModel.member[i].statusId == 2) {
          _inviteMemberList.add(_groupMemberListModel.member[i]);
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
    var screenSize = MediaQuery.of(context).size;
    if (_groupMemberListModel != null) {
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: screenSize.height * 0.03,
                bottom: screenSize.height * 0.02,
                top: screenSize.height * 0.02),
            child: Text('邀請中',
                style: TextStyle(fontSize: screenSize.width * 0.041, color: Color(0xff7AAAD8))),
          ),
          _buildInviteMemberList(context),
          Container(
            margin: EdgeInsets.only(
                left: screenSize.height * 0.03,
                bottom: screenSize.height * 0.02,
                top: screenSize.height * 0.02),
            child: Text('成員',
                style: TextStyle(fontSize: screenSize.width * 0.041, color: Color(0xff7AAAD8))),
          ),
          _buildMemberList(context)
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Image getImage(String imageString) {
  var screenSize = MediaQuery.of(context).size;
    bool isGetImage;
    Image friendImage = Image.asset(
      'assets/images/friend_choose.png',
      width: screenSize.height * 0.04683,
    );
    const Base64Codec base64 = Base64Codec();
    Image image = Image.memory(base64.decode(imageString),
        width: screenSize.height * 0.04683, height: screenSize.height * 0.04683, fit: BoxFit.fill);
    var resolve = image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      isGetImage = true;
    }, onError: (Object exception, StackTrace stackTrace) {
      isGetImage = false;
      print('error');
    }));

    if (isGetImage == true) {
      return image;
    } else {
      return friendImage;
    }
  }
  
  Widget _buildInviteMemberList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _inviteMemberList.length,
      itemBuilder: (BuildContext context, int index) {
        var members = _inviteMemberList[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(members.memberPhoto),
          ),
          title: Text(
            members.memberName,
            style: TextStyle(fontSize: screenSize.width * 0.041),
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
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _memberList.length,
      itemBuilder: (BuildContext context, int index) {
        var members = _memberList[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(members.memberPhoto),
          ),
          title: Text(
            members.memberName,
            style: TextStyle(fontSize: screenSize.width * 0.041),
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
