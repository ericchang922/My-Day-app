import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/vote_request/edit.dart';
import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/models/vote/get_vote_model.dart';
import 'package:My_Day_app/public/vote_request/get.dart';
import 'package:date_format/date_format.dart';

class VoteEditPage extends StatefulWidget {
  int voteNum;
  VoteEditPage(this.voteNum);

  @override
  _VoteEditWidget createState() => new _VoteEditWidget(voteNum);
}

class _VoteEditWidget extends State<VoteEditPage> {
  int voteNum;
  _VoteEditWidget(this.voteNum);

  GetVoteModel _getVoteModel;

  String uid = 'lili123';
  String _value = '';
  String _title = '';
  String _deadLineValue = '';

  DateTime _deadLine = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0)
      .add(Duration(days: 3));

  List _voteValues = [];
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
  bool _isNotCreate = false;

  @override
  void initState() {
    super.initState();
    _getVoteRequest();
  }

  _getVoteRequest() async {
    // var response = await rootBundle.loadString('assets/json/get_vote.json');
    // var responseBody = json.decode(response);

    GetVoteModel _request = await Get(uid: uid, voteNum: voteNum).getData();

    setState(() {
      _getVoteModel = _request;
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
        _deadLine = DateTime.parse(_getVoteModel.deadline);
        _deadLineValue = _dateFormat(_deadLine);
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

  String _dateFormat(dateTime) {
    String dateString = formatDate(
        DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
            dateTime.minute),
        [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
    return dateString;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _textFied = _height * 0.045;
    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;
    double _bottomIconWidth = _width * 0.05;
    double _listTilePadding = _height * 0.018;
    double _iconWidth = _width * 0.05;

    double _titleSize = _width * 0.06;
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _hintGray = Color(0xffCCCCCC);
    Color _textFiedBorder = Color(0xff707070);

    Widget voteType;

    _submit() async {
      String _alertTitle = '編輯投票失敗';
      String deadLine;
      String title = _title;
      List<Map<String, dynamic>> voteItems = [];
      List<String> voteItemsName = [];
      bool isAddItemPermit = _voteSettingCheck[2];
      bool isAnonymous = _voteSettingCheck[3];
      int chooseVoteQuantity;

      if (_voteSettingCheck[1] == true) {
        deadLine = _deadLine.toString();
      } else {
        deadLine = null;
      }
      if (_voteSettingCheck[4] == true) {
        chooseVoteQuantity = int.parse(dropdownValue);
      } else {
        chooseVoteQuantity = 1;
      }

      if (_getVoteModel.optionTypeId == 1) {
        for (int i = 0; i < _voteValues.length; i++) {
          if (_voteValues[i] != "") {
            voteItemsName.add(_voteValues[i]);
          }
        }
      } else {
        for (int i = 0; i < _voteDate.length; i++) {
          if (_voteDate[i] != "") {
            voteItemsName.add(_voteDate[i].toString());
          }
        }
      }

      for (int i = 0; i < voteItemsName.length; i++) {
        voteItems.add({"voteItemNum": i + 1, "voteItemName": voteItemsName[i]});
      }

      if (uid == null) {
        await alert(context, _alertTitle, '請先登入');
        _isNotCreate = true;
        Navigator.pop(context);
      }
      if (title == null || title == '') {
        await alert(context, _alertTitle, '請輸入投票問題');
        _isNotCreate = true;
      }
      if (voteItems.length < 2) {
        await alert(context, _alertTitle, '請至少新增兩個投票項目');
        _isNotCreate = true;
      }
      if (_isNotCreate) {
        _isNotCreate = false;
        return true;
      } else {
        var submitWidget;
        _submitWidgetfunc() async {
          return Edit(
              uid: uid,
              voteNum: voteNum,
              title: title,
              voteItems: voteItems,
              deadline: deadLine,
              isAddItemPermit: isAddItemPermit,
              isAnonymous: isAnonymous,
              chooseVoteQuantity: chooseVoteQuantity);
        }

        submitWidget = await _submitWidgetfunc();
        if (await submitWidget.getIsError())
          return true;
        else
          return false;
      }
    }

    _deadLinePicker(contex) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _height * 0.4,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                      child: Text('確定', style: TextStyle(color: _color)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _deadLineValue = _dateFormat(_deadLine);
                        });
                      }),
                ),
              ),
              Container(
                height: _height * 0.28,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: _deadLine,
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

    _datePicker(contex, index) {
      DateTime _dateTime;
      if (_voteDate[index] == "")
        _dateTime = DateTime.now();
      else
        _dateTime = DateTime.parse(_voteDate[index]);
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _height * 0.4,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                      child: Text('確定', style: TextStyle(color: _color)),
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
                      }),
                ),
              ),
              Container(
                height: _height * 0.28,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: _dateTime,
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

    if (_getVoteModel != null) {
      Widget editVoteItem = ListView.builder(
        padding: EdgeInsets.only(bottom: _height * 0.03),
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
                      padding: EdgeInsets.all(_height * 0.01),
                      margin: EdgeInsets.only(top: _height * 0.03),
                      child: Text('${index + 1}.',
                          style: TextStyle(fontSize: _appBarSize))),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: _height * 0.03),
                      child: TextField(
                        controller: _voteItemController,
                        cursorColor: Colors.black,
                        style: TextStyle(fontSize: _appBarSize),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(_width * 0.02),
                          hintText: '輸入選項',
                          hintStyle: TextStyle(
                              color: _hintGray, fontSize: _appBarSize),
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
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: _hintGray, height: 1)
            ],
          );
        },
      );

      Widget editDateVoteItem = ListView.builder(
        padding: EdgeInsets.only(bottom: _height * 0.03),
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
                      padding: EdgeInsets.all(_height * 0.01),
                      margin: EdgeInsets.only(top: _height * 0.03),
                      child: Text('${index + 1}.',
                          style: TextStyle(fontSize: _appBarSize))),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: _height * 0.03),
                      child: TextField(
                        focusNode: _contentFocusNode,
                        controller: _voteItemController,
                        cursorColor: Colors.black,
                        style: TextStyle(fontSize: _appBarSize),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(_width * 0.02),
                          hintText: '選擇日期',
                          hintStyle: TextStyle(
                              color: _hintGray, fontSize: _appBarSize),
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
              Divider(color: _hintGray, height: 1)
            ],
          );
        },
      );

      if (_getVoteModel.optionTypeId == 1) {
        voteType = editVoteItem;
      } else {
        voteType = editDateVoteItem;
      }
      Widget editVote = ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            top: _height * 0.03, right: _height * 0.05, left: _height * 0.05),
        children: [
          TextField(
            controller: _voteTitleController,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: _titleSize),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(_width * 0.02),
              hintText: '輸入投票問題',
              hintStyle: TextStyle(color: _hintGray, fontSize: _titleSize),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _hintGray),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _hintGray),
                //  when the TextFormField in focused
              ),
            ),
            onChanged: (text) {
              setState(() {
                _title = text;
              });
            },
          ),
          voteType
        ],
      );

      Widget editVoteSetting = ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            top: _height * 0.02, right: _height * 0.06, left: _height * 0.06),
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
            title: Text("設定截止時間", style: TextStyle(fontSize: _appBarSize)),
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
              contentPadding: EdgeInsets.only(left: _height * 0.08),
              title:
                  Text(_deadLineValue, style: TextStyle(fontSize: _appBarSize)),
              onTap: () {
                _deadLinePicker(context);
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(_listTilePadding),
            leading: CustomerCheckBox(
              value: _voteSettingCheck[2],
              onTap: (value) {
                setState(() {
                  _voteSettingCheck[2] = value;
                });
              },
            ),
            title: Text("允許新增選項", style: TextStyle(fontSize: _appBarSize)),
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
            contentPadding: EdgeInsets.all(_listTilePadding),
            leading: CustomerCheckBox(
              value: _voteSettingCheck[3],
              onTap: (value) {
                setState(() {
                  _voteSettingCheck[3] = value;
                });
              },
            ),
            title: Text("匿名投票", style: TextStyle(fontSize: _appBarSize)),
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
            contentPadding: EdgeInsets.all(_listTilePadding),
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
            title: Text("多票制", style: TextStyle(fontSize: _appBarSize)),
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
              margin: EdgeInsets.only(
                  left: _height * 0.08, bottom: _height * 0.025),
              child: Row(
                children: [
                  Text("一人最多", style: TextStyle(fontSize: _appBarSize)),
                  Container(
                    margin: EdgeInsets.only(
                        left: _height * 0.01, right: _height * 0.01),
                    height: _textFied,
                    padding: EdgeInsets.symmetric(
                        horizontal: _height * 0.007, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: _textFiedBorder,
                          style: BorderStyle.solid,
                          width: _width * 0.001),
                    ),
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.expand_more,
                        color: Color(0xffcccccc),
                      ),
                      value: dropdownValue,
                      iconSize: _iconWidth,
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
                                margin: EdgeInsets.only(left: _width * 0.02),
                                child: Text(value,
                                    style: TextStyle(fontSize: _appBarSize))));
                      }).toList(),
                    ),
                  ),
                  Text("票", style: TextStyle(fontSize: _appBarSize)),
                ],
              ),
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
                title: Text('編輯投票', style: TextStyle(fontSize: _appBarSize)),
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
              body: GestureDetector(
                // 點擊空白處釋放焦點
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Container(
                    color: Colors.white,
                    child: ListView(children: [editVote, editVoteSetting])),
              ),
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
                                width: _iconWidth,
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
                                width: _iconWidth,
                              ),
                              fillColor: _color,
                              onPressed: () async {
                                if (await _submit() != true) {
                                  Navigator.pop(context);
                                }
                              }),
                        ),
                      )
                    ]),
                  ),
                ),
              )),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('編輯投票', style: TextStyle(fontSize: _appBarSize)),
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
            child: Center(child: CircularProgressIndicator()),
          ));
    }
  }
}
