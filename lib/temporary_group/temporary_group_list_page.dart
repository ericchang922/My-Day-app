import 'dart:convert';

import 'package:My_Day_app/group/group_request.dart';
import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/temporary_group/temporary_group_list_model.dart';
import 'package:My_Day_app/temporary_group/temporary_group_create_page.dart';
import 'package:My_Day_app/temporary_group/temporary_group_detail_page.dart';
import 'package:My_Day_app/temporary_group/temporary_group_invite_page.dart';
import 'package:My_Day_app/temporary_group/temporary_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar temporaryGroupListAppBar(context) {
  Size size = MediaQuery.of(context).size;
  double _width = size.width;
  double _titleSize = _width * 0.052;

  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    title: Text('玩聚', style: TextStyle(fontSize: _titleSize)),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TemporaryGroupCreatePage()));
          },
          icon: Icon(Icons.add))
    ],
  );
}

class TemporaryGroupListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TemporaryGroupListWidget();
  }
}

class TemporaryGroupListWidget extends StatefulWidget {
  @override
  _TemporaryGroupListState createState() => new _TemporaryGroupListState();
}

class _TemporaryGroupListState extends State<TemporaryGroupListWidget>
    with RouteAware {
  String uid = 'lili123';

  TemporaryGroupListModel _temporaryGroupListModel = null;
  TemporaryGroupListModel _temporaryGroupInviteListModel = null;

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
    _temporaryGroupListRequest();
    _temporaryGroupInviteListRequest();
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
    _temporaryGroupListRequest();
    _temporaryGroupInviteListRequest();
  }

  _temporaryGroupListRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/temporary_group_list.json');
    // var responseBody = json.decode(response);

    await TemporaryList(uid).temporaryList().then((responseBody) {
      var temporaryGroupListModel =
          TemporaryGroupListModel.fromJson(responseBody);
      setState(() {
        _temporaryGroupListModel = temporaryGroupListModel;
      });
    });
  }

  _temporaryGroupInviteListRequest() async {
    // var response = await rootBundle
    //     .loadString('assets/json/temporary_group_invite_list.json');
    // var responseBody = json.decode(response);

    await TemporaryInviteList(uid).temporaryInviteList().then((responseBody) {
      var temporaryGroupInviteListModel =
          TemporaryGroupListModel.fromJson(responseBody);
      setState(() {
        _temporaryGroupInviteListModel = temporaryGroupInviteListModel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _listL = _width * 0.06;
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

    String _scheduleTime(index, bool isInvite) {
      var temporaryContent;
      if (isInvite)
        temporaryContent =
            _temporaryGroupInviteListModel.temporaryContent[index];
      else
        temporaryContent = _temporaryGroupListModel.temporaryContent[index];
      DateTime _startTime = temporaryContent.startTime;
      DateTime _endTime = temporaryContent.endTime;
      String startTime =
          "${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}";
      String endTime =
          "${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}";
      if (_startTime.day == _endTime.day &&
          _startTime.month == _endTime.month &&
          _startTime.year == _endTime.year) {
        if (startTime == "00:00" && endTime == "00:00" ||
            startTime == "00:00" && endTime == "23:59") {
          return "整天";
        } else {
          return startTime + " - " + endTime;
        }
      } else {
        return startTime + " - ";
      }
    }

    if (_temporaryGroupListModel != null &&
        _temporaryGroupInviteListModel != null) {
      Widget inviteList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _temporaryGroupInviteListModel.temporaryContent.length,
        itemBuilder: (BuildContext context, int index) {
          var temporaryContent =
              _temporaryGroupInviteListModel.temporaryContent[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      TemporaryGroupInvitePage(temporaryContent.groupId)));
            },
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: _listL),
                  child: CircleAvatar(
                    radius: _typeSize,
                    backgroundColor:
                        Color(typeColor[temporaryContent.typeId - 1]),
                  ),
                ),
                SizedBox(
                  width: _width * 0.16,
                  child: Container(
                    margin: EdgeInsets.only(left: _listL),
                    child: Column(
                      children: [
                        Text(temporaryContent.startTime.month.toString() + "月",
                            style: TextStyle(fontSize: _subtitleSize)),
                        Text(temporaryContent.startTime.day.toString() + "日",
                            style: TextStyle(fontSize: _titleSize)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: _width * 0.57,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: _textL),
                        child: Text(
                            '${temporaryContent.title} (${temporaryContent.peopleCount})',
                            style: TextStyle(fontSize: _titleSize)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: _textL, top: _subtitleT),
                        child: Text(_scheduleTime(index, true),
                            style: TextStyle(
                                fontSize: _subtitleSize, color: _gray)),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Text('加入',
                            style: TextStyle(fontSize: _pSize, color: _color)),
                        onTap: () async {
                          await _submit(true, temporaryContent.groupId);
                          _temporaryGroupListRequest();
                          _temporaryGroupInviteListRequest();
                        },
                      ),
                    ),
                    SizedBox(
                      height: _widthSize,
                    ),
                    InkWell(
                      child: Text('拒絕',
                          style: TextStyle(fontSize: _pSize, color: _gray)),
                      onTap: () async {
                        await _submit(false, temporaryContent.groupId);
                        _temporaryGroupListRequest();
                        _temporaryGroupInviteListRequest();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      Widget groupList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _temporaryGroupListModel.temporaryContent.length,
        itemBuilder: (BuildContext context, int index) {
          var temporaryContent =
              _temporaryGroupListModel.temporaryContent[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      TemporaryGroupDetailPage(temporaryContent.groupId)));
            },
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: _listL),
                  child: CircleAvatar(
                    radius: _typeSize,
                    backgroundColor:
                        Color(typeColor[temporaryContent.typeId - 1]),
                  ),
                ),
                SizedBox(
                  width: _width * 0.16,
                  child: Container(
                    margin: EdgeInsets.only(left: _listL),
                    child: Column(
                      children: [
                        Text(temporaryContent.startTime.month.toString() + "月",
                            style: TextStyle(fontSize: _subtitleSize)),
                        Text(temporaryContent.startTime.day.toString() + "日",
                            style: TextStyle(fontSize: _titleSize)),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: _textL),
                      child: Text(
                          '${temporaryContent.title} (${temporaryContent.peopleCount})',
                          style: TextStyle(fontSize: _titleSize)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: _textL, top: _subtitleT),
                      child: Text(_scheduleTime(index, false),
                          style:
                              TextStyle(fontSize: _subtitleSize, color: _gray)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      Widget noGroup = Center(child: Text('目前沒有任何玩聚喔！'));

      if (_temporaryGroupInviteListModel.temporaryContent.length != 0) {
        groupListWiget = ListView(
          children: [
            Container(
              margin:
                  EdgeInsets.only(left: _textL, bottom: _textBT, top: _textBT),
              child: Text('邀約',
                  style: TextStyle(fontSize: _pSize, color: Color(0xff7AAAD8))),
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
      } else if (_temporaryGroupListModel.temporaryContent.length != 0) {
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
      return Scaffold(
          body: SafeArea(
              child: Container(
                  color: _color,
                  child: Container(
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator()),
                  ))));
    }
  }
}
