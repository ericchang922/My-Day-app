import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/models/get_vote_model.dart';
import 'package:My_Day_app/models/group_member_list_model.dart';
import 'package:My_Day_app/vote/vote_edit_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_pickers/pickers.dart';
// import 'package:flutter_pickers/style/picker_style.dart';
// import 'package:flutter_pickers/time_picker/model/date_mode.dart';
// import 'package:flutter_pickers/time_picker/model/pduration.dart';
// import 'package:flutter_pickers/time_picker/model/suffix.dart';

class VotePage extends StatefulWidget {
  int voteNum;
  int groupNum;
  VotePage(this.voteNum, this.groupNum);

  @override
  _VoteWidget createState() => new _VoteWidget(voteNum, groupNum);
}

class _VoteWidget extends State<VotePage> {
  int voteNum;
  int groupNum;
  _VoteWidget(this.voteNum, this.groupNum);

  GetVoteModel _getVoteModel = null;
  GroupMemberListModel _groupMemberListModel = null;

  String _voteItemName = "";
  String uid = 'lili123';
  String _deadLine = "";

  bool _visibleDeadLine = false;
  bool _visibleAnonymous = false;
  bool _isCreate = false;
  bool _isManager = false;

  List _voteItemCount = [];
  List _voteCheck = [];
  List _voteAddItemCount = [];
  List _voteAddItemName = [];
  List _voteAddItemCheck = [];
  List _managerList = [];

  DateTime _dateTime = DateTime.now();

  bool _isEnabled = true;

  final _voteItemNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    

    _getGroupMemberRequest();
    _getVoteRequest();
  }

  Future<void> _getVoteRequest() async {
    // var jsonString = await rootBundle.loadString('assets/json/get_vote.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
        '/vote/get/', {'uid': uid, 'voteNum': voteNum.toString()}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(jsonString);

    var jsonMap = json.decode(jsonString);

    var getVoteModel = GetVoteModel.fromJson(jsonMap);
    setState(() {
      _getVoteModel = getVoteModel;
      _voteCheck = new List();
      _voteItemCount = new List();
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
        setState(() {
          _isCreate = true;
        });
      }
      for (int i = 0; i < _managerList.length; i++) {
        if (_managerList[i] == uid) {
          setState(() {
            _isManager = true;
          });
        }
      }
      print(_voteCheck);
      _buttonIsOnpressed();
    });
  }

  Future _getGroupMemberRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/group_members.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
        '/group/member_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var groupMemberListModel = GroupMemberListModel.fromJson(jsonBody);
    setState(() {
      _groupMemberListModel = groupMemberListModel;

      for (int i = 0; i < _groupMemberListModel.member.length; i++) {
        if (_groupMemberListModel.member[i].statusId == 4) {
          _managerList.add(_groupMemberListModel.member[i].memberId);
        }
      }
    });
  }

  _buttonIsOnpressed() {
    int count = 0;
    for (int i = 0; i < _voteCheck.length; i++) {
      if (_voteCheck[i] == true) {
        count++;
      }
    }
    if (count == 0) {
      setState(() {
        _isEnabled = false;
      });
    } else {
      setState(() {
        _isEnabled = true;
      });
    }
  }

  selectedItem(BuildContext context, item) async {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => VoteEditPage(voteNum)));
        break;
      case 1:
        break;
    }
  }

  voteAction() {
    var screenSize = MediaQuery.of(context).size;
    if (_isCreate && _isManager) {
      return PopupMenuButton<int>(
        offset: Offset(50, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenSize.height * 0.01)),
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
              value: 0,
              child: Container(
                  alignment: Alignment.center,
                  child: Text("編輯",
                      style: TextStyle(fontSize: screenSize.width * 0.035)))),
          PopupMenuDivider(
            height: 1,
          ),
          PopupMenuItem<int>(
              value: 1,
              child: Container(
                  alignment: Alignment.center,
                  child: Text("刪除",
                      style: TextStyle(fontSize: screenSize.width * 0.035)))),
        ],
        onSelected: (item) => selectedItem(context, item),
      );
    } else if (_isCreate) {
      return PopupMenuButton<int>(
        offset: Offset(50, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenSize.height * 0.01)),
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
              value: 0,
              child: Container(
                  alignment: Alignment.center,
                  child: Text("編輯",
                      style: TextStyle(fontSize: screenSize.width * 0.035)))),
        ],
        onSelected: (item) => selectedItem(context, item),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('投票', style: TextStyle(fontSize: screenSize.width * 0.052)),
        actions: [voteAction()],
        leading: Container(
          margin: EdgeInsets.only(left: screenSize.height * 0.02),
          child: GestureDetector(
            child: Icon(Icons.chevron_left),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Container(color: Colors.white, child: _buildVoteWidget(context)),
    );
  }

  Widget _buildVoteWidget(BuildContext context) {
    if (_getVoteModel != null && _groupMemberListModel != null) {
      return Column(
        children: [
          _buildVoteSetting(context),
          Expanded(
            child: ListView(
              children: [
                _buildVoteItem(context),
                Divider(height: 1),
                // _buildVoteAddItem(context),
                // if (_voteAddItemName.length != 0) Divider(height: 1),
                _buildAddItem(context)
              ],
            ),
          ),
          _buildCheckButtom(context)
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildVoteSetting(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: screenSize.height * 0.04),
          child: Text(_getVoteModel.title,
              style: TextStyle(fontSize: screenSize.width * 0.052)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: screenSize.height * 0.01),
              child: Text("建立人：" + _getVoteModel.founderName,
                  style: TextStyle(
                      fontSize: screenSize.width * 0.035,
                      color: Color(0xff959595))),
            ),
            Visibility(
              visible: _visibleAnonymous,
              child: Container(
                margin: EdgeInsets.only(
                    top: screenSize.height * 0.01,
                    left: screenSize.height * 0.05),
                child: Text("匿名投票",
                    style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        color: Color(0xff959595))),
              ),
            ),
          ],
        ),
        Visibility(
          visible: _visibleDeadLine,
          child: Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.01),
            child: Text("截止日期：" + _deadLine,
                style: TextStyle(
                    fontSize: screenSize.width * 0.035,
                    color: Color(0xff959595))),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.04),
            child: Divider(
              height: 1,
            ))
      ],
    );
  }

  int _voteCount() {
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

  Widget _buildVoteItem(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ListView.separated(
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
              horizontal: screenSize.height * 0.04,
              vertical: screenSize.height * 0.02),
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
                _buttonIsOnpressed();
              });
            },
          ),
          title: Text(voteItemName,
              style: TextStyle(fontSize: screenSize.width * 0.041)),
          trailing: Text(_voteItemCount[index].toString(),
              style: TextStyle(fontSize: screenSize.width * 0.041)),
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
              _buttonIsOnpressed();
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
  }

  Widget _buildVoteAddItem(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _voteAddItemName.length,
      itemBuilder: (BuildContext context, int index) {
        var voteAddItemName = _voteAddItemName[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.height * 0.04,
              vertical: screenSize.height * 0.02),
          title: Text(voteAddItemName,
              style: TextStyle(fontSize: screenSize.width * 0.041)),
          leading: CustomerCheckBox(
            value: _voteAddItemCheck[index],
            onTap: (value) {
              setState(() {
                if (value == true) {
                  if (_voteCount() < _getVoteModel.chooseVoteQuantity) {
                    _voteAddItemCount[index]++;
                    _voteAddItemCheck[index] = value;
                  }
                } else {
                  _voteAddItemCheck[index] = value;
                  _voteAddItemCount[index]--;
                }
                _buttonIsOnpressed();
              });
            },
          ),
          trailing: Text(_voteAddItemCount[index].toString(),
              style: TextStyle(fontSize: screenSize.width * 0.041)),
          onTap: () {
            setState(() {
              if (_voteAddItemCheck[index] == false) {
                if (_voteCount() < _getVoteModel.chooseVoteQuantity) {
                  _voteAddItemCount[index]++;
                  _voteAddItemCheck[index] = true;
                }
              } else {
                _voteAddItemCount[index]--;
                _voteAddItemCheck[index] = false;
              }
              _buttonIsOnpressed();
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
  }

  Widget _buildAddItem(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    String title;
    if (_getVoteModel.optionTypeId == 1) {
      title = '新增選項';
    } else {
      title = '新增日期';
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
          horizontal: screenSize.height * 0.04,
          vertical: screenSize.height * 0.02),
      leading: Icon(Icons.add, color: Color(0xffCCCCCC)),
      title: Text(title,
          style: TextStyle(
              fontSize: screenSize.width * 0.041, color: Color(0xffCCCCCC))),
      onTap: () {
        if (_getVoteModel.optionTypeId == 2) {
          _datePicker(context);
        } else {
          _voteAddItemDialog(context);
        }
      },
    );
  }

  String _dateFormat(dateTime) {
    String dateString = formatDate(
        DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
            dateTime.minute),
        [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
    return dateString;
  }

  void _datePicker(contex) {
    var screenSize = MediaQuery.of(context).size;
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: screenSize.height * 0.35,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.065,
              child: Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                    child: Text('確定'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        // _voteItemName = _dateFormat(_dateTime);
                        // _voteAddItemName.add(_voteItemName);
                        // _voteItemName = "";
                        // _voteAddItemCheck.add(false);
                        // _voteAddItemCount.add(0);
                        print(_dateTime);
                        _getVoteRequest();
                      });
                    }),
              ),
            ),
            Container(
              height: screenSize.height * 0.28,
              child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (value) {
                    setState(() {
                      _dateTime = value;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckButtom(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var _onPressed;

    if (_isEnabled == true) {
      _onPressed = () {
        // Navigator.pop(context);
        setState(() {});
      };
    }

    return Row(children: <Widget>[
      Expanded(
        // ignore: deprecated_member_use
        child: FlatButton(
          height: screenSize.height * 0.07,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Image.asset(
            'assets/images/cancel.png',
            width: screenSize.width * 0.05,
          ),
          color: Theme.of(context).primaryColorLight,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      Expanded(
          // ignore: deprecated_member_use
          child: Builder(builder: (context) {
        return FlatButton(
            disabledColor: Color(0xffCCCCCC),
            height: screenSize.height * 0.07,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Image.asset(
              'assets/images/confirm.png',
              width: screenSize.width * 0.05,
            ),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: _onPressed);
      }))
    ]);
  }

  Future _voteAddItemDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(screenSize.height * 0.03))),
          contentPadding: EdgeInsets.only(top: screenSize.height * 0.02),
          content: Container(
            width: screenSize.width * 0.2,
            height: screenSize.height * 0.2077,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Text(
                        "新增選項",
                        style: TextStyle(fontSize: screenSize.width * 0.041),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                    height: screenSize.height * 0.04683,
                    margin: EdgeInsets.only(
                      top: screenSize.height * 0.03,
                      left: screenSize.height * 0.02,
                      right: screenSize.height * 0.02,
                      bottom: screenSize.height * 0.038,
                    ),
                    child: new TextField(
                      style: TextStyle(fontSize: screenSize.width * 0.041),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenSize.height * 0.01,
                              vertical: screenSize.height * 0.01),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenSize.height * 0.01)),
                            borderSide: BorderSide(
                              color: Color(0xff070707),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenSize.height * 0.01)),
                            borderSide: BorderSide(color: Color(0xff7AAAD8)),
                          )),
                      controller: _voteItemNameController..text = _voteItemName,
                    )),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: screenSize.height * 0.06,
                          padding: EdgeInsets.only(
                              top: screenSize.height * 0.015,
                              bottom: screenSize.height * 0.015),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(screenSize.height * 0.03),
                            ),
                          ),
                          child: Text(
                            "取消",
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.white),
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
                              height: screenSize.height * 0.06,
                              padding: EdgeInsets.only(
                                  top: screenSize.height * 0.015,
                                  bottom: screenSize.height * 0.015),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(
                                        screenSize.height * 0.03)),
                              ),
                              child: Text(
                                "確認",
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.035,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (_voteItemNameController.text.isNotEmpty) {
                                  // _voteItemName = _voteItemNameController.text;
                                  // _voteAddItemName.add(_voteItemName);
                                  // _voteItemName = "";
                                  // _voteAddItemCheck.add(false);
                                  // _voteAddItemCount.add(0);
                                  print(_voteItemNameController.text);
                                }
                              });
                    
                              Navigator.of(context).pop();
                            }))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
