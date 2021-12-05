import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:My_Day_app/public/group_request/setting_manager.dart';
import 'package:My_Day_app/public/group_request/member_list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/models/group/group_member_list_model.dart';

class GroupManagerPage extends StatelessWidget {
  int groupNum;
  GroupManagerPage(this.groupNum);

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _leadingL = _sizing.height(2);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;

    return Container(
      color: _color,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _color,
            title: Text('管理者', style: TextStyle(fontSize: _appBarSize)),
            leading: Container(
              margin: EdgeInsets.only(left: _leadingL),
              child: GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          body: Container(
              color: Colors.white,
              child: SafeArea(top: false, child: GroupManagerWidget(groupNum))),
        ),
      ),
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
  int groupNum;
  _GroupManagerState(this.groupNum);

  GroupMemberListModel _groupMemberListModel;

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _groupMemberListRequest();
  }

  List _memberList = [];
  List _managerList = [];

  bool _isManager = false;

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _groupMemberListRequest() async {
    GroupMemberListModel _request =
        await MemberList(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _groupMemberListModel = _request;
      _managerList = [];
      _memberList = [];

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
    });
  }

  Image getImage(String imageString) {
    Sizing _sizing = Sizing(context);
    double _imgSize = _sizing.height(4.5);
    bool isGetImage;

    Image friendImage = Image.asset(
      'assets/images/friend_choose.png',
      width: _imgSize,
    );
    const Base64Codec base64 = Base64Codec();
    Image image = Image.memory(base64.decode(imageString),
        width: _imgSize, height: _imgSize, fit: BoxFit.fill);
    var resolve = image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      isGetImage = true;
    }, onError: (Object exception, StackTrace stackTrace) {
      isGetImage = false;
      print('group_manager_page -- getImage: error');
    }));

    if (isGetImage == null) {
      return image;
    } else {
      return friendImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _textL = _sizing.height(3);
    double _textBT = _sizing.height(2);
    double _listPaddingH = _sizing.width(6);

    double _pSize = _sizing.height(2.3);

    Color _bule = Color(0xff7AAAD8);
    Color _gray = Color(0xff959595);
    Color _color = Theme.of(context).primaryColor;

    Widget managerWidget;

    _submit(bool isAddManager, String friendId) async {
      int statusId;
      var submitWidget;
      if (isAddManager)
        statusId = 4;
      else
        statusId = 1;
      _submitWidgetfunc() async {
        return SettingManager(
            uid: uid,
            friendId: friendId,
            groupNum: groupNum,
            statusId: statusId);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    Widget _addManager(memberId) {
      if (memberId != uid && _isManager == true) {
        return InkWell(
            onTap: () async {
              if (await _submit(true, memberId) != true) {
                _groupMemberListRequest();
              }
            },
            child: Text(
              '新增',
              style: TextStyle(fontSize: _pSize, color: _color),
            ));
      } else {
        return Container(height: 0, width: 0);
      }
    }

    Widget _deleteManager(memberId) {
      if (memberId != uid && _isManager == true) {
        return InkWell(
          onTap: () async {
            if (await _submit(false, memberId) != true) {
              _groupMemberListRequest();
            }
          },
          child: Text('刪除', style: TextStyle(fontSize: _pSize, color: _gray)),
        );
      } else {
        return Container(height: 0, width: 0);
      }
    }

    if (_groupMemberListModel != null) {
      Widget managerList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _managerList.length,
        itemBuilder: (BuildContext context, int index) {
          var members = _managerList[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            leading: ClipOval(
              child: getImage(members.memberPhoto),
            ),
            title: Text(
              members.memberName,
              style: TextStyle(fontSize: _pSize),
            ),
            trailing: _deleteManager(members.memberId),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      Widget memberList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _memberList.length,
        itemBuilder: (BuildContext context, int index) {
          var members = _memberList[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            leading: ClipOval(
              child: getImage(members.memberPhoto),
            ),
            title: Text(
              members.memberName,
              style: TextStyle(fontSize: _pSize),
            ),
            trailing: _addManager(members.memberId),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      if (_memberList.length != 0) {
        managerWidget = ListView(
          children: [
            Container(
              margin:
                  EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
              child:
                  Text('管理者', style: TextStyle(fontSize: _pSize, color: _bule)),
            ),
            managerList,
            Container(
              margin:
                  EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
              child: Text('新增管理者',
                  style: TextStyle(fontSize: _pSize, color: _bule)),
            ),
            memberList
          ],
        );
      } else {
        managerWidget = ListView(
          children: [
            Container(
                margin: EdgeInsets.only(top: _sizing.height(2)),
                child: managerList)
          ],
        );
      }

      if (_isManager == true) {
        return managerWidget;
      } else {
        return ListView(
          children: [
            Container(
                margin: EdgeInsets.only(top: _sizing.height(2)),
                child: managerList)
          ],
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
