import 'package:flutter/material.dart';

import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/models/group/group_member_list_model.dart';
import 'package:My_Day_app/public/group_request/member_list.dart';
import 'package:My_Day_app/public/sizing.dart';

class GroupMemberPage extends StatelessWidget {
  int groupNum;
  GroupMemberPage(this.groupNum);

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
            title: Text('群組成員', style: TextStyle(fontSize: _appBarSize)),
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
              child: SafeArea(top: false, child: GroupMemberWidget(groupNum))),
        ),
      ),
    );
  }
}

class GroupMemberWidget extends StatefulWidget {
  int groupNum;
  GroupMemberWidget(this.groupNum);

  @override
  State<GroupMemberWidget> createState() => new _GroupMemberWidget(groupNum);
}

class _GroupMemberWidget extends State<GroupMemberWidget> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _groupMemberListRequest();
  }

  int groupNum;
  _GroupMemberWidget(this.groupNum);
  GroupMemberListModel _groupMemberListModel;

  List _memberList = [];
  List _inviteMemberList = [];

  Widget memberListWidget;

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
    Sizing _sizing = Sizing(context);

    double _textL = _sizing.height(3);
    double _textBT = _sizing.height(2);
    double _listPaddingH = _sizing.width(6);

    double _pSize = _sizing.height(2.3);

    Color _bule = Color(0xff7AAAD8);

    GetImage _getImage = GetImage(context);

    if (_groupMemberListModel != null) {
      Widget inviteMemberList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _inviteMemberList.length,
        itemBuilder: (BuildContext context, int index) {
          var members = _inviteMemberList[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            leading: ClipOval(
              child: _getImage.friend(members.memberPhoto),
            ),
            title: Text(
              members.memberName,
              style: TextStyle(fontSize: _pSize),
            ),
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
              child: _getImage.friend(members.memberPhoto),
            ),
            title: Text(
              members.memberName,
              style: TextStyle(fontSize: _pSize),
            ),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      if (_inviteMemberList.length == 0) {
        memberListWidget = ListView(
          children: [
            Container(
                margin: EdgeInsets.only(top: _sizing.height(2)),
                child: memberList)
          ],
        );
      } else {
        memberListWidget = ListView(
          children: [
            Container(
              margin:
                  EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
              child:
                  Text('邀請中', style: TextStyle(fontSize: _pSize, color: _bule)),
            ),
            inviteMemberList,
            Container(
              margin:
                  EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
              child:
                  Text('成員', style: TextStyle(fontSize: _pSize, color: _bule)),
            ),
            memberList
          ],
        );
      }

      return memberListWidget;
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
