import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/get_group_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupVotesPage extends StatefulWidget {
  int groupNum;
  GroupVotesPage(this.groupNum);

  @override
  _GroupVotesWidget createState() => new _GroupVotesWidget(groupNum);
}

class _GroupVotesWidget extends State<GroupVotesPage> {
  String uid = 'lili123';

  // GetVoteListModel _getVoteListModel = null;

  int groupNum;
  _GroupVotesWidget(this.groupNum);

  @override
  void initState() {
    // _getVoteListRequest();
    super.initState();
  }

  // void _getVoteListRequest() async {
  //   // var reponse = await rootBundle.loadString('assets/json/get_group.json');

  //   var httpClient = HttpClient();
  //   var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
  //       '/vote/get_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
  //   var response = await request.close();
  //   var jsonString = await response.transform(utf8.decoder).join();
  //   httpClient.close();
  //   print(jsonString);

  //   var jsonBody = json.decode(jsonString);

  //   var getGroupModel = GetGroupModel.fromJson(jsonBody);

  //   setState(() {
  //     _getVoteListModel = getVoteListModel;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              leading: Container(
                margin: EdgeInsets.only(left: 5),
                child: GestureDetector(
                  child: Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              bottom:
                  TabBar(tabs: <Widget>[Tab(text: '開放中'), Tab(text: '已結束')]),
              title: Text('投票', style: TextStyle(fontSize: 20))),
          body: TabBarView(
            children: <Widget>[
              Center(child: Text("開放中")),
              Center(child: Text("已結束")),
            ],
          )),
    );
  }
}
