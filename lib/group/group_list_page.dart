import 'dart:convert';
import 'dart:io';
import 'package:My_Day_app/group/group_detail_page.dart';
import 'package:My_Day_app/models/group_invite_model.dart';

import 'package:My_Day_app/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'group_create_page.dart';
import 'group_join_page.dart';

class GroupListPage extends StatelessWidget {
  String g;
  GroupListPage(String g) {
    this.g = g;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(g, style: TextStyle(fontSize: 22)),
          actions: [
            PopupMenuButton<int>(
              offset: Offset(50, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              icon: Icon(Icons.add),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                    value: 0,
                    child: Container(
                        alignment: Alignment.center, child: Text("建立群組"))),
                PopupMenuDivider(
                  height: 1,
                ),
                PopupMenuItem<int>(
                    value: 1,
                    child: Container(
                        alignment: Alignment.center, child: Text("加入群組"))),
              ],
              onSelected: (item) => selectedItem(context, item),
            ),
          ],
        ),
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

  GroupModel _groupModel = null;
  GroupInviteModel _groupInviteModel = null;

  @override
  void initState() {
    _getGroupListRequest();
    _getGroupInviteRequest();
    super.initState();
  }

  _getGroupListRequest() async {
    // var jsonString = await rootBundle.loadString('assets/json/groups.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/group/group_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonMap = json.decode(jsonString);

    var groupModel = GroupModel.fromJson(jsonMap);
    setState(() {
      _groupModel = groupModel;
    });
  }

  _getGroupInviteRequest() async {
    // var jsonString =
    //     await rootBundle.loadString('assets/json/groups_invite.json')

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/group/invite_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();

    httpClient.close();
    var jsonMap = json.decode(jsonString);

    var groupInviteModel = GroupInviteModel.fromJson(jsonMap);
    setState(() {
      _groupInviteModel = groupInviteModel;
    });
    print('邀約群組個數：${groupInviteModel.groupContent.length}');
  }

  Widget build(BuildContext context) {
    if (_groupModel != null) {
      if (_groupInviteModel.groupContent.length != 0) {
        return _buildGroupInviteWidget(context);
      } else {
        if (_groupModel.groupContent.length != 0) {
          return _buildGroupList(context);
        }
        else{
          return _buildNoGroup(context);
        }
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildGroupInviteWidget(BuildContext context) {
    if (_groupModel != null) {
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
            child: Text('邀約',
                style: TextStyle(fontSize: 16, color: Color(0xff7AAAD8))),
          ),
          _buildGroupInviteList(context),
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
            child: Text('已加入',
                style: TextStyle(fontSize: 16, color: Color(0xff7AAAD8))),
          ),
          _buildGroupList(context)
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildGroupInviteList(BuildContext context) {
    List typeColor = <int>[
      0xffF78787,
      0xffFFD51B,
      0xffFFA800,
      0xffB6EB3A,
      0xff53DAF0,
      0xff4968BA,
      0xffCE85E4
    ];
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _groupInviteModel.groupContent.length,
        itemBuilder: (BuildContext context, int index) {
          var groupContent = _groupInviteModel.groupContent[index];
          return Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
                onTap: () {},
                title: Text(
                  '${groupContent.title}',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('邀請人：${groupContent.inviterName}'),
                leading: Container(
                  child: CircleAvatar(
                    radius: 20.0,
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
                          _getGroupInviteRequest();
                          _getGroupListRequest();
                          print('已加入${groupContent.groupId}');
                        },
                        child: Text('加入',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor)),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    Expanded(
                        child: FlatButton(
                      padding: EdgeInsets.all(0),
                      height: 0,
                      minWidth: 0,
                      onPressed: () {
                        _getGroupInviteRequest();
                        _getGroupListRequest();
                        print('已拒絕${groupContent.groupId}');
                      },
                      child: Text(
                        '拒絕',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xffAAAAAA)),
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
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _groupModel.groupContent.length,
      itemBuilder: (BuildContext context, int index) {
        var groupContent = _groupModel.groupContent[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        GroupDetailPage(groupContent.groupId)));
          },
          title: Text(
            '${groupContent.title} (${groupContent.peopleCount})',
            style: TextStyle(fontSize: 20),
          ),
          leading: Container(
            child: CircleAvatar(
              radius: 20.0,
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
