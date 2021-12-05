import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';

import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/public/vote_request/create_new.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class VoteSettingPage extends StatefulWidget {
  int groupNum;
  int optionTypeId;
  String title;
  List voteItems;
  VoteSettingPage(this.groupNum, this.optionTypeId, this.title, this.voteItems);

  @override
  _VoteSettingWidget createState() =>
      new _VoteSettingWidget(groupNum, optionTypeId, title, voteItems);
}

class _VoteSettingWidget extends State<VoteSettingPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);
  }

  int groupNum;
  int optionTypeId;
  String title;
  List voteItems;
  _VoteSettingWidget(
      this.groupNum, this.optionTypeId, this.title, this.voteItems);

  Map _voteSettingCheck = {1: false, 2: false, 3: false, 4: false};

  DateTime _deadLine = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0)
      .add(Duration(days: 3));

  String _deadLineValue = "";

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

  @override
  void initState() {
    super.initState();
    _uid();

    setState(() {
      _deadLineValue = _dateFormat(_deadLine);
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
    Sizing _sizing = Sizing(context);

    double _textFied = _sizing.height(4.5);
    double _borderRadius = _sizing.height(1);
    double _iconWidth = _sizing.width(5);
    double _listTilePadding = _sizing.height(1.8);
    double _leadingL = _sizing.height(2);
    double _bottomHeight = _sizing.height(7);

    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _textFiedBorder = Color(0xff707070);

    _submit() async {
      String deadLine;
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
      var submitWidget;
      _submitWidgetfunc() async {
        return CreateNew(
            uid: uid,
            groupNum: groupNum,
            optionTypeId: optionTypeId,
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

    _deadLinePicker(contex) {
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
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _deadLineValue = _dateFormat(_deadLine);
                        });
                      }),
                ),
              ),
              Container(
                height: _sizing.height(28),
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

    Widget voteSettingItem = ListView(
      padding: EdgeInsets.only(
          top: _sizing.height(6),
          right: _sizing.height(6),
          left: _sizing.height(6)),
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
            contentPadding: EdgeInsets.only(left: _sizing.height(8)),
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
            margin: EdgeInsets.only(left: _sizing.height(8)),
            child: Row(
              children: [
                Text("一人最多", style: TextStyle(fontSize: _appBarSize)),
                Container(
                  margin: EdgeInsets.only(
                      left: _sizing.height(1), right: _sizing.height(1)),
                  height: _textFied,
                  padding: EdgeInsets.symmetric(
                      horizontal: _sizing.height(0.7), vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    border: Border.all(
                        color: _textFiedBorder,
                        style: BorderStyle.solid,
                        width: _sizing.width(0.1)),
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
                              margin: EdgeInsets.only(left: _sizing.width(2)),
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text('投票設定', style: TextStyle(fontSize: _appBarSize)),
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
      body: Container(color: Colors.white, child: voteSettingItem),
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
                        print("title：" + title);
                        print(optionTypeId);
                        print("voteItems：${voteItems}");
                        if (_voteSettingCheck[1] == true) {
                          print("deadLine：" + _deadLine.toString());
                        } else {
                          print("deadLine：null");
                        }
                        print("isAddItemPermit：${_voteSettingCheck[2]}");
                        print("isAnonymous：${_voteSettingCheck[3]}");
                        if (_voteSettingCheck[4] == true) {
                          print(
                              "chooseVoteQuantity：${int.parse(dropdownValue)}");
                        } else {
                          print("chooseVoteQuantity：1");
                        }
                        if (await _submit() != true) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      }),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
