import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/public/vote_request/get_list.dart';
import 'package:My_Day_app/public/vote_request/get_end_list.dart';
import 'package:My_Day_app/models/vote/vote_end_list_model.dart';
import 'package:My_Day_app/models/vote/vote_list_model.dart';
import 'package:My_Day_app/vote/vote_create_page.dart';
import 'package:My_Day_app/vote/vote_page.dart';

class VoteListPage extends StatefulWidget {
  int groupNum;
  VoteListPage(this.groupNum);

  @override
  _VoteListWidget createState() => new _VoteListWidget(groupNum);
}

class _VoteListWidget extends State<VoteListPage> with RouteAware {
  int groupNum;
  _VoteListWidget(this.groupNum);

  VoteListModel _voteListModel;
  VoteEndListModel _voteEndListModel;

  String uid = 'lili123';

  Widget voteList;
  Widget voteEndList;
  Widget noVote = Center(child: Text('目前沒有任何投票喔！'));

  @override
  void initState() {
    super.initState();
    _voteListRequest();
    _voteEndListRequest();
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
    _voteListRequest();
    _voteEndListRequest();
  }

  _voteListRequest() async {
    // var response = await rootBundle.loadString('assets/json/vote_list.json');
    // var responseBody = json.decode(response);

    VoteListModel _request =
        await GetList(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _voteListModel = _request;
    });
  }

  _voteEndListRequest() async {
    // var response = await rootBundle.loadString('assets/json/vote_end_list.json');
    // var responseBody = json.decode(response);

    VoteEndListModel _request =
        await GetEndList(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _voteEndListModel = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _leadingL = _height * 0.02;
    double _tab = _height * 0.04683;

    double _appBarSize = _width * 0.052;
    double _pSize = _height * 0.023;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;

    Color _yellow = Color(0xffEFB208);
    Color _color = Theme.of(context).primaryColor;
    Color _lightGray = Color(0xffE3E3E3);
    Color _gray = Color(0xff959595);

    _voteState(bool isVoteType, int voteNum) {
      if (isVoteType == false) {
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

    _voteResult(index) {
      var vote = _voteEndListModel.vote[index];
      List<Widget> voteResult = [];
      for (int i = 0; i < vote.result.length; i++) {
        voteResult.add(Text(vote.result[i].resultContent,
            style: TextStyle(fontSize: _subtitleSize, color: _gray)));
      }
      return Container(
        margin: EdgeInsets.only(top: _height * 0.005),
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
          margin: EdgeInsets.only(top: _height * 0.01),
          child: ListView.separated(
              itemCount: _voteListModel.vote.length,
              itemBuilder: (BuildContext context, int index) {
                var vote = _voteListModel.vote[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: _height * 0.04, vertical: _height * 0.008),
                  title:
                      Text(vote.title, style: TextStyle(fontSize: _titleSize)),
                  subtitle: Container(
                      margin: EdgeInsets.only(top: _height * 0.005),
                      child: Text("已有${vote.votersNum}人投票",
                          style: TextStyle(
                              fontSize: _subtitleSize, color: _gray))),
                  trailing: _voteState(vote.isVoteType, vote.voteNum),
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
      voteList = Center(child: CircularProgressIndicator());
    }

    if (_voteEndListModel != null) {
      if (_voteEndListModel.vote.length == 0) {
        voteEndList = noVote;
      } else {
        voteEndList = Container(
          margin: EdgeInsets.only(top: _height * 0.01),
          child: ListView.separated(
              itemCount: _voteEndListModel.vote.length,
              itemBuilder: (BuildContext context, int index) {
                var vote = _voteEndListModel.vote[index];
                return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: _height * 0.04, vertical: _height * 0.008),
                    title: Text(vote.title,
                        style: TextStyle(fontSize: _titleSize)),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VoteCreatePage(groupNum)));
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
                indicatorWeight: _width * 0.01,
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
