import 'package:flutter/material.dart';

import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/public/group_request/setting_manager.dart';
import 'package:My_Day_app/models/group/group_member_list_model.dart';
import 'package:My_Day_app/public/group_request/member_list.dart';

class GroupManagerPage extends StatelessWidget {
  int groupNum;
  GroupManagerPage(this.groupNum);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _leadingL = _height * 0.02;
    double _appBarSize = _width * 0.052;

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

  String uid = 'lili123';

  List _memberList = [];
  List _managerList = [];

  bool _isManager = false;

  @override
  void initState() {
    super.initState();
    _groupMemberListRequest();
  }

  _groupMemberListRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/group_members.json');
    // var responseBody = json.decode(response);

    GroupMemberListModel _request =
        await MemberList(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _groupMemberListModel = _request;
      // ignore: deprecated_member_use
      _managerList = new List();
      // ignore: deprecated_member_use
      _memberList = new List();

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _listPaddingH = _width * 0.06;

    double _pSize = _height * 0.023;

    Color _bule = Color(0xff7AAAD8);
    Color _gray = Color(0xff959595);
    Color _color = Theme.of(context).primaryColor;

    Widget managerWidget;

    GetImage _getImage = GetImage(context);

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
              child: _getImage.friend(members.memberPhoto),
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
              child: _getImage.friend(members.memberPhoto),
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
                margin: EdgeInsets.only(top: _height * 0.02),
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
                margin: EdgeInsets.only(top: _height * 0.02),
                child: managerList)
          ],
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
