import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';

import 'package:My_Day_app/public/vote_request/add_items.dart';
import 'package:My_Day_app/public/vote_request/delete.dart';
import 'package:My_Day_app/public/vote_request/vote.dart';
import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/vote/vote_edit_page.dart';
import 'package:My_Day_app/models/vote/get_vote_model.dart';
import 'package:My_Day_app/models/group/group_member_list_model.dart';
import 'package:My_Day_app/public/group_request/member_list.dart';
import 'package:My_Day_app/public/vote_request/get.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class VotePage extends StatefulWidget {
  int voteNum;
  int groupNum;
  VotePage(this.voteNum, this.groupNum);

  @override
  _VoteWidget createState() => new _VoteWidget(voteNum, groupNum);
}

class _VoteWidget extends State<VotePage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getVoteRequest();
    await _getGroupMemberRequest();
  }

  int voteNum;
  int groupNum;
  _VoteWidget(this.voteNum, this.groupNum);

  GetVoteModel _getVoteModel;
  GroupMemberListModel _groupMemberListModel;

  String _voteItemName = '';
  String _deadLine = '';
  String _title = '';

  bool _visibleDeadLine = false;
  bool _visibleAnonymous = false;
  bool _isCreate = false;
  bool _isManager = false;

  List _voteItemCount = [];
  List _voteCheck = [];
  List _voteAddItemCheck = [];
  List _managerList = [];

  DateTime _dateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0);

  final _voteItemNameController = TextEditingController();

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
      _voteCheck = [];
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
        _voteCheck.add(_getVoteModel.voteItems[i].isVote);
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
      if (_getVoteModel.optionTypeId == 1)
        _title = '新增選項';
      else
        _title = '新增日期';
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
    double _bottomHeight = _sizing.height(7);
    double _bottomIconWidth = _sizing.width(5);
    double _textFied = _sizing.height(4.5);
    double _borderRadius = _sizing.height(3);
    double _textLBR = _sizing.height(2);
    double _inkwellH = _sizing.height(6);
    double _itemsSize = _sizing.height(4.5);

    double _appBarSize = _sizing.width(5.2);
    double _pSize = _sizing.height(2.3);
    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);

    Color _gray = Color(0xff959595);
    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _hintGray = Color(0xffCCCCCC);
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    _submitDelete() async {
      var submitWidget;
      _submitWidgetfunc() async {
        return Delete(context: context, uid: uid, voteNum: voteNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    _submitAddItems(String itemName) async {
      int index = _getVoteModel.voteItems.length + 1;
      List<Map<String, dynamic>> voteItems = [];
      voteItems.add({'voteItemNum': index, 'voteItemName': itemName});

      var submitWidget;
      _submitWidgetfunc() async {
        return AddItems(
            context: context, uid: uid, voteNum: voteNum, voteItems: voteItems);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    _submitVote() async {
      List<int> voteItemNum = [];
      for (int i = 0; i < _voteCheck.length; i++) {
        if (_voteCheck[i] == true) voteItemNum.add(i + 1);
      }
      print(voteItemNum);
      var submitWidget;
      _submitWidgetfunc() async {
        return Vote(
            context: context,
            uid: uid,
            voteNum: voteNum,
            voteItemNum: voteItemNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    _selectedItem(BuildContext context, item) async {
      switch (item) {
        case 0:
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => VoteEditPage(voteNum)))
              .then((value) {
            _getVoteRequest();
            _getGroupMemberRequest();
          });
          break;
        case 1:
          if (await _submitDelete() != true) {
            Navigator.pop(context);
          }
          break;
      }
    }

    _voteAction() {
      if (_isCreate) {
        return PopupMenuButton<int>(
          offset: Offset(50, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_sizing.height(1))),
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
                value: 0,
                height: _itemsSize,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("編輯", style: TextStyle(fontSize: _subtitleSize)))),
            PopupMenuDivider(
              height: 1,
            ),
            PopupMenuItem<int>(
                value: 1,
                height: _itemsSize,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("刪除", style: TextStyle(fontSize: _subtitleSize)))),
          ],
          onSelected: (item) => _selectedItem(context, item),
        );
      } else if (_isManager) {
        return PopupMenuButton<int>(
          offset: Offset(50, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_sizing.height(1))),
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
                value: 1,
                height: _itemsSize,
                child: Container(
                    alignment: Alignment.center,
                    child:
                        Text("刪除", style: TextStyle(fontSize: _subtitleSize)))),
          ],
          onSelected: (item) => _selectedItem(context, item),
        );
      } else {
        return Container();
      }
    }

    _voteCount() {
      int _voteCount = 0;
      for (int i = 0; i < _voteCheck.length; i++) {
        if (_voteCheck[i] == true) {
          _voteCount++;
        }
      }
      for (int i = 0; i < _voteAddItemCheck.length; i++) {
        if (_voteAddItemCheck[i] == true) {
          _voteCount++;
        }
      }
      return _voteCount;
    }

    _datePicker(contex) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _sizing.height(40),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                      child: Text('確定', style: TextStyle(color: _color)),
                      onPressed: () async {
                        if (await _submitAddItems(_voteItemName) != true) {
                          _getVoteRequest();
                          Navigator.pop(context);
                        }
                      }),
                ),
              ),
              Container(
                height: _sizing.height(28),
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: _dateTime,
                    onDateTimeChanged: (value) async {
                      setState(() {
                        _dateTime = value;
                        _voteItemName = _dateTime.toString();
                        print(_voteItemName);
                      });
                    }),
              ),
            ],
          ),
        ),
      );
    }

    Future voteAddItemDialog(BuildContext context) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
            contentPadding: EdgeInsets.only(top: _sizing.height(2)),
            content: Container(
              width: _sizing.width(20),
              height: _sizing.height(20),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Text(
                          "新增選項",
                          style: TextStyle(fontSize: _pSize),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: _textFied,
                      margin: EdgeInsets.only(
                        left: _textLBR,
                        right: _textLBR,
                        bottom: _sizing.height(3),
                      ),
                      child: new TextField(
                        style: TextStyle(fontSize: _pSize),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: _sizing.height(1),
                                vertical: _sizing.height(1)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_sizing.height(1))),
                              borderSide: BorderSide(
                                color: _textFiedBorder,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_sizing.height(1))),
                              borderSide: BorderSide(color: _bule),
                            )),
                        controller: _voteItemNameController
                          ..text = _voteItemName,
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: _inkwellH,
                            padding: EdgeInsets.only(
                                top: _sizing.height(1.5),
                                bottom: _sizing.height(1.5)),
                            decoration: BoxDecoration(
                              color: _light,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(_borderRadius),
                              ),
                            ),
                            child: Text(
                              "取消",
                              style: TextStyle(
                                  fontSize: _subtitleSize, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: _inkwellH,
                            padding: EdgeInsets.only(
                                top: _sizing.height(1.5),
                                bottom: _sizing.height(1.5)),
                            decoration: BoxDecoration(
                              color: _color,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(_borderRadius)),
                            ),
                            child: Text(
                              "確認",
                              style: TextStyle(
                                  fontSize: _subtitleSize, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () async {
                            if (_voteItemNameController.text.isNotEmpty) {
                              setState(() {
                                _voteItemName = _voteItemNameController.text;
                              });
                              print(_voteItemName);
                              if (await _submitAddItems(_voteItemName) !=
                                  true) {
                                _getVoteRequest();
                                Navigator.pop(context);
                                _voteItemName = '';
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
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
            leading: CustomerCheckBox(
              value: _voteCheck[index],
              onTap: (value) {
                setState(() {
                  if (value == true) {
                    if (_voteCount() < _getVoteModel.chooseVoteQuantity) {
                      _voteItemCount[index]++;
                      _voteCheck[index] = value;
                    }
                  } else {
                    _voteCheck[index] = value;
                    _voteItemCount[index]--;
                  }
                });
              },
            ),
            title: Text(voteItemName, style: TextStyle(fontSize: _titleSize)),
            trailing: Text(_voteItemCount[index].toString(),
                style: TextStyle(fontSize: _titleSize)),
            onTap: () {
              setState(() {
                if (_voteCheck[index] == false) {
                  if (_voteCount() < _getVoteModel.chooseVoteQuantity) {
                    _voteItemCount[index]++;
                    _voteCheck[index] = true;
                  }
                } else {
                  _voteItemCount[index]--;
                  _voteCheck[index] = false;
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
          );
        },
      );

      Widget addItem = ListTile(
        contentPadding: EdgeInsets.symmetric(
            horizontal: _listPaddingH, vertical: _listPaddingV),
        leading: Icon(Icons.add, color: _hintGray),
        title: Text(_title,
            style: TextStyle(fontSize: _titleSize, color: _hintGray)),
        onTap: () {
          if (_getVoteModel.optionTypeId == 2) {
            _datePicker(context);
          } else {
            voteAddItemDialog(context);
          }
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
                if (_getVoteModel.addItemPermit == true) addItem
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
              body: Container(color: Colors.white, child: voteWidget),
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
                              if (await _submitVote() != true) {
                                _getVoteRequest();
                                Navigator.pop(context);
                              }
                            }),
                      )),
                    ]),
                  ),
                ),
              ),
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
