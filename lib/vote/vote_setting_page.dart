import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';

class VoteSettingPage extends StatefulWidget {
  int groupNum;
  String title;
  List voteItems;
  VoteSettingPage(this.groupNum, this.title, this.voteItems);

  @override
  _VoteSettingWidget createState() =>
      new _VoteSettingWidget(groupNum, title, voteItems);
}

class _VoteSettingWidget extends State<VoteSettingPage> {
  int groupNum;
  String title;
  List voteItems;
  _VoteSettingWidget(this.groupNum, this.title, this.voteItems);

  Map _voteSettingCheck = {1: false, 2: false, 3: false, 4: false};
  String _deadLine = formatDate(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 8,
              0)
          .add(Duration(days: 3)),
      [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);

  String _deadLineFormat = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0)
      .add(Duration(days: 3))
      .toString();

  DateTime _presetTime = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0)
      .add(Duration(days: 3));

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
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:
            Text('投票設定', style: TextStyle(fontSize: screenSize.width * 0.052)),
        leading: Container(
          margin: EdgeInsets.only(left: 5),
          child: GestureDetector(
            child: Icon(Icons.chevron_left),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: _buildVoteSettingWidget(context),
    );
  }

  Widget _buildVoteSettingWidget(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildVoteSettingItem(context)),
        _buildCheckButtom(context)
      ],
    );
  }

  Widget _buildVoteSettingItem(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.only(
          top: screenSize.height * 0.06,
          right: screenSize.height * 0.06,
          left: screenSize.height * 0.06),
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
            title: Text(_deadLine,
                style: TextStyle(fontSize: screenSize.width * 0.05)),
            onTap: () {
              Pickers.showDatePicker(
                context,
                pickerStyle: customizeStyle(),
                mode: DateMode.YMDHM,
                suffix: Suffix(
                  years: '年',
                  month: '月',
                  days: '日',
                  hours: ' 時',
                  minutes: ' 分',
                ),
                selectDate: PDuration(
                    year: _presetTime.year,
                    month: _presetTime.month,
                    day: _presetTime.day,
                    hour: 8,
                    minute: 0),
                onConfirm: (p) {
                  setState(() {
                    _deadLine = formatDate(
                        DateTime(p.year, p.month, p.day, p.hour, p.minute),
                        [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
                    _presetTime =
                        DateTime(p.year, p.month, p.day, p.hour, p.minute);
                    _deadLineFormat = DateTime(
                      p.year,
                      p.month,
                      p.day,
                      p.hour,
                      p.minute,
                    ).toString();
                  });
                },
              );
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
            margin: EdgeInsets.only(left: screenSize.height * 0.08),
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
            onPressed: () {
              print("title："+title);
              print("voteItems：${voteItems}");
              if (_voteSettingCheck[1] == true) {
                print("deadLine：" + _deadLineFormat);
              } else {
                print("deadLine：null");
              }
              print("isAddItemPermit：${_voteSettingCheck[2]}");
              print("isAnonymous：${_voteSettingCheck[3]}");
              if (_voteSettingCheck[4] == true) {
                print("chooseVoteQuantity：${int.parse(dropdownValue)}");
              } else {
                print("chooseVoteQuantity：1");
              }
            });
      }))
    ]);
  }

  PickerStyle customizeStyle() {
    var screenSize = MediaQuery.of(context).size;

    Widget _cancelButton = Container(
        margin: EdgeInsets.only(left: screenSize.width * 0.03),
        child: Text(
          '取消',
          style: TextStyle(
            fontSize: screenSize.width * 0.041,
            color: Color(0xffb4b4b4),
          ),
        ));
    Widget _commitButton = Container(
      margin: EdgeInsets.only(right: screenSize.width * 0.03),
      child: Text(
        '確認',
        style: TextStyle(
            fontSize: screenSize.width * 0.041,
            color: Theme.of(context).primaryColor),
      ),
    );
    return PickerStyle(
      cancelButton: _cancelButton,
      commitButton: _commitButton,
    );
  }
}
