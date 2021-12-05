import 'package:flutter/material.dart';

import 'package:My_Day_app/vote/vote_end_detail_page.dart';
import 'package:My_Day_app/public/vote_request/get_list.dart';
import 'package:My_Day_app/public/vote_request/get_end_list.dart';
import 'package:My_Day_app/models/vote/vote_end_list_model.dart';
import 'package:My_Day_app/models/vote/vote_list_model.dart';
import 'package:My_Day_app/vote/vote_create_page.dart';
import 'package:My_Day_app/vote/vote_page.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class VoteListPage extends StatefulWidget {
  int groupNum;
  VoteListPage(this.groupNum);

  @override
  _VoteListWidget createState() => new _VoteListWidget(groupNum);
}

class _VoteListWidget extends State<VoteListPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _voteListRequest();
    await _voteEndListRequest();
  }

  int groupNum;
  _VoteListWidget(this.groupNum);

  VoteListModel _voteListModel;
  VoteEndListModel _voteEndListModel;

  Widget voteList;
  Widget voteEndList;
  Widget noVote = Center(child: Text('目前沒有任何投票喔！'));

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _voteListRequest() async {
    VoteListModel _request =
        await GetList(context: context, uid: uid, groupNum: groupNum).getData();

    setState(() {
      _voteListModel = _request;
    });
  }

  _voteEndListRequest() async {
    VoteEndListModel _request =
        await GetEndList(context: context, uid: uid, groupNum: groupNum)
            .getData();

    setState(() {
      _voteEndListModel = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _leadingL = _sizing.height(2);
    double _tab = _sizing.height(4.683);

    double _appBarSize = _sizing.width(5.2);
    double _pSize = _sizing.height(2.3);
    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);

    Color _yellow = Color(0xffEFB208);
    Color _color = Theme.of(context).primaryColor;
    Color _lightGray = Color(0xffE3E3E3);
    Color _gray = Color(0xff959595);

    _voteState(bool isVoteType, int voteNum) {
      if (isVoteType == false) {
        return Container(
          margin: EdgeInsets.only(right: _sizing.height(1)),
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

    _voteResult(index) {
      var vote = _voteEndListModel.vote[index];
      List<Widget> voteResult = [];
      for (int i = 0; i < vote.result.length; i++) {
        voteResult.add(Text(vote.result[i].resultContent,
            style: TextStyle(fontSize: _subtitleSize, color: _gray)));
      }
      return Container(
        margin: EdgeInsets.only(top: _sizing.height(0.5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("最高票：",
                style: TextStyle(fontSize: _subtitleSize, color: _gray)),
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

    if (_voteListModel != null) {
      if (_voteListModel.vote.length == 0) {
        voteList = noVote;
      } else {
        voteList = Container(
          margin: EdgeInsets.only(top: _sizing.height(1)),
          child: ListView.separated(
              itemCount: _voteListModel.vote.length,
              itemBuilder: (BuildContext context, int index) {
                var vote = _voteListModel.vote[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: _sizing.height(4),
                      vertical: _sizing.height(0.8)),
                  title:
                      Text(vote.title, style: TextStyle(fontSize: _titleSize)),
                  subtitle: Container(
                      margin: EdgeInsets.only(top: _sizing.height(0.5)),
                      child: Text("已有${vote.votersNum}人投票",
                          style: TextStyle(
                              fontSize: _subtitleSize, color: _gray))),
                  trailing: _voteState(vote.isVoteType, vote.voteNum),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) =>
                                VotePage(vote.voteNum, groupNum)))
                        .then((value) {
                      _voteListRequest();
                      _voteEndListRequest();
                    });
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
      voteList = Center(child: CircularProgressIndicator());
    }

    if (_voteEndListModel != null) {
      if (_voteEndListModel.vote.length == 0) {
        voteEndList = noVote;
      } else {
        voteEndList = Container(
          margin: EdgeInsets.only(top: _sizing.height(1)),
          child: ListView.separated(
              itemCount: _voteEndListModel.vote.length,
              itemBuilder: (BuildContext context, int index) {
                var vote = _voteEndListModel.vote[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: _sizing.height(4),
                      vertical: _sizing.height(0.8)),
                  title:
                      Text(vote.title, style: TextStyle(fontSize: _titleSize)),
                  subtitle: _voteResult(index),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) =>
                                VoteEndDetailPage(61, groupNum)))
                        .then((value) {
                      _voteListRequest();
                      _voteEndListRequest();
                    });
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
      voteEndList = Center(child: CircularProgressIndicator());
    }

    return Container(
      color: _color,
      child: SafeArea(
        bottom: false,
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title: Text('投票', style: TextStyle(fontSize: _appBarSize)),
              leading: Container(
                margin: EdgeInsets.only(left: _leadingL),
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => VoteCreatePage(groupNum)))
                          .then((value) {
                        _voteListRequest();
                        _voteEndListRequest();
                      });
                    },
                    icon: Icon(Icons.add))
              ],
              bottom: TabBar(
                indicator: ShapeDecoration(
                    shape: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: _yellow,
                            width: 0,
                            style: BorderStyle.solid)),
                    gradient: LinearGradient(colors: [_yellow, _yellow])),
                labelColor: Colors.white,
                unselectedLabelColor: _lightGray,
                indicatorPadding: EdgeInsets.all(0.0),
                indicatorWeight: _sizing.width(1),
                labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                tabs: <Widget>[
                  Container(
                    height: _tab,
                    alignment: Alignment.center,
                    color: _color,
                    child: Text("開放中", style: TextStyle(fontSize: _pSize)),
                  ),
                  Container(
                    height: _tab,
                    alignment: Alignment.center,
                    color: _color,
                    child: Text("已結束", style: TextStyle(fontSize: _pSize)),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Container(
                    color: Colors.white,
                    child: SafeArea(top: false, child: voteList)),
                Container(
                    color: Colors.white,
                    child: SafeArea(top: false, child: voteEndList)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
