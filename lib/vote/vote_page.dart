import 'dart:convert';

import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/models/get_vote_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VotePage extends StatefulWidget {
  int voteNum;
  VotePage(this.voteNum);

  @override
  _VoteWidget createState() => new _VoteWidget(voteNum);
}

class _VoteWidget extends State<VotePage> {
  int voteNum;
  _VoteWidget(this.voteNum);

  GetVoteModel _getVoteModel = null;

  String _voteItemName = "";

  bool _visibleDeadLine = false;
  bool _visibleAnonymous = false;

  List _voteItemCount = [];
  List _voteCheck = [];
  List _voteAddItemCount = [];
  List _voteAddItemName = [];
  List _voteAddItemCheck = [];

  final _voteItemNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getVoteRequest();
  }

  Future<void> _getVoteRequest() async {
    var jsonString = await rootBundle.loadString('assets/json/get_vote.json');

    // var httpClient = HttpClient();
    // var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
    //     '/vote/get_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    // var response = await request.close();
    // var jsonString = await response.transform(utf8.decoder).join();
    // httpClient.close();

    var jsonMap = json.decode(jsonString);

    var getVoteModel = GetVoteModel.fromJson(jsonMap);
    setState(() {
      _getVoteModel = getVoteModel;
      if (_getVoteModel.deadline != null) {
        // _deadLine = formatDate(
        //     DateTime(
        //         _getVoteModel.deadline.year,
        //         _getVoteModel.deadline.month,
        //         _getVoteModel.deadline.day,
        //         _getVoteModel.deadline.hour,
        //         _getVoteModel.deadline.minute),
        //     [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
        _visibleDeadLine = true;
      }
      if (_getVoteModel.anonymous == true) {
        _visibleAnonymous = true;
      }
      for (int i = 0; i < _getVoteModel.voteItems.length; i++) {
        _voteCheck.add(false);
        _voteItemCount.add(0);
      }
      print(_voteCheck);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('投票', style: TextStyle(fontSize: screenSize.width * 0.052)),
      ),
      body: _buildVoteWidget(context),
    );
  }

  Widget _buildVoteWidget(BuildContext context) {
    if (_getVoteModel != null) {
      return Column(
        children: [
          _buildVoteSetting(context),
          Expanded(
            child: ListView(
              children: [
                _buildVoteItem(context),
                Divider(height: 1),
                _buildVoteAddItem(context),
                if (_voteAddItemName.length != 0) Divider(height: 1),
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
              child: Text("建立人：",
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
            child: Text("截止日期：" + _getVoteModel.deadline,
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
              });
            },
          ),
          title: Text(vote.voteItemName,
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
          title: Text(voteAddItemName, style: TextStyle(fontSize: screenSize.width * 0.041)),
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

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
          horizontal: screenSize.height * 0.04,
          vertical: screenSize.height * 0.02),
      leading: Icon(Icons.add, color: Color(0xffCCCCCC)),
      title: Text('新增選項',
          style: TextStyle(
              fontSize: screenSize.width * 0.041, color: Color(0xffCCCCCC))),
      onTap: () {
        _voteAddItemDialog(context);
      },
    );
  }

  Widget _buildCheckButtom(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
            onPressed: () {});
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "新增選項",
                      style: TextStyle(fontSize: screenSize.width * 0.041),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
                                  _voteItemName = _voteItemNameController.text;
                                  _voteAddItemName.add(_voteItemName);
                                  _voteItemName = "";
                                  _voteAddItemCheck.add(false);
                                  _voteAddItemCount.add(0);
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
