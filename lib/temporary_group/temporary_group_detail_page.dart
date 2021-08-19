import 'dart:async';

import 'package:My_Day_app/models/group/group_member_list_model.dart';
import 'package:My_Day_app/public/group_request/member_list.dart';
import 'package:My_Day_app/public/group_request/quit_group.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/common_schedule/common_schedule_list_page.dart';
import 'package:My_Day_app/group/group_invite_page.dart';
import 'package:My_Day_app/group/group_member_page.dart';
import 'package:My_Day_app/group/group_setting_page.dart';
import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/group/get_group_model.dart';
import 'package:My_Day_app/models/group/group_log_model.dart';
import 'package:My_Day_app/public/group_request/get.dart';
import 'package:My_Day_app/public/group_request/get_log.dart';
import 'package:My_Day_app/vote/vote_list_page.dart';
import 'package:My_Day_app/vote/vote_page.dart';

import 'package:date_format/date_format.dart';

class TemporaryGroupDetailPage extends StatefulWidget {
  int groupNum;
  TemporaryGroupDetailPage(this.groupNum);

  @override
  _TemporaryGroupDetailWidget createState() =>
      new _TemporaryGroupDetailWidget(groupNum);
}

class _TemporaryGroupDetailWidget extends State<TemporaryGroupDetailPage>
    with RouteAware {
  int groupNum;
  _TemporaryGroupDetailWidget(this.groupNum);

  GetGroupModel _getGroupModel;
  GroupLogModel _groupLogModel;
  GroupMemberListModel _groupMemberListModel;

  String uid = 'lili123';

  List<Widget> _votesList = [];
  List _groupLogDate = [];
  List _groupLogDateIsShow = [];
  List _managerList = [];

  bool _isManager = false;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _getGroupRequest();
    _groupLogRequest();
    _getGroupMemberRequest();
    print(groupNum);
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
    _getGroupRequest();
    _groupLogRequest();
    _getGroupMemberRequest();
  }

  _getGroupRequest() async {
    // var response = await rootBundle.loadString('assets/json/get_group.json');
    // var responseBody = json.decode(response);

    GetGroupModel _request = await Get(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _getGroupModel = _request;
    });
  }

  _groupLogRequest() async {
    // var response = await rootBundle.loadString('assets/json/group_log.json');
    // var responseBody = json.decode(response);

    GroupLogModel _request =
        await GetLog(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _groupLogModel = _request;
      // ignore: deprecated_member_use
      _groupLogDate = new List();
      // ignore: deprecated_member_use
      _groupLogDateIsShow = new List();

      for (int i = 0; i < _groupLogModel.groupContent.length; i++) {
        DateTime doTime = _groupLogModel.groupContent[i].doTime;
        String dateString = formatDate(
            DateTime(doTime.year, doTime.month, doTime.day),
            [yyyy, '年', mm, '月', dd, '日 ']);
        _groupLogDateIsShow.add(false);
        if (_groupLogDate.indexOf(dateString) == -1) {
          _groupLogDate.add(dateString);
          _groupLogDateIsShow[i] = true;
        }
      }
    });
  }

  _getGroupMemberRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/group_members.json');
    // var responseBody = json.decode(response);

    GroupMemberListModel _request =
        await MemberList(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _groupMemberListModel = _request;

      for (int i = 0; i < _groupMemberListModel.member.length; i++) {
        if (_groupMemberListModel.member[i].statusId == 4) {
          _managerList.add(_groupMemberListModel.member[i].memberId);
        }
      }
      for (int i = 0; i < _managerList.length; i++) {
        if (_managerList[i] == uid) {
          _isManager = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _leadingL = _height * 0.02;
    double _listPaddingH = _width * 0.08;

    double _appBarSize = _width * 0.052;
    double _pSize = _height * 0.023;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _iconSize = _width * 0.08;

    Color _yellow = Color(0xffEFB208);
    Color _gray = Color(0xff959595);
    Color _lightGray = Color(0xffE3E3E3);
    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorDark;

    Widget _groupWidget;
    Widget groupLog;
    Widget noGroupLog = Center(child: Text('目前沒有任何log喔！'));

    _submit() async {
      var submitWidget;
      _submitWidgetfunc() async {
        return QuitGroup(uid: uid, groupNum: groupNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    selectedItem(BuildContext context, item) async {
      switch (item) {
        case 0:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GroupInvitePage(groupNum)));
          break;
        case 1:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GroupMemberPage(groupNum)));
          break;
        case 2:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GroupSettingPage(groupNum)));
          break;
        case 3:
          if (await _submit() != true) {
            Navigator.of(context).pop();
          }
          break;
      }
    }

    voteAction() {
      if (_isManager) {
        return PopupMenuButton<int>(
          offset: Offset(50, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_height * 0.01)),
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
                value: 0,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("邀請", style: TextStyle(fontSize: _subtitleSize)))),
            PopupMenuDivider(
              height: 1,
            ),
            PopupMenuItem<int>(
                value: 1,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("成員", style: TextStyle(fontSize: _subtitleSize)))),
            PopupMenuDivider(
              height: 1,
            ),
            PopupMenuItem<int>(
                value: 2,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("設定", style: TextStyle(fontSize: _subtitleSize)))),
            PopupMenuDivider(
              height: 1,
            ),
            PopupMenuItem<int>(
                value: 3,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("退出", style: TextStyle(fontSize: _subtitleSize)))),
          ],
          onSelected: (item) => selectedItem(context, item),
        );
      } else {
        return PopupMenuButton<int>(
          offset: Offset(50, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_height * 0.01)),
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
                value: 1,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("成員", style: TextStyle(fontSize: _subtitleSize)))),
            PopupMenuDivider(
              height: 1,
            ),
            PopupMenuItem<int>(
                value: 2,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("設定", style: TextStyle(fontSize: _subtitleSize)))),
            PopupMenuDivider(
              height: 1,
            ),
            PopupMenuItem<int>(
                value: 3,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("退出", style: TextStyle(fontSize: _subtitleSize)))),
          ],
          onSelected: (item) => selectedItem(context, item),
        );
      }
    }

    voteState(bool isVoteType, int voteNum) {
      if (isVoteType == true) {
        return Container(
          margin: EdgeInsets.only(right: _height * 0.01),
          child: InkWell(
            child:
                Text('投票', style: TextStyle(fontSize: _pSize, color: _color)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VotePage(voteNum, groupNum)));
            },
          ),
        );
      } else {
        return Text('已投票', style: TextStyle(fontSize: _pSize, color: _gray));
      }
    }

    voteWidget() {
      _votesList = [];
      for (int i = 0; i < _getGroupModel.vote.length; i++) {
        var votes = _getGroupModel.vote[i];
        _votesList.add(
          ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _width * 0.06, vertical: 0.0),
              title: Text(votes.title, style: TextStyle(fontSize: _pSize)),
              leading: Container(
                margin: EdgeInsets.only(left: _height * 0.01),
                child: Image.asset(
                  'assets/images/vote.png',
                  width: _width * 0.06,
                ),
              ),
              trailing: voteState(votes.isVoteType, votes.voteNum)),
        );
      }
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            color: _light,
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                  title: Text('投票',
                      style:
                          TextStyle(fontSize: _titleSize, color: Colors.black)),
                  leading: Container(
                    alignment: Alignment.center,
                    height: _height * 0.039,
                    width: _width * 0.16,
                    decoration: new BoxDecoration(
                      color: _yellow,
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.height * 0.01)),
                    ),
                    child: Text(
                      '進行中',
                      style: TextStyle(
                          fontSize: _subtitleSize, color: Colors.white),
                    ),
                  ),
                  backgroundColor: _light,
                  children: _votesList),
            ),
          ),
        ],
      );
    }

    if (_getGroupModel != null && _groupLogModel != null) {
      if (_groupLogModel.groupContent.length > 0)
        Timer(Duration(milliseconds: 500),
            () => _controller.jumpTo(_controller.position.maxScrollExtent));
      if (_groupLogModel.groupContent.length != 0) {
        groupLog = ListView.builder(
          controller: _controller,
          itemCount: _groupLogModel.groupContent.length,
          itemBuilder: (content, index) {
            var groupContent = _groupLogModel.groupContent[index];
            DateTime doTime = groupContent.doTime;
            String dateString = formatDate(
                DateTime(doTime.year, doTime.month, doTime.day),
                [yyyy, '年', mm, '月', dd, '日 ']);
            String timeString = formatDate(
                DateTime(doTime.year, doTime.month, doTime.day, doTime.hour,
                    doTime.minute),
                [HH, ':', nn]);

            return Container(
              margin: EdgeInsets.only(top: _height * 0.01),
              child: Column(
                children: [
                  Visibility(
                      visible: _groupLogDateIsShow[index],
                      child: Text(
                        dateString,
                        style: TextStyle(
                          fontSize: _subtitleSize,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        top: _height * 0.01,
                        bottom: _height * 0.005,
                        left: _height * 0.01),
                    child: Row(
                      children: [
                        Text(
                          timeString,
                          style: TextStyle(
                            fontSize: _subtitleSize,
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: _height * 0.02),
                              child: Text(
                                groupContent.name +
                                    " " +
                                    groupContent.logContent,
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: _subtitleSize,
                                ),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      } else {
        groupLog = noGroupLog;
      }

      Widget groupList = Container(
        alignment: Alignment.bottomCenter,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Divider(height: 1),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _listPaddingH, vertical: _height * 0.01),
              title: Text('投票', style: TextStyle(fontSize: _appBarSize)),
              leading: Image.asset(
                'assets/images/vote.png',
                width: _iconSize,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: _lightGray,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VoteListPage(groupNum)));
              },
            ),
            Divider(height: 1),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _listPaddingH, vertical: size.height * 0.01),
              title: Text('共同行程', style: TextStyle(fontSize: _appBarSize)),
              leading: Image.asset(
                'assets/images/share_schedule.png',
                width: _iconSize,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: _lightGray,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommonScheduleListPage(groupNum)));
              },
            ),
          ],
        ),
      );

      if (_getGroupModel.vote.length != 0) {
        _groupWidget = Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: _height * 0.067),
                        child: groupLog)),
                groupList
              ],
            ),
            voteWidget(),
          ],
        );
      } else {
        _groupWidget = Column(
          children: [Expanded(child: groupLog), groupList],
        );
      }

      return Scaffold(
          appBar: AppBar(
            backgroundColor: _color,
            title: Text(_getGroupModel.title,
                style: TextStyle(fontSize: _appBarSize)),
            actions: [voteAction()],
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
          body: Container(color: Colors.white, child: _groupWidget));
    } else {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
  }
}
