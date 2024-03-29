import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';

import 'package:My_Day_app/public/vote_request/delete.dart';
import 'package:My_Day_app/models/vote/get_vote_model.dart';
import 'package:My_Day_app/models/group/group_member_list_model.dart';
import 'package:My_Day_app/public/group_request/member_list.dart';
import 'package:My_Day_app/public/vote_request/get.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class VoteEndDetailPage extends StatefulWidget {
  int voteNum;
  int groupNum;
  VoteEndDetailPage(this.voteNum, this.groupNum);

  @override
  _VoteEndDetailPage createState() => new _VoteEndDetailPage(voteNum, groupNum);
}

class _VoteEndDetailPage extends State<VoteEndDetailPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getVoteRequest();
    await _getGroupMemberRequest();
  }

  int voteNum;
  int groupNum;
  _VoteEndDetailPage(this.voteNum, this.groupNum);

  GetVoteModel _getVoteModel;
  GroupMemberListModel _groupMemberListModel;

  String _deadLine = '';

  bool _visibleDeadLine = false;
  bool _visibleAnonymous = false;
  bool _isCreate = false;
  bool _isManager = false;

  List _voteItemCount = [];
  List _managerList = [];

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _getVoteRequest() async {
    GetVoteModel _request =
        await Get(context: context, uid: uid, voteNum: voteNum).getData();

    setState(() {
      _getVoteModel = _request;
      _voteItemCount = [];
      if (_getVoteModel.deadline != "None") {
        DateTime dateTime = DateTime.parse(_getVoteModel.deadline);
        _deadLine = formatDate(
            DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
                dateTime.minute),
            [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
        _visibleDeadLine = true;
      }
      if (_getVoteModel.anonymous == true) {
        _visibleAnonymous = true;
      }
      for (int i = 0; i < _getVoteModel.voteItems.length; i++) {
        _voteItemCount.add(_getVoteModel.voteItems[i].voteItemCount);
      }
      if (_getVoteModel.founderId == uid && _getVoteModel.voteCount == 0) {
        _isCreate = true;
      }
      for (int i = 0; i < _managerList.length; i++) {
        if (_managerList[i] == uid) {
          _isManager = true;
        }
      }
    });
  }

  _getGroupMemberRequest() async {
    GroupMemberListModel _request =
        await MemberList(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _groupMemberListModel = _request;

      for (int i = 0; i < _groupMemberListModel.member.length; i++) {
        if (_groupMemberListModel.member[i].statusId == 4) {
          _managerList.add(_groupMemberListModel.member[i].memberId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _leadingL = _sizing.height(2);
    double _listPaddingH = _sizing.height(4);
    double _listPaddingV = _sizing.height(2);
    double _itemsSize = _sizing.height(4.5);

    double _appBarSize = _sizing.width(5.2);
    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);

    Color _gray = Color(0xff959595);
    Color _color = Theme.of(context).primaryColor;

    _submitDelete() async {
      var submitWidget;
      _submitWidgetfunc() async {
        return Delete(uid: uid, voteNum: voteNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    _voteAction() {
      if (_isCreate || _isManager) {
        return PopupMenuButton<String>(
            offset: Offset(50, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_sizing.height(1))),
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
                  PopupMenuItem<String>(
                      value: 'delete',
                      height: _itemsSize,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text("刪除",
                              style: TextStyle(fontSize: _subtitleSize)))),
                ],
            onSelected: (item) async {
              switch (item) {
                case 'delete':
                  if (await _submitDelete() != true) {
                    Navigator.pop(context);
                  }
                  break;
              }
            });
      } else {
        return Container();
      }
    }

    if (_getVoteModel != null && _groupMemberListModel != null) {
      Widget voteSetting = Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: _sizing.height(4)),
            child: Text(_getVoteModel.title,
                style: TextStyle(fontSize: _appBarSize)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: _sizing.height(1)),
                child: Text("建立人：" + _getVoteModel.founderName,
                    style: TextStyle(fontSize: _subtitleSize, color: _gray)),
              ),
              Visibility(
                visible: _visibleAnonymous,
                child: Container(
                  margin: EdgeInsets.only(
                      top: _sizing.height(1), left: _sizing.height(5)),
                  child: Text("匿名投票",
                      style: TextStyle(fontSize: _subtitleSize, color: _gray)),
                ),
              ),
            ],
          ),
          Visibility(
            visible: _visibleDeadLine,
            child: Container(
              margin: EdgeInsets.only(top: _sizing.height(1)),
              child: Text("截止日期：" + _deadLine,
                  style: TextStyle(fontSize: _subtitleSize, color: _gray)),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: _sizing.height(4)),
              child: Divider(
                height: 1,
              ))
        ],
      );

      Widget voteItem = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _getVoteModel.voteItems.length,
        itemBuilder: (BuildContext context, int index) {
          var vote = _getVoteModel.voteItems[index];
          String voteItemName;
          if (_getVoteModel.optionTypeId == 1) {
            voteItemName = vote.voteItemName;
          } else {
            DateTime voteDate = DateTime.parse(vote.voteItemName);
            voteItemName = formatDate(
                DateTime(voteDate.year, voteDate.month, voteDate.day,
                    voteDate.hour, voteDate.minute),
                [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
          }
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: _listPaddingH, vertical: _listPaddingV),
            title: Text(voteItemName, style: TextStyle(fontSize: _titleSize)),
            trailing: Text(_voteItemCount[index].toString(),
                style: TextStyle(fontSize: _titleSize)),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
          );
        },
      );

      Widget voteWidget = Column(
        children: [
          voteSetting,
          Expanded(
            child: ListView(
              children: [
                voteItem,
                Divider(height: 1),
              ],
            ),
          )
        ],
      );

      return Container(
          color: _color,
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: _color,
                title: Text('投票', style: TextStyle(fontSize: _appBarSize)),
                actions: [_voteAction()],
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
              body: Container(
                  color: Colors.white,
                  child: SafeArea(top: false, child: voteWidget)),
            ),
          ));
    } else {
      return Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
