import 'package:flutter/material.dart';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/group/group_create_page.dart';
import 'package:My_Day_app/group/group_join_page.dart';
import 'package:My_Day_app/group/group_detail_page.dart';
import 'package:My_Day_app/public/group_request/invite_list.dart';
import 'package:My_Day_app/public/group_request/group_list.dart';
import 'package:My_Day_app/public/group_request/member_status.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/models/group/group_invite_list_model.dart';
import 'package:My_Day_app/models/group/group_list_model.dart';

AppBar groupListAppBar(context) {
  return null;
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
  GroupListModel _groupListModel;
  GroupInviteListModel _groupInviteListModel;

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _groupListRequest();
    await _groupInviteListRequest();
  }

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
    _uid();
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
    GroupListModel _request =
        await GroupList(context: context, uid: uid).getData();

    setState(() {
      _groupListModel = _request;
    });
  }

  _groupInviteListRequest() async {
    GroupInviteListModel _request =
        await InviteList(context: context, uid: uid).getData();

    setState(() {
      _groupInviteListModel = _request;
      print('group_list_page -- 邀約群組個數：${_groupInviteListModel.groupContent.length}');
    });
  }

  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _listPaddingH = _sizing.width(6);
    double _widthSize = _sizing.width(1);
    double _textL = _sizing.height(3);
    double _textBT = _sizing.height(2);
    double _subtitleT = _sizing.height(0.5);

    double _appBarSize = _sizing.width(5.2);
    double _p2Size = _sizing.height(2);
    double _pSize = _sizing.height(2.3);
    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);
    double _typeSize = _sizing.width(4.5);

    Color _bule = Color(0xff7AAAD8);
    Color _gray = Color(0xff959595);
    Color _color = Theme.of(context).primaryColor;

    Widget groupListWiget;

    selectedItem(BuildContext context, item) async {
      switch (item) {
        case 0:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => GroupCreatePage()));
          break;
        case 1:
          await groupJoinDialog(context).then((value) => _groupListRequest());
          break;
      }
    }

    _submit(bool isJoin, int groupNum) async {
      int statusId;
      var submitWidget;
      if (isJoin)
        statusId = 1;
      else
        statusId = 3;
      _submitWidgetfunc() async {
        return MemberStatus(uid: uid, groupNum: groupNum, statusId: statusId);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
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
                      Expanded(
                        child: InkWell(
                          child: Text('加入',
                              style:
                                  TextStyle(fontSize: _pSize, color: _color)),
                          onTap: () async {
                            if (await _submit(true, groupContent.groupId) !=
                                true) {
                              _groupListRequest();
                              _groupInviteListRequest();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: _widthSize,
                      ),
                      Expanded(
                          child: InkWell(
                        child: Text(
                          '拒絕',
                          style: TextStyle(fontSize: _pSize, color: _gray),
                        ),
                        onTap: () async {
                          if (await _submit(false, groupContent.groupId) !=
                              true) {
                            _groupListRequest();
                            _groupInviteListRequest();
                          }
                        },
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
              Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: '/group_detail'),
                  builder: (context) => GroupDetailPage(
                        arguments: {
                          'groupNum': groupContent.groupId,
                          'isNotTemporary': true
                        },
                      )));
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
          padding: EdgeInsets.only(top: _sizing.width(3)),
          children: [groupList],
        );
      } else
        groupListWiget = noGroup;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('群組', style: TextStyle(fontSize: _appBarSize)),
          actions: [
            PopupMenuButton<int>(
              offset: Offset(50, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_sizing.height(1))),
              icon: Icon(Icons.add),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                    value: 0,
                    child: Container(
                        alignment: Alignment.center,
                        child:
                            Text("建立群組", style: TextStyle(fontSize: _p2Size)))),
                PopupMenuDivider(
                  height: 1,
                ),
                PopupMenuItem<int>(
                    value: 1,
                    child: Container(
                        alignment: Alignment.center,
                        child:
                            Text("加入群組", style: TextStyle(fontSize: _p2Size)))),
              ],
              onSelected: (item) => selectedItem(context, item),
            ),
          ],
        ),
        body: Container(color: Colors.white, child: groupListWiget),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('群組', style: TextStyle(fontSize: _appBarSize)),
        ),
        body: Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }
}
