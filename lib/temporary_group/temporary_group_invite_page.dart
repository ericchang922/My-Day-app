import 'package:flutter/material.dart';

import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/public/group_request/member_status.dart';
import 'package:My_Day_app/public/temporary_group_request/get_invite.dart';
import 'package:My_Day_app/models/temporary_group/get_temporary_group_invitet_model.dart';
import 'package:My_Day_app/schedule/schedule_form.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class TemporaryGroupInvitePage extends StatefulWidget {
  int groupNum;
  TemporaryGroupInvitePage(this.groupNum);

  @override
  TemporaryGroupInviteWidget createState() =>
      new TemporaryGroupInviteWidget(groupNum);
}

class TemporaryGroupInviteWidget extends State<TemporaryGroupInvitePage> {
  int groupNum;
  TemporaryGroupInviteWidget(this.groupNum);

  GetTemporaryGroupInviteModel _getTemporaryGroupInviteModel;

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getTemporaryGroupInviteRequest();
  }

  String _startTime = "";
  String _endTime = "";

  List _memberList = [];
  List _inviteMemberList = [];

  @override
  void initState() {
    super.initState();
    _uid();
  }

  String _dateFormat(dateTime) {
    String dateString =
        '${dateTime.month.toString().padLeft(2, '0')} 月 ${dateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[dateTime.weekday - 1]} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return dateString;
  }

  _getTemporaryGroupInviteRequest() async {
    GetTemporaryGroupInviteModel _request =
        await GetInvite(context: context, uid: uid, groupNum: groupNum)
            .getData();
    setState(() {
      _memberList = [];
      _inviteMemberList = [];

      _getTemporaryGroupInviteModel = _request;
      _startTime = _dateFormat(_getTemporaryGroupInviteModel.startTime);
      _endTime = _dateFormat(_getTemporaryGroupInviteModel.endTime);

      for (int i = 0; i < _getTemporaryGroupInviteModel.member.length; i++) {
        if (_getTemporaryGroupInviteModel.member[i].statusId == 2) {
          _inviteMemberList.add(_getTemporaryGroupInviteModel.member[i]);
        }
        if (_getTemporaryGroupInviteModel.member[i].statusId == 1 &&
            _getTemporaryGroupInviteModel.member[i].memberName !=
                _getTemporaryGroupInviteModel.founderName) {
          _memberList.add(_getTemporaryGroupInviteModel.member[i]);
          if (_getTemporaryGroupInviteModel.member[i].statusId == 4 &&
              _getTemporaryGroupInviteModel.member[i].memberName !=
                  _getTemporaryGroupInviteModel.founderName) {
            _memberList.add(_getTemporaryGroupInviteModel.member[i]);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listPaddingH = _sizing.width(6);
    double _bottomHeight = _sizing.height(7);
    double _bottomIconWidth = _sizing.width(5);
    double _textL = _sizing.height(3);
    double _textBT = _sizing.height(2);
    double _leadingL = _sizing.height(2);

    double _appBarSize = _sizing.width(5.2);
    double _pSize = _sizing.height(2.3);
    double _titleSize = _sizing.height(2.5);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);

    GetImage _getImage = GetImage(context);

    _submit() async {
      int statusId = 1;
      var submitWidget;
      _submitWidgetfunc() async {
        return MemberStatus(uid: uid, groupNum: groupNum, statusId: statusId);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    if (_getTemporaryGroupInviteModel != null) {
      Widget inviteMemberList = ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin:
                EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
            child:
                Text('邀請中', style: TextStyle(fontSize: _pSize, color: _bule)),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _inviteMemberList.length,
            itemBuilder: (BuildContext context, int index) {
              var members = _inviteMemberList[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: _listPaddingH, vertical: 0.0),
                leading: ClipOval(
                  child: _getImage.friend(members.memberPhoto),
                ),
                title: Text(
                  members.memberName,
                  style: TextStyle(fontSize: _pSize),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          )
        ],
      );

      Widget memberList = ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin:
                EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
            child: Text('成員', style: TextStyle(fontSize: _pSize, color: _bule)),
          ),
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            leading: ClipOval(
              child:
                  _getImage.friend(_getTemporaryGroupInviteModel.founderPhoto),
            ),
            title: Text(
              _getTemporaryGroupInviteModel.founderName,
              style: TextStyle(fontSize: _pSize),
            ),
            trailing: Text("建立者", style: TextStyle(fontSize: _pSize)),
          ),
          if (_memberList.length != 0) Divider(),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _memberList.length,
            itemBuilder: (BuildContext context, int index) {
              var members = _memberList[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: _listPaddingH, vertical: 0.0),
                leading: ClipOval(
                  child: _getImage.friend(members.memberPhoto),
                ),
                title: Text(
                  members.memberName,
                  style: TextStyle(fontSize: _pSize),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          )
        ],
      );
      Widget memberlistWidget = ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          if (_inviteMemberList.length != 0) inviteMemberList,
          memberList
        ],
      );

      Widget groupInviteWidget = ListView(
        children: [
          SizedBox(
            height: _sizing.height(2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("開始", style: TextStyle(fontSize: _titleSize)),
              Text(_startTime, style: TextStyle(fontSize: _titleSize)),
            ],
          ),
          SizedBox(
            height: _sizing.height(1.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("結束", style: TextStyle(fontSize: _titleSize)),
              Text(_endTime, style: TextStyle(fontSize: _titleSize)),
            ],
          ),
          SizedBox(
            height: _sizing.height(2),
          ),
          Divider(),
          memberlistWidget
        ],
      );

      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title: Text(_getTemporaryGroupInviteModel.title,
                  style: TextStyle(fontSize: _appBarSize)),
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
            body: Container(color: Colors.white, child: groupInviteWidget),
            bottomNavigationBar: Container(
              color: Theme.of(context).bottomAppBarColor,
              child: SafeArea(
                top: false,
                child: BottomAppBar(
                  elevation: 0,
                  child: Row(children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: _bottomHeight,
                        child: RawMaterialButton(
                            elevation: 0,
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: _bottomIconWidth,
                            ),
                            fillColor: _light,
                            onPressed: () => Navigator.pop(context)),
                      ),
                    ), // 取消按鈕
                    Expanded(
                      child: SizedBox(
                        height: _bottomHeight,
                        child: RawMaterialButton(
                          elevation: 0,
                          child: Image.asset(
                            'assets/images/confirm.png',
                            width: _bottomIconWidth,
                          ),
                          fillColor: _color,
                          onPressed: () async {
                            if (await _submit() != true) Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
  }
}
