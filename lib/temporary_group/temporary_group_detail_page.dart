import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/common_schedule/common_schedule_list_page.dart';
import 'package:My_Day_app/group/group_invite_page.dart';
import 'package:My_Day_app/group/group_member_page.dart';
import 'package:My_Day_app/group/group_setting_page.dart';
import 'package:My_Day_app/models/get_group_model.dart';
import 'package:My_Day_app/models/group_log_model.dart';
import 'package:My_Day_app/vote/vote_list_page.dart';
import 'package:My_Day_app/vote/vote_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class TemporaryGroupDetailPage extends StatefulWidget {
  int groupNum;
  TemporaryGroupDetailPage(this.groupNum);

  @override
  _TemporaryGroupDetailWidget createState() =>
      new _TemporaryGroupDetailWidget(groupNum);
}

class _TemporaryGroupDetailWidget extends State<TemporaryGroupDetailPage> {
  int groupNum;
  _TemporaryGroupDetailWidget(this.groupNum);

  GetGroupModel _getGroupModel = null;
  GroupLogModel _groupLogModel = null;

  String uid = 'lili123';

  List<Widget> votesList = [];
  List _groupLogDate = [];
  List _groupLogDateIsShow = [];

  @override
  void initState() {
    super.initState();
    print(groupNum);
    _getGroupRequest();
    _groupLogRequest();
  }

  void _getGroupRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/get_group.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
        '/group/get/', {'uid': uid, 'groupNum': groupNum.toString()}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(jsonString);

    var jsonBody = json.decode(jsonString);

    var getGroupModel = GetGroupModel.fromJson(jsonBody);

    setState(() {
      _getGroupModel = getGroupModel;
    });
  }

  void _groupLogRequest() async {
    // var jsonString = await rootBundle.loadString('assets/json/group_log.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
        '/group/get_log/', {'uid': uid, 'groupNum': groupNum.toString()}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(jsonString);

    var jsonBody = json.decode(jsonString);

    var groupLogModel = GroupLogModel.fromJson(jsonBody);

    setState(() {
      _groupLogModel = groupLogModel;
      _groupLogDate = new List();
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
    print(_groupLogDate);
  }

  selectedItem(BuildContext context, item) async {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GroupInvitePage(groupNum)));
        break;
      case 1:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GroupMemberPage(groupNum)));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GroupSettingPage(groupNum)));
        break;
      case 3:
        Navigator.of(context).pop();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_getGroupModel != null && _groupLogModel != null) {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                PopupMenuButton<int>(
                  offset: Offset(50, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 0,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text("邀請",
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.041)))),
                    PopupMenuDivider(
                      height: 1,
                    ),
                    PopupMenuItem<int>(
                        value: 1,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text("成員",
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.041)))),
                    PopupMenuDivider(
                      height: 1,
                    ),
                    PopupMenuItem<int>(
                        value: 2,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text("設定",
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.041)))),
                    PopupMenuDivider(
                      height: 1,
                    ),
                    PopupMenuItem<int>(
                        value: 3,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text("退出",
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.041)))),
                  ],
                  onSelected: (item) => selectedItem(context, item),
                ),
              ],
              leading: Container(
                margin: EdgeInsets.only(left: screenSize.height * 0.02),
                child: GestureDetector(
                  child: Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              title: Text(_getGroupModel.title,
                  style: TextStyle(fontSize: screenSize.width * 0.052))),
          body: Container(color: Colors.white, child: _buildGroup(context)));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildGroup(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_getGroupModel.vote.length != 0) {
      return Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: screenSize.height * 0.067),
                      child: _buildGroupState(context))),
              _buildGroupList(context)
            ],
          ),
          _buildVote(context),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(child: _buildGroupState(context)),
          _buildGroupList(context)
        ],
      );
    }
  }

  Widget _buildVoteState(bool isVoteType, int voteNum) {
    var screenSize = MediaQuery.of(context).size;
    if (isVoteType == true) {
      return Container(
        margin: EdgeInsets.only(right: screenSize.height * 0.01),
        child: InkWell(
          child: Text('投票',
              style: TextStyle(
                  fontSize: screenSize.width * 0.041,
                  color: Theme.of(context).primaryColor)),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VotePage(voteNum, groupNum)));
          },
        ),
      );
    } else {
      return Text('已投票',
          style: TextStyle(
              fontSize: screenSize.width * 0.041, color: Color(0xff959595)));
    }
  }

  Widget _buildVote(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    setState(() {
      votesList = [];
      for (int i = 0; i < _getGroupModel.vote.length; i++) {
        var votes = _getGroupModel.vote[i];
        votesList.add(
          ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05, vertical: 0.0),
              title: Text(votes.title,
                  style: TextStyle(fontSize: screenSize.width * 0.041)),
              leading: Container(
                margin: EdgeInsets.only(left: screenSize.height * 0.01),
                child: Image.asset(
                  'assets/images/vote.png',
                  width: screenSize.width * 0.06,
                ),
              ),
              trailing: _buildVoteState(votes.isVoteType, votes.voteNum)),
        );
      }
    });

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          color: Theme.of(context).primaryColorDark,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: Text('投票',
                    style: TextStyle(
                        fontSize: screenSize.width * 0.043,
                        color: Colors.black)),
                leading: Container(
                  alignment: Alignment.center,
                  height: screenSize.height * 0.039,
                  width: screenSize.width * 0.16,
                  decoration: new BoxDecoration(
                    color: Color(0xffEFB208),
                    borderRadius: BorderRadius.all(
                        Radius.circular(screenSize.height * 0.01)),
                  ),
                  child: Text(
                    '進行中',
                    style: TextStyle(
                        fontSize: screenSize.width * 0.033,
                        color: Colors.white),
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColorDark,
                children: votesList),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupState(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_groupLogModel.groupContent.length != 0) {
      return ListView.builder(
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
            margin: EdgeInsets.only(top: screenSize.height * 0.01),
            child: Column(
              children: [
                Visibility(
                    visible: _groupLogDateIsShow[index],
                    child: Text(
                      dateString,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.033,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      top: screenSize.height * 0.01,
                      bottom: screenSize.height * 0.005,
                      left: screenSize.height * 0.01),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        timeString,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.033,
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.only(left: screenSize.height * 0.02),
                          child: Text(
                            groupContent.name + " " + groupContent.logContent,
                            style: TextStyle(
                              fontSize: screenSize.width * 0.033,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      return Container(
          alignment: Alignment.center, height: 100, child: Text('目前沒有任何log喔！'));
    }
  }

  Widget _buildGroupList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomCenter,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Divider(height: 1),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.08,
                vertical: screenSize.height * 0.01),
            title: Text('投票',
                style: TextStyle(fontSize: screenSize.width * 0.052)),
            leading: Image.asset(
              'assets/images/vote.png',
              width: screenSize.width * 0.08,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xffE3E3E3),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VoteListPage(groupNum)));
            },
          ),
          Divider(height: 1),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.08,
                vertical: screenSize.height * 0.01),
            title: Text('共同行程',
                style: TextStyle(fontSize: screenSize.width * 0.052)),
            leading: Image.asset(
              'assets/images/share_schedule.png',
              width: screenSize.width * 0.08,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xffE3E3E3),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommonScheduleListPage(groupNum)));
            },
          ),
        ],
      ),
    );
  }
}
