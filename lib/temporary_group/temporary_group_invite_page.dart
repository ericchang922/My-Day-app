import 'dart:convert';

import 'package:My_Day_app/public/group_request/member_status.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/public/temporary_group_request/get_invite.dart';
import 'package:My_Day_app/models/temporary_group/get_temporary_group_invitet_model.dart';
import 'package:My_Day_app/schedule/schedule_form.dart';

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

  String uid = 'lili123';
  String _startTime = "";
  String _endTime = "";

  List _memberList = [];
  List _inviteMemberList = [];

  @override
  void initState() {
    super.initState();
    _getTemporaryGroupInviteRequest();
  }

  String _dateFormat(dateTime) {
    String dateString =
        '${dateTime.month.toString().padLeft(2, '0')} 月 ${dateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[dateTime.weekday - 1]} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return dateString;
  }

  _getTemporaryGroupInviteRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/get_temporary_group_invite.json');
    // var responseBody = json.decode(response);

    GetTemporaryGroupInviteModel _request =
        await GetInvite(uid: uid, groupNum: groupNum).getData();
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
        }
      }
    });
  }

  Image getImage(String imageString) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _imgSize = _height * 0.045;
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
      print('error');
    }));

    if (isGetImage == null) {
      return image;
    } else {
      return friendImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _listPaddingH = _width * 0.06;
    double _bottomHeight = _height * 0.07;
    double _bottomIconWidth = _width * 0.05;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _leadingL = _height * 0.02;

    double _appBarSize = _width * 0.052;
    double _pSize = _height * 0.023;
    double _titleSize = _height * 0.025;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);

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
                  child: getImage(members.memberPhoto),
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
              child: getImage(_getTemporaryGroupInviteModel.founderPhoto),
            ),
            title: Text(
              _getTemporaryGroupInviteModel.founderName,
              style: TextStyle(fontSize: _pSize),
            ),
            trailing: Text("建立者", style: TextStyle(fontSize: _pSize)),
          ),
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
                  child: getImage(members.memberPhoto),
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
            height: _height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("開始", style: TextStyle(fontSize: _titleSize)),
              Text(_startTime, style: TextStyle(fontSize: _titleSize)),
            ],
          ),
          SizedBox(
            height: _height * 0.015,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("結束", style: TextStyle(fontSize: _titleSize)),
              Text(_endTime, style: TextStyle(fontSize: _titleSize)),
            ],
          ),
          SizedBox(
            height: _height * 0.02,
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
