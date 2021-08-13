import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/vote/vote_end_list_model.dart';
import 'package:My_Day_app/models/vote/vote_list_model.dart';
import 'package:My_Day_app/vote/vote_create_page.dart';
import 'package:My_Day_app/vote/vote_page.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VoteListPage extends StatefulWidget {
  int groupNum;
  VoteListPage(this.groupNum);

  @override
  _VoteListWidget createState() => new _VoteListWidget(groupNum);
}

class _VoteListWidget extends State<VoteListPage> {
  String uid = 'lili123';

  VoteListModel _voteListModel = null;
  VoteEndListModel _voteEndListModel;

  int groupNum;
  _VoteListWidget(this.groupNum);

  @override
  void initState() {
    super.initState();
    _voteListRequest();
    _voteEndListRequest();
  }

  Future<void> _voteListRequest() async {
    // var jsonString = await rootBundle.loadString('assets/json/vote_list.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
        '/vote/get_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonMap = json.decode(jsonString);

    var voteListModel = VoteListModel.fromJson(jsonMap);
    setState(() {
      _voteListModel = voteListModel;
    });
  }

  Future<void> _voteEndListRequest() async {
    var jsonString =
        await rootBundle.loadString('assets/json/vote_end_list.json');

    // var httpClient = HttpClient();
    // var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
    //     '/vote/get_end_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    // var response = await request.close();
    // var jsonString = await response.transform(utf8.decoder).join();
    // httpClient.close();

    var jsonMap = json.decode(jsonString);

    var voteEndListModel = VoteEndListModel.fromJson(jsonMap);
    setState(() {
      _voteEndListModel = voteEndListModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('投票',
                style: TextStyle(fontSize: screenSize.width * 0.052)),
            leading: Container(
              margin: EdgeInsets.only(left: screenSize.height * 0.02),
              child: GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VoteCreatePage(groupNum)));
                  },
                  icon: Icon(Icons.add))
            ],
            bottom: TabBar(
              indicator: ShapeDecoration(
                  shape: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffEFB208),
                          width: 0,
                          style: BorderStyle.solid)),
                  gradient: LinearGradient(
                      colors: [Color(0xffEFB208), Color(0xffEFB208)])),
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xffe3e3e3),
              indicatorPadding: EdgeInsets.all(0.0),
              indicatorWeight: screenSize.width * 0.01,
              labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              tabs: <Widget>[
                Container(
                  height: screenSize.height * 0.04683,
                  alignment: Alignment.center,
                  color: Theme.of(context).primaryColor,
                  child: Text("開放中",
                      style: TextStyle(fontSize: screenSize.width * 0.041)),
                ),
                Container(
                  height: screenSize.height * 0.04683,
                  alignment: Alignment.center,
                  color: Theme.of(context).primaryColor,
                  child: Text("已結束",
                      style: TextStyle(fontSize: screenSize.width * 0.041)),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(color: Colors.white, child: _buildVoteList(context)),
              Container(color: Colors.white, child: _buildVoteEndList(context)),
            ],
          )),
    );
  }

  Widget _buildVoteState(bool isVoteType, int voteNum) {
    var screenSize = MediaQuery.of(context).size;
    if (isVoteType == false) {
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
    }
    else {
      return InkWell(
        child: Text('已投票',
            style: TextStyle(
                fontSize: screenSize.width * 0.041, color: Color(0xff959595))),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VotePage(voteNum, groupNum)));
        },
      );
    }
  }

  Widget _buildVoteList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_voteListModel != null) {
      if (_voteListModel.vote.length == 0) {
        return Container(
          alignment: Alignment.center,
          child: Text('目前沒有任何投票!',
              style: TextStyle(fontSize: screenSize.width * 0.03)),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: screenSize.height * 0.01),
          child: ListView.separated(
              itemCount: _voteListModel.vote.length,
              itemBuilder: (BuildContext context, int index) {
                var vote = _voteListModel.vote[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.04,
                      vertical: screenSize.height * 0.008),
                  title: Text(vote.title,
                      style: TextStyle(fontSize: screenSize.width * 0.052)),
                  subtitle: Container(
                      margin: EdgeInsets.only(top: screenSize.height * 0.005),
                      child: Text("已有${vote.votersNum}人投票",
                          style: TextStyle(
                              fontSize: screenSize.width * 0.032,
                              color: Color(0xff959595)))),
                  trailing: _buildVoteState(vote.isVoteType, vote.voteNum),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            VotePage(vote.voteNum, groupNum)));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                );
              }),
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _voteResult(index) {
    var vote = _voteEndListModel.vote[index];
    var screenSize = MediaQuery.of(context).size;
    List<Widget> voteResult = [];
    for (int i = 0; i < vote.result.length; i++) {
      voteResult.add(Text(vote.result[i].resultContent,
          style: TextStyle(
              fontSize: screenSize.width * 0.035, color: Color(0xff959595))));
    }
    return Container(
      margin: EdgeInsets.only(top: screenSize.height * 0.005),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("最高票：",
              style: TextStyle(
                  fontSize: screenSize.width * 0.035,
                  color: Color(0xff959595))),
          Container(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: voteResult,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoteEndList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_voteEndListModel != null) {
      if (_voteEndListModel.vote.length == 0) {
        return Container(
          alignment: Alignment.center,
          child: Text('目前沒有任何投票!',
              style: TextStyle(fontSize: screenSize.width * 0.03)),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: screenSize.height * 0.01),
          child: ListView.separated(
              itemCount: _voteEndListModel.vote.length,
              itemBuilder: (BuildContext context, int index) {
                var vote = _voteEndListModel.vote[index];
                return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.04,
                        vertical: screenSize.height * 0.008),
                    title: Text(vote.title,
                        style: TextStyle(fontSize: screenSize.width * 0.052)),
                    subtitle: _voteResult(index));
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                );
              }),
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
