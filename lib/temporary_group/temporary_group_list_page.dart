import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/temporary_group_list_model.dart';
import 'package:My_Day_app/temporary_group/temporary_group_detail_page.dart';
import 'package:My_Day_app/temporary_group/temporary_group_invite_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar temporaryGroupListAppBar(context) {
  var screenSize = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    title: Text('玩聚', style: TextStyle(fontSize: screenSize.width * 0.052)),
    actions: [
      IconButton(
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => VoteCreatePage(groupNum)));
          },
          icon: Icon(Icons.add))
    ],
  );
}

class TemporaryGroupListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: Theme.of(context).primaryColor,
      child: Container(color: Colors.white, child: TemporaryGroupListWidget()),
    )));
  }
}

class TemporaryGroupListWidget extends StatefulWidget {
  @override
  _TemporaryGroupListState createState() => new _TemporaryGroupListState();
}

class _TemporaryGroupListState extends State<TemporaryGroupListWidget> {
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

  Future _temporaryGroupListRequest() async {
    // var jsonString =
    //     await rootBundle.loadString('assets/json/temporary_group_list.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http(
        'myday.sytes.net', '/temporary_group/temporary_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonMap = json.decode(jsonString);

    var temporaryGroupListModel = TemporaryGroupListModel.fromJson(jsonMap);
    setState(() {
      _temporaryGroupListModel = temporaryGroupListModel;
    });
  }

  Future _temporaryGroupInviteListRequest() async {
    // var jsonString = await rootBundle
    //     .loadString('assets/json/temporary_group_invite_list.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http(
        'myday.sytes.net', '/temporary_group/invite_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonMap = json.decode(jsonString);

    var temporaryGroupInviteListModel =
        TemporaryGroupListModel.fromJson(jsonMap);
    setState(() {
      _temporaryGroupInviteListModel = temporaryGroupInviteListModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_temporaryGroupListModel != null &&
        _temporaryGroupInviteListModel != null) {
      if (_temporaryGroupInviteListModel.temporaryContent.length != 0) {
        return _buildTemporaryGroupInviteListWidget(context);
      } else if (_temporaryGroupListModel.temporaryContent.length != 0) {
        return Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.01),
            child: _buildTemporaryGroupList(context));
      } else {
        return _buildNoGroup(context);
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildNoGroup(BuildContext context) {
    return Container(
        alignment: Alignment.center, height: 100, child: Text('目前沒有任何玩聚喔！'));
  }

  Widget _buildTemporaryGroupInviteListWidget(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: screenSize.height * 0.03,
              bottom: screenSize.height * 0.02,
              top: screenSize.height * 0.02),
          child: Text('邀約',
              style: TextStyle(
                  fontSize: screenSize.width * 0.041,
                  color: Color(0xff7AAAD8))),
        ),
        _buildTemporaryGroupInviteList(context),
        Container(
          margin: EdgeInsets.only(
              left: screenSize.height * 0.03,
              bottom: screenSize.height * 0.02,
              top: screenSize.height * 0.02),
          child: Text('已加入',
              style: TextStyle(
                  fontSize: screenSize.width * 0.041,
                  color: Color(0xff7AAAD8))),
        ),
        _buildTemporaryGroupList(context)
      ],
    );
  }

  Widget _buildTemporaryGroupInviteList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    String _scheduleTime(index) {
      var temporaryContent =
          _temporaryGroupInviteListModel.temporaryContent[index];
      String startTime = formatDate(
          DateTime(
              temporaryContent.startTime.year,
              temporaryContent.startTime.month,
              temporaryContent.startTime.day,
              temporaryContent.startTime.hour,
              temporaryContent.startTime.minute),
          [HH, ':', nn]);

      String endTime = formatDate(
          DateTime(
              temporaryContent.endTime.year,
              temporaryContent.endTime.month,
              temporaryContent.endTime.day,
              temporaryContent.endTime.hour,
              temporaryContent.endTime.minute),
          [HH, ':', nn]);
      if (temporaryContent.startTime.year == temporaryContent.endTime.year) {
        return startTime + " - " + endTime;
      } else {
        return startTime + " - ";
      }
    }

    return ListView.separated(
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
          child: Container(
            width: screenSize.width,
            margin: EdgeInsets.only(
              top: screenSize.height * 0.01,
              bottom: screenSize.height * 0.01,
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenSize.height * 0.04),
                  child: CircleAvatar(
                    radius: screenSize.width * 0.045,
                    backgroundColor:
                        Color(typeColor[temporaryContent.typeId - 1]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenSize.height * 0.02),
                  child: Column(
                    children: [
                      Text(temporaryContent.startTime.month.toString() + "月",
                          style: TextStyle(fontSize: screenSize.width * 0.035)),
                      Text(temporaryContent.startTime.day.toString() + "日",
                          style: TextStyle(fontSize: screenSize.width * 0.046)),
                    ],
                  ),
                ),
                Container(
                  width: screenSize.width * 0.56,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: screenSize.height * 0.03),
                        child: Text(
                            '${temporaryContent.title} (${temporaryContent.peopleCount})',
                            style:
                                TextStyle(fontSize: screenSize.width * 0.045)),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenSize.height * 0.03,
                            top: screenSize.height * 0.008),
                        child: Text(_scheduleTime(index),
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Color(0xff959595))),
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
                            style: TextStyle(
                                fontSize: screenSize.width * 0.041,
                                color: Theme.of(context).primaryColor)),
                        onTap: () {
                          print('已加入${temporaryContent.groupId}');
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenSize.width * 0.01,
                    ),
                    InkWell(
                      child: Text('拒絕',
                          style: TextStyle(
                              fontSize: screenSize.width * 0.041,
                              color: Color(0xff959595))),
                      onTap: () {
                        print('已拒絕${temporaryContent.groupId}');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildTemporaryGroupList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    String _scheduleTime(index) {
      var temporaryContent = _temporaryGroupListModel.temporaryContent[index];
      String startTime = formatDate(
          DateTime(
              temporaryContent.startTime.year,
              temporaryContent.startTime.month,
              temporaryContent.startTime.day,
              temporaryContent.startTime.hour,
              temporaryContent.startTime.minute),
          [HH, ':', nn]);

      String endTime = formatDate(
          DateTime(
              temporaryContent.endTime.year,
              temporaryContent.endTime.month,
              temporaryContent.endTime.day,
              temporaryContent.endTime.hour,
              temporaryContent.endTime.minute),
          [HH, ':', nn]);
      if (temporaryContent.startTime.year == temporaryContent.endTime.year) {
        return startTime + " - " + endTime;
      } else {
        return startTime + " - ";
      }
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _temporaryGroupListModel.temporaryContent.length,
      itemBuilder: (BuildContext context, int index) {
        var temporaryContent = _temporaryGroupListModel.temporaryContent[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TemporaryGroupDetailPage(temporaryContent.groupId)));
          },
          child: Container(
            margin: EdgeInsets.only(
              top: screenSize.height * 0.01,
              bottom: screenSize.height * 0.01,
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenSize.height * 0.04),
                  child: CircleAvatar(
                    radius: screenSize.width * 0.045,
                    backgroundColor:
                        Color(typeColor[temporaryContent.typeId - 1]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenSize.height * 0.02),
                  child: Column(
                    children: [
                      Text(temporaryContent.startTime.month.toString() + "月",
                          style: TextStyle(fontSize: screenSize.width * 0.035)),
                      Text(temporaryContent.startTime.day.toString() + "日",
                          style: TextStyle(fontSize: screenSize.width * 0.046)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: screenSize.height * 0.03),
                      child: Text(
                          '${temporaryContent.title} (${temporaryContent.peopleCount})',
                          style: TextStyle(fontSize: screenSize.width * 0.045)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: screenSize.height * 0.03,
                          top: screenSize.height * 0.008),
                      child: Text(_scheduleTime(index),
                          style: TextStyle(
                              fontSize: screenSize.width * 0.035,
                              color: Color(0xff959595))),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
