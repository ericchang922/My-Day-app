import 'dart:convert';

import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/models/get_vote_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_pickers/style/picker_style.dart';

class VoteEditPage extends StatefulWidget {
  int voteNum;
  VoteEditPage(this.voteNum);

  @override
  _VoteEditWidget createState() => new _VoteEditWidget(voteNum);
}

class _VoteEditWidget extends State<VoteEditPage> {
  int voteNum;
  _VoteEditWidget(this.voteNum);

  GetVoteModel _getVoteModel = null;

  String _value = '';
  String _title = '';
  String _deadLineValue = "";

  DateTime _dateTime = DateTime.now();
  DateTime _deadLine = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0)
      .add(Duration(days: 3));

  List _voteValues = [];
  List _voteItems = [];
  List _voteItemsName = [];
  List _voteDate = [];

  TextEditingController get _voteTitleController =>
      TextEditingController(text: _title);
  TextEditingController get _voteItemController =>
      TextEditingController(text: _value);

  Map _voteSettingCheck = {1: false, 2: false, 3: false, 4: false};

  FocusNode _contentFocusNode = FocusNode();

  var chooseVoteQuantityList = <String>[
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  
  String dropdownValue = '2';

  bool _visibleDeadLine = false;
  bool _visibleChooseVoteQuantity = false;
  bool _isEnabled = true;

  @override
  void initState() {
    super.initState();
    _getVoteRequest();
  }

  String _dateFormat(dateTime) {
    String dateString = formatDate(
        DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
            dateTime.minute),
        [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
    return dateString;
  }

  Future<void> _getVoteRequest() async {
    var jsonString = await rootBundle.loadString('assets/json/get_vote.json');

    // var httpClient = HttpClient();
    // var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
    //     '/vote/get/', {'uid': uid, 'voteNum': voteNum.toString()}));
    // var response = await request.close();
    // var jsonString = await response.transform(utf8.decoder).join();
    // httpClient.close();

    var jsonMap = json.decode(jsonString);

    var getVoteModel = GetVoteModel.fromJson(jsonMap);
    setState(() {
      _getVoteModel = getVoteModel;
      for (int i = 0; i < _getVoteModel.voteItems.length; i++) {
        if (_getVoteModel.optionTypeId == 1) {
          _voteValues.add(_getVoteModel.voteItems[i].voteItemName);
        } else {
          _voteDate.add(_getVoteModel.voteItems[i].voteItemName);
          DateTime dateTime =
              DateTime.parse(_getVoteModel.voteItems[i].voteItemName);

          String dateString = formatDate(
              DateTime(dateTime.year, dateTime.month, dateTime.day,
                  dateTime.hour, dateTime.minute),
              [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
          _voteValues.add(dateString);
        }
      }
      _voteValues.add("");
      _voteDate.add("");
      _title = _getVoteModel.title;
      if (_getVoteModel.deadline != "None") {
        _visibleDeadLine = true;
        _deadLineValue = _dateFormat(_deadLine);
        _deadLine = DateTime.parse(_getVoteModel.deadline);
        _voteSettingCheck[1] = true;
      }
      if (_getVoteModel.addItemPermit == true) {
        _voteSettingCheck[2] = true;
      }
      if (_getVoteModel.anonymous == true) {
        _voteSettingCheck[3] = true;
      }
      if (_getVoteModel.chooseVoteQuantity != 1) {
        _voteSettingCheck[4] = true;
        _visibleChooseVoteQuantity = true;
        dropdownValue = _getVoteModel.chooseVoteQuantity.toString();
      }
    });
  }

  _buttonIsOnpressed() {
    int count = 0;
    for (int i = 0; i < _voteValues.length; i++) {
      if (_voteValues[i] != "") {
        count++;
      }
    }
    if (count < 2 || _voteTitleController.text.isEmpty) {
      setState(() {
        _isEnabled = false;
      });
    } else {
      setState(() {
        _isEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('編輯投票',
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
        ),
        body: Container(
            color: Colors.white, child: _buildEditVoteWidget(context)),
        bottomNavigationBar: _buildCheckButtom(context));
  }

  Widget _buildEditVoteWidget(BuildContext context) {
    if (_getVoteModel != null) {
      return ListView(
          children: [_buildEditVote(context), _buildEditVoteSetting(context)]);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildEditVote(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
          top: screenSize.height * 0.03,
          right: screenSize.height * 0.05,
          left: screenSize.height * 0.05),
      children: [
        TextField(
          controller: _voteTitleController,
          cursorColor: Colors.black,
          style: TextStyle(fontSize: screenSize.width * 0.06),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(screenSize.width * 0.02),
            hintText: '輸入投票問題',
            hintStyle: TextStyle(
                color: Color(0xffCCCCCC), fontSize: screenSize.width * 0.06),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffCCCCCC)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffCCCCCC)),
              //  when the TextFormField in focused
            ),
          ),
          onChanged: (text) {
            setState(() {
              _title = text;
              _buttonIsOnpressed();
            });
          },
        ),
        _buildVoteType(context)
      ],
    );
  }

  Widget _buildVoteType(BuildContext context) {
    if (_getVoteModel.optionTypeId == 1) {
      return _buildEditVoteItem(context);
    } else {
      return _buildEditDateVoteItem(context);
    }
  }

  Widget _buildEditVoteItem(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.builder(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _voteValues.length,
      itemBuilder: (BuildContext context, int index) {
        _value = _voteValues[index];
        return Column(
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(screenSize.height * 0.0131),
                    margin: EdgeInsets.only(top: screenSize.height * 0.032),
                    child: Text('${index + 1}.',
                        style: TextStyle(fontSize: screenSize.width * 0.05))),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: screenSize.height * 0.028),
                    child: TextField(
                      controller: _voteItemController,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: screenSize.width * 0.05),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(screenSize.width * 0.02),
                        hintText: '輸入選項',
                        hintStyle: TextStyle(
                            color: Color(0xffCCCCCC),
                            fontSize: screenSize.width * 0.05),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onChanged: (text) {
                        setState(() {
                          int count = 0;
                          _voteValues[index] = text;
                          for (int i = 0; i < _voteValues.length; i++) {
                            if (_voteValues[i] == "") {
                              count++;
                            }
                          }
                          print(count);
                          if (count == 0) {
                            _voteValues.add("");
                          }
                        });
                        _buttonIsOnpressed();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Color(0xffCCCCCC))
          ],
        );
      },
    );
  }

  Widget _buildEditDateVoteItem(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.builder(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _voteValues.length,
      itemBuilder: (BuildContext context, int index) {
        _value = _voteValues[index];
        return Column(
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(screenSize.height * 0.0131),
                    margin: EdgeInsets.only(top: screenSize.height * 0.032),
                    child: Text('${index + 1}.',
                        style: TextStyle(fontSize: screenSize.width * 0.05))),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: screenSize.height * 0.028),
                    child: TextField(
                      focusNode: _contentFocusNode,
                      controller: _voteItemController,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: screenSize.width * 0.05),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(screenSize.width * 0.02),
                        hintText: '選擇日期',
                        hintStyle: TextStyle(
                            color: Color(0xffCCCCCC),
                            fontSize: screenSize.width * 0.05),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onTap: () {
                        _contentFocusNode.unfocus();
                        _datePicker(context, index);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Color(0xffCCCCCC))
          ],
        );
      },
    );
  }

  void _datePicker(contex, index) {
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
                    child: Text('確定', style: TextStyle(color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        int count = 0;
                        _voteValues[index] = _dateFormat(_dateTime);
                        _voteDate[index] = _dateTime;
                        for (int i = 0; i < _voteValues.length; i++) {
                          if (_voteValues[i] == "") {
                            count++;
                          }
                        }
                        print(count);
                        if (count == 0) {
                          _voteValues.add("");
                          _voteDate.add("");
                        }
                      });
                      _buttonIsOnpressed();
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

  void _deadLinePicker(contex) {
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
                    child: Text('確定', style: TextStyle(color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _deadLineValue = _dateFormat(_deadLine);
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
                      _deadLine = value;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditVoteSetting(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
          top: screenSize.height * 0.02,
          right: screenSize.height * 0.06,
          left: screenSize.height * 0.04),
      children: [
        ListTile(
          leading: CustomerCheckBox(
            value: _voteSettingCheck[1],
            onTap: (value) {
              setState(() {
                if (value == true) {
                  _visibleDeadLine = true;
                } else {
                  _visibleDeadLine = false;
                }
                _voteSettingCheck[1] = value;
              });
            },
          ),
          title: Text("設定截止時間",
              style: TextStyle(fontSize: screenSize.width * 0.05)),
          onTap: () {
            setState(() {
              if (_voteSettingCheck[1] == false) {
                _voteSettingCheck[1] = true;
                _visibleDeadLine = true;
              } else {
                _voteSettingCheck[1] = false;
                _visibleDeadLine = false;
              }
            });
          },
        ),
        Visibility(
          visible: _visibleDeadLine,
          child: ListTile(
            contentPadding: EdgeInsets.only(left: screenSize.height * 0.08),
            title: Text(_deadLineValue,
                style: TextStyle(fontSize: screenSize.width * 0.05)),
            onTap: () {
              _deadLinePicker(context);
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(screenSize.height * 0.018),
          leading: CustomerCheckBox(
            value: _voteSettingCheck[2],
            onTap: (value) {
              setState(() {
                _voteSettingCheck[2] = value;
              });
            },
          ),
          title: Text("允許新增選項",
              style: TextStyle(fontSize: screenSize.width * 0.05)),
          onTap: () {
            setState(() {
              if (_voteSettingCheck[2] == false) {
                _voteSettingCheck[2] = true;
              } else {
                _voteSettingCheck[2] = false;
              }
            });
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.all(screenSize.height * 0.018),
          leading: CustomerCheckBox(
            value: _voteSettingCheck[3],
            onTap: (value) {
              setState(() {
                _voteSettingCheck[3] = value;
              });
            },
          ),
          title:
              Text("匿名投票", style: TextStyle(fontSize: screenSize.width * 0.05)),
          onTap: () {
            setState(() {
              if (_voteSettingCheck[3] == false) {
                _voteSettingCheck[3] = true;
              } else {
                _voteSettingCheck[3] = false;
              }
            });
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.all(screenSize.height * 0.018),
          leading: CustomerCheckBox(
            value: _voteSettingCheck[4],
            onTap: (value) {
              setState(() {
                if (value == true) {
                  _visibleChooseVoteQuantity = true;
                } else {
                  _visibleChooseVoteQuantity = false;
                }
                _voteSettingCheck[4] = value;
              });
            },
          ),
          title:
              Text("多票制", style: TextStyle(fontSize: screenSize.width * 0.05)),
          onTap: () {
            setState(() {
              if (_voteSettingCheck[4] == false) {
                _voteSettingCheck[4] = true;
                _visibleChooseVoteQuantity = true;
              } else {
                _voteSettingCheck[4] = false;
                _visibleChooseVoteQuantity = false;
              }
            });
          },
        ),
        Visibility(
          visible: _visibleChooseVoteQuantity,
          child: Container(
            margin: EdgeInsets.only(left: screenSize.height * 0.08, bottom: screenSize.height * 0.025),
            child: Row(
              children: [
                Text("一人最多",
                    style: TextStyle(fontSize: screenSize.width * 0.05)),
                Container(
                  margin: EdgeInsets.only(
                      left: screenSize.height * 0.01,
                      right: screenSize.height * 0.01),
                  height: screenSize.height * 0.04683,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.007, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: Color(0xff707070),
                        style: BorderStyle.solid,
                        width: screenSize.width * 0.001),
                  ),
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.expand_more,
                      color: Color(0xffcccccc),
                    ),
                    value: dropdownValue,
                    iconSize: screenSize.width * 0.05,
                    elevation: 16,
                    underline: Container(height: 0),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: chooseVoteQuantityList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: screenSize.width * 0.02),
                              child: Text(value,
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.05))));
                    }).toList(),
                  ),
                ),
                Text("票", style: TextStyle(fontSize: screenSize.width * 0.05)),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCheckButtom(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var _onPressed;

    if (_isEnabled == true) {
      _onPressed = () {
        Navigator.pop(context);
        setState(() {
          _voteItems = new List();
          _voteItemsName = new List();
          if (_getVoteModel.optionTypeId == 1) {
            for (int i = 0; i < _voteValues.length; i++) {
              if (_voteValues[i] != "") {
                _voteItemsName.add(_voteValues[i]);
              }
            }
          } else {
            for (int i = 0; i < _voteDate.length; i++) {
              if (_voteDate[i] != "") {
                _voteItemsName.add(_voteDate[i]);
              }
            }

            for (int i = 0; i < _voteItemsName.length; i++) {
              _voteItems.add(
                  {"voteItemNum": i + 1, "voteItemName": _voteItemsName[i]});
            }
            print("title：" + _voteTitleController.text);
            print("voteItems：${_voteItems}");
            if (_voteSettingCheck[1] == true) {
              print("deadLine：${_deadLine}");
            } else {
              print("deadLine：None");
            }
            print("isAddItemPermit：${_voteSettingCheck[2]}");
            print("isAnonymous：${_voteSettingCheck[3]}");
            if (_voteSettingCheck[4] == true) {
              print("chooseVoteQuantity：${int.parse(dropdownValue)}");
            } else {
              print("chooseVoteQuantity：1");
            }
          }
        });
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
}
