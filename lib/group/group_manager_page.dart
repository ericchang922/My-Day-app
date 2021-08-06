import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend_list_model.dart';
import 'package:My_Day_app/models/group_member_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customer_check_box.dart';

class GroupManagerPage extends StatelessWidget {
  int groupNum;
  GroupManagerPage(this.groupNum);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:
            Text('管理者', style: TextStyle(fontSize: screenSize.width * 0.052)),
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
      body: Container(color: Colors.white, child: GroupManagerWidget(groupNum)),
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
  GroupMemberListModel _groupMemberListModel = null;
  List _memberList = [];
  List _managerList = [];
  List _checkIsManagerList = [];

  String uid = 'lili123';

  int groupNum;
  _GroupManagerState(this.groupNum);

  bool _isManager = false;

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

    var groupMemberListModel = GroupMemberListModel.fromJson(jsonBody);
    setState(() {
      _groupMemberListModel = groupMemberListModel;

      for (int i = 0; i < _groupMemberListModel.member.length; i++) {
        if (_groupMemberListModel.member[i].statusId == 4) {
          _managerList.add(_groupMemberListModel.member[i]);
        }
        if (_groupMemberListModel.member[i].statusId == 1) {
          _memberList.add(_groupMemberListModel.member[i]);
        }
      }
      for (int i = 0; i < _managerList.length; i++) {
        if (_managerList[i].memberId == uid) {
          _isManager = true;
        }
      }
      print(_isManager);
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
      if (_isManager == true) {
        return _buildSettingManagerWidget(context);
      } else {
        return ListView(
          children: [
            Container(
                margin: EdgeInsets.only(top: screenSize.height * 0.02),
                child: _buildManagerList(context))
          ],
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildSettingManagerWidget(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: screenSize.height * 0.03,
              bottom: screenSize.height * 0.02,
              top: screenSize.height * 0.02),
          child: Text('管理者',
              style: TextStyle(
                  fontSize: screenSize.width * 0.041,
                  color: Color(0xff7AAAD8))),
        ),
        _buildManagerList(context),
        Container(
          margin: EdgeInsets.only(
              left: screenSize.height * 0.03,
              bottom: screenSize.height * 0.02,
              top: screenSize.height * 0.02),
          child: Text('新增管理者',
              style: TextStyle(
                  fontSize: screenSize.width * 0.041,
                  color: Color(0xff7AAAD8))),
        ),
        _buildMemberList(context)
      ],
    );
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
        width: screenSize.height * 0.04683,
        height: screenSize.height * 0.04683,
        fit: BoxFit.fill);
    var resolve = image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      isGetImage = true;
    }, onError: (Object exception, StackTrace stackTrace) {
      isGetImage = false;
      print('error');
    }));
    if (isGetImage == null) {
      return image;
    } else {
      return friendImage;
    }
  }

  Widget _addManager(memberId) {
    var screenSize = MediaQuery.of(context).size;
    if (memberId != uid && _isManager == true) {
      return InkWell(
        onTap: () {},
        child: Text('新增',
            style: TextStyle(
                fontSize: screenSize.width * 0.041,
                color: Theme.of(context).primaryColor)),
      );
    } else {
      return Container(height: 0, width: 0);
    }
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
          trailing: _addManager(members.memberId),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _deleteManager(memberId) {
    var screenSize = MediaQuery.of(context).size;
    if (memberId != uid && _isManager == true) {
      return InkWell(
        onTap: () {},
        child: Text('刪除',
            style: TextStyle(
                fontSize: screenSize.width * 0.041, color: Color(0xffAAAAAA))),
      );
    } else {
      return Container(height: 0, width: 0);
    }
  }

  Widget _buildManagerList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _managerList.length,
      itemBuilder: (BuildContext context, int index) {
        var members = _managerList[index];
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
          trailing: _deleteManager(members.memberId),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
