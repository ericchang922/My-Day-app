import 'package:My_Day_app/group/group_detail_page.dart';
import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/group_invite_list_model.dart';

import 'package:My_Day_app/models/group_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'group_create_page.dart';
import 'group_join_page.dart';
import 'group_request.dart';

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
  Size size = MediaQuery.of(context).size;
  double _width = size.width;
  double _height = size.height;
  double _appBarSize = _width * 0.052;
  double _p2Size = _height * 0.02;

  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    title: Text('群組', style: TextStyle(fontSize: _appBarSize)),
    actions: [
      PopupMenuButton<int>(
        offset: Offset(50, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_height * 0.01)),
        icon: Icon(Icons.add),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
              value: 0,
              child: Container(
                  alignment: Alignment.center,
                  child: Text("建立群組", style: TextStyle(fontSize: _p2Size)))),
          PopupMenuDivider(
            height: 1,
          ),
          PopupMenuItem<int>(
              value: 1,
              child: Container(
                  alignment: Alignment.center,
                  child: Text("加入群組", style: TextStyle(fontSize: _p2Size)))),
        ],
        onSelected: (item) => selectedItem(context, item),
      ),
    ],
  );
}

class GroupListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GroupListWidget();
  }
}

class GroupListWidget extends StatefulWidget {
  @override
  _GroupListState createState() => new _GroupListState();
}

class _GroupListState extends State<GroupListWidget> with RouteAware {
  String uid = 'lili123';

  GroupListModel _groupListModel = null;
  GroupInviteListModel _groupInviteListModel = null;

  List typeColor = <int>[
    0xffF78787,
    0xffFFD51B,
    0xffFFA800,
    0xffB6EB3A,
    0xff53DAF0,
    0xff4968BA,
    0xffCE85E4
  ];

  @override
  void initState() {
    super.initState();
    _groupListRequest();
    _groupInviteListRequest();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    _groupListRequest();
    _groupInviteListRequest();
  }

  _groupListRequest() async {
    // var response = await rootBundle.loadString('assets/json/group_list.json');
    // var responseBody = json.decode(response);

    await GroupList(uid).groupList().then((responseBody) {
      var groupListModel = GroupListModel.fromJson(responseBody);
      setState(() {
        _groupListModel = groupListModel;
      });
    });
  }

  _groupInviteListRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/group_invite_list.json');
    // var responseBody = json.decode(response);

    await InviteList(uid).inviteList().then((responseBody) {
      var groupInviteListModel = GroupInviteListModel.fromJson(responseBody);
      setState(() {
        _groupInviteListModel = groupInviteListModel;
      });
      print('邀約群組個數：${groupInviteListModel.groupContent.length}');
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _listPaddingH = _width * 0.06;
    double _widthSize = _width * 0.01;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _subtitleT = _height * 0.005;

    double _pSize = _height * 0.023;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _typeSize = _width * 0.045;

    Color _bule = Color(0xff7AAAD8);
    Color _gray = Color(0xff959595);
    Color _color = Theme.of(context).primaryColor;

    Widget groupListWiget;

    _submit(bool isJoin, int groupNum) async {
      int statusId;
      if (isJoin)
        statusId = 1;
      else
        statusId = 3;
      await MemberStatus(uid: uid, groupNum: groupNum, statusId: statusId)
          .memberStatus()
          .then((value) {
        return value;
      });
    }

    if (_groupListModel != null && _groupInviteListModel != null) {
      Widget inviteList = ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _groupInviteListModel.groupContent.length,
          itemBuilder: (BuildContext context, int index) {
            var groupContent = _groupInviteListModel.groupContent[index];
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: _listPaddingH, vertical: 0.0),
                  onTap: () {},
                  title: Text(
                    '${groupContent.title}',
                    style: TextStyle(fontSize: _titleSize),
                  ),
                  subtitle: Container(
                      margin: EdgeInsets.only(top: _subtitleT),
                      child: Text('邀請人：${groupContent.inviterName}',
                          style: TextStyle(
                              fontSize: _subtitleSize, color: _gray))),
                  leading: Container(
                    margin: EdgeInsets.only(bottom: _widthSize),
                    child: CircleAvatar(
                      radius: _typeSize,
                      backgroundColor:
                          Color(typeColor[groupContent.typeId - 1]),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ignore: deprecated_member_use
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (await _submit(true, groupContent.groupId) ==
                                true) {
                              _groupListRequest();
                              _groupInviteListRequest();
                            }
                          },
                          child: Text('加入',
                              style:
                                  TextStyle(fontSize: _pSize, color: _color)),
                        ),
                      ),
                      SizedBox(
                        height: _widthSize,
                      ),
                      // ignore: deprecated_member_use
                      Expanded(
                          child: InkWell(
                        onTap: () async {
                          if (await _submit(false, groupContent.groupId) ==
                              true) {
                            _groupListRequest();
                            _groupInviteListRequest();
                          }
                        },
                        child: Text(
                          '拒絕',
                          style: TextStyle(fontSize: _pSize, color: _gray),
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

      Widget groupList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _groupListModel.groupContent.length,
        itemBuilder: (BuildContext context, int index) {
          var groupContent = _groupListModel.groupContent[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GroupDetailPage(groupContent.groupId)));
            },
            title: Text(
              '${groupContent.title} (${groupContent.peopleCount})',
              style: TextStyle(fontSize: _titleSize),
            ),
            leading: Container(
              child: CircleAvatar(
                radius: _typeSize,
                backgroundColor: Color(typeColor[groupContent.typeId - 1]),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      Widget noGroup = Center(child: Text('目前沒有任何群組喔！'));

      if (_groupInviteListModel.groupContent.length != 0) {
        groupListWiget = ListView(
          children: [
            Container(
              margin:
                  EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
              child:
                  Text('邀約', style: TextStyle(fontSize: _pSize, color: _bule)),
            ),
            inviteList,
            Container(
              margin:
                  EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
              child:
                  Text('已加入', style: TextStyle(fontSize: _pSize, color: _bule)),
            ),
            groupList
          ],
        );
      } else if (_groupListModel.groupContent.length != 0) {
        groupListWiget = ListView(
          padding: EdgeInsets.only(top: _width * 0.03),
          children: [groupList],
        );
      } else
        groupListWiget = noGroup;

      return Scaffold(
          body: SafeArea(
              child: Container(
        color: _color,
        child: Container(color: Colors.white, child: groupListWiget),
      )));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
