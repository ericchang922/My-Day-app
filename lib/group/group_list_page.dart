import 'dart:convert';
import 'dart:io';
import 'package:My_Day_app/group/group_detail_page.dart';
import 'package:My_Day_app/models/group_invite_list_model.dart';

import 'package:My_Day_app/models/group_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'group_create_page.dart';
import 'group_join_page.dart';

selectedItem(BuildContext context, item) async {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => GroupCreatePage()));
      break;
    case 1:
      bool action = await groupJoinDialog(context);
      break;
  }
}

AppBar groupListAppBar(context) {
  var screenSize = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    title: Text('群組', style: TextStyle(fontSize: screenSize.width * 0.052)),
    actions: [
      PopupMenuButton<int>(
        offset: Offset(50, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenSize.height * 0.01)),
        icon: Icon(Icons.add),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
              value: 0,
              child: Container(
                  alignment: Alignment.center,
                  child: Text("建立群組",
                      style: TextStyle(fontSize: screenSize.width * 0.035)))),
          PopupMenuDivider(
            height: 1,
          ),
          PopupMenuItem<int>(
              value: 1,
              child: Container(
                  alignment: Alignment.center,
                  child: Text("加入群組",
                      style: TextStyle(fontSize: screenSize.width * 0.035)))),
        ],
        onSelected: (item) => selectedItem(context, item),
      ),
    ],
  );
}

class GroupListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: Theme.of(context).primaryColor,
      child: Container(color: Colors.white, child: GroupListWidget()),
    )));
  }
}

class GroupListWidget extends StatefulWidget {
  @override
  _GroupListState createState() => new _GroupListState();
}

class _GroupListState extends State<GroupListWidget> {
  String uid = 'lili123';

  List typeColor = <int>[
    0xffF78787,
    0xffFFD51B,
    0xffFFA800,
    0xffB6EB3A,
    0xff53DAF0,
    0xff4968BA,
    0xffCE85E4
  ];

  GroupListModel _groupListModel = null;
  GroupInviteListModel _groupInviteListModel = null;

  @override
  void initState() {
    super.initState();
    _groupListRequest();
    _groupInviteListRequest();
  }

  _groupListRequest() async {
    // var jsonString = await rootBundle.loadString('assets/json/group_list.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/group/group_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonMap = json.decode(jsonString);

    var groupListModel = GroupListModel.fromJson(jsonMap);
    setState(() {
      _groupListModel = groupListModel;
    });
  }

  _groupInviteListRequest() async {
    // var jsonString =
    //     await rootBundle.loadString('assets/json/group_invite_list.json')

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/group/invite_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonMap = json.decode(jsonString);

    var groupInviteListModel = GroupInviteListModel.fromJson(jsonMap);
    setState(() {
      _groupInviteListModel = groupInviteListModel;
    });
    print('邀約群組個數：${groupInviteListModel.groupContent.length}');
  }

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_groupListModel != null && _groupInviteListModel != null) {
      if (_groupInviteListModel.groupContent.length != 0) {
        return _buildGroupListWidget(context);
      } else if (_groupListModel.groupContent.length != 0) {
        return Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.01),
            child: _buildGroupList(context));
      } else {
        return _buildNoGroup(context);
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildGroupListWidget(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_groupListModel != null) {
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: screenSize.height * 0.03,
                bottom: screenSize.height * 0.02,
                top: screenSize.height * 0.02),
            child: Text('邀約',
                style: TextStyle(
                    fontSize: screenSize.width * 0.041,
                    color: Color(0xff7AAAD8))),
          ),
          _buildGroupInviteList(context),
          Container(
            margin: EdgeInsets.only(
                left: screenSize.height * 0.03,
                bottom: screenSize.height * 0.02,
                top: screenSize.height * 0.02),
            child: Text('已加入',
                style: TextStyle(
                    fontSize: screenSize.width * 0.041,
                    color: Color(0xff7AAAD8))),
          ),
          _buildGroupList(context)
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildGroupInviteList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _groupInviteListModel.groupContent.length,
        itemBuilder: (BuildContext context, int index) {
          var groupContent = _groupInviteListModel.groupContent[index];
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.height * 0.04, vertical: 0.0),
                onTap: () {},
                title: Text(
                  '${groupContent.title}',
                  style: TextStyle(fontSize: screenSize.width * 0.045),
                ),
                subtitle: Container(
                    margin: EdgeInsets.only(top: screenSize.height * 0.005),
                    child: Text('邀請人：${groupContent.inviterName}',
                        style: TextStyle(
                            fontSize: screenSize.width * 0.032,
                            color: Color(0xff959595)))),
                leading: Container(
                  margin: EdgeInsets.only(bottom: screenSize.width * 0.01),
                  child: CircleAvatar(
                    radius: screenSize.width * 0.045,
                    backgroundColor: Color(typeColor[groupContent.typeId - 1]),
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ignore: deprecated_member_use
                    Expanded(
                      child: FlatButton(
                        height: 0,
                        minWidth: 0,
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          _groupInviteListRequest();
                          _groupListRequest();
                          print('已加入${groupContent.groupId}');
                        },
                        child: Text('加入',
                            style: TextStyle(
                                fontSize: screenSize.width * 0.041,
                                color: Theme.of(context).primaryColor)),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.width * 0.01,
                    ),
                    // ignore: deprecated_member_use
                    Expanded(
                        child: FlatButton(
                      padding: EdgeInsets.all(0),
                      height: 0,
                      minWidth: 0,
                      onPressed: () {
                        _groupInviteListRequest();
                        _groupListRequest();
                        print('已拒絕${groupContent.groupId}');
                      },
                      child: Text(
                        '拒絕',
                        style: TextStyle(
                            fontSize: screenSize.width * 0.041,
                            color: Color(0xff959595)),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        });
  }

  Widget _buildNoGroup(BuildContext context) {
    return Container(
        alignment: Alignment.center, height: 100, child: Text('目前沒有任何群組喔！'));
  }

  Widget _buildGroupList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _groupListModel.groupContent.length,
      itemBuilder: (BuildContext context, int index) {
        var groupContent = _groupListModel.groupContent[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.height * 0.04, vertical: 0.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        GroupDetailPage(groupContent.groupId)));
          },
          title: Text(
            '${groupContent.title} (${groupContent.peopleCount})',
            style: TextStyle(fontSize: screenSize.width * 0.045),
          ),
          leading: Container(
            child: CircleAvatar(
              radius: screenSize.width * 0.045,
              backgroundColor: Color(typeColor[groupContent.typeId - 1]),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
