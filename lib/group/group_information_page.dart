import 'package:flutter/material.dart';

import 'package:My_Day_app/public/group_request/edit_group.dart';
import 'package:My_Day_app/public/type_color.dart';
import 'package:My_Day_app/public/group_request/get.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/models/group/get_group_model.dart';

class GroupInformationPage extends StatefulWidget {
  int groupNum;
  GroupInformationPage(this.groupNum);

  @override
  _GroupInformationWidget createState() =>
      new _GroupInformationWidget(groupNum);
}

class _GroupInformationWidget extends State<GroupInformationPage> {
  int groupNum;
  _GroupInformationWidget(this.groupNum);

  GetGroupModel _getGroupModel;

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getGroupRequest();
  }

  String _groupName = '';
  String _groupTypeName = '';

  int _groupType;

  List<String> typeNameList = <String>[
    '讀書',
    '工作',
    '會議',
    '休閒',
    '社團',
    '吃飯',
    '班級'
  ];

  TextEditingController get _groupNameController =>
      TextEditingController(text: _groupName);

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _getGroupRequest() async {
    GetGroupModel _request =
        await Get(context: context, uid: uid, groupNum: groupNum).getData();

    setState(() {
      _getGroupModel = _request;
      _groupName = _getGroupModel.title;
      _groupType = _getGroupModel.typeId;
      _groupTypeName = typeNameList[_groupType - 1];
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _leadingL = _sizing.height(2);
    double _listPaddingH = _sizing.width(8);
    double _subtitleT = _sizing.height(0.5);

    double _appBarSize = _sizing.width(5.2);
    double _pSize = _sizing.height(2.3);
    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);
    double _iconWidth = _sizing.width(5);
    double _borderRadius = _sizing.height(3);
    double _textLBR = _sizing.height(2);
    double _textFied = _sizing.height(4.5);
    double _inkwellH = _sizing.height(6);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    Color getTypeColor(value) {
      Color color = value == null ? Color(0xffFFFFFF) : typeColor(value);
      return color;
    }

    _submit() async {
      String title = _groupName;
      int typeId = _groupType;

      var submitWidget;
      _submitWidgetfunc() async {
        return EditGroup(
            context: context,
            uid: uid,
            groupNum: groupNum,
            title: title,
            typeId: typeId);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    Future groupUpdateNameDialog(BuildContext context) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
            contentPadding: EdgeInsets.only(top: _sizing.height(2)),
            content: Container(
              width: _sizing.width(20),
              height: _sizing.height(24),
              child: GestureDetector(
                // 點擊空白處釋放焦點
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "更改群組名稱",
                                style: TextStyle(fontSize: _pSize),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: _textLBR,
                                right: _textLBR,
                                bottom: _textLBR,
                                top: _sizing.height(1.5)),
                            child: Text('群組名稱：',
                                style: TextStyle(fontSize: _pSize)),
                          ),
                          Container(
                              height: _textFied,
                              margin: EdgeInsets.only(
                                left: _textLBR,
                                right: _textLBR,
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
                                controller: _groupNameController,
                                onChanged: (text) {
                                  setState(() {
                                    _groupName = text;
                                  });
                                },
                              )),
                        ],
                      ),
                    ),
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
                                    fontSize: _subtitleSize,
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
                              height: _inkwellH,
                              padding: EdgeInsets.only(
                                  top: _sizing.height(1.5),
                                  bottom: _sizing.height(1.5)),
                              decoration: BoxDecoration(
                                color: _color,
                                borderRadius: BorderRadius.only(
                                    bottomRight:
                                        Radius.circular(_borderRadius)),
                              ),
                              child: Text(
                                "確認",
                                style: TextStyle(
                                    fontSize: _subtitleSize,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () async {
                              if (_groupNameController.text.isEmpty) {
                                setState(() {
                                  _groupName = _groupName;
                                });
                              } else {
                                setState(() {
                                  _groupName = _groupNameController.text;
                                });
                                if (await _submit() != true) {
                                  _getGroupRequest();
                                  Navigator.of(context).pop();
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
            ),
          );
        },
      );
    }

    Future groupUpdateTypeDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(_borderRadius))),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "更改群組類別",
                                  style: TextStyle(fontSize: _pSize),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: _textLBR,
                                  right: _textLBR,
                                  bottom: _textLBR,
                                  top: _sizing.height(3)),
                              child: Row(
                                children: [
                                  Text('類別：',
                                      style: TextStyle(fontSize: _pSize)),
                                  Container(
                                    height: _textFied,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: _sizing.height(1),
                                        vertical: 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          _sizing.height(1)),
                                      border: Border.all(
                                          color: _textFiedBorder,
                                          style: BorderStyle.solid,
                                          width: _sizing.width(0.15)),
                                    ),
                                    child: DropdownButton<String>(
                                      icon: Icon(
                                        Icons.expand_more,
                                        color: Color(0xffcccccc),
                                      ),
                                      value: _groupTypeName,
                                      iconSize: _iconWidth,
                                      elevation: 16,
                                      underline: Container(height: 0),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _groupTypeName = newValue;
                                          _groupType = typeNameList
                                                  .indexOf(_groupTypeName) +
                                              1;
                                        });
                                      },
                                      items: typeNameList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            _sizing.height(1)),
                                                    child: CircleAvatar(
                                                      radius: _sizing.height(1),
                                                      backgroundColor:
                                                          getTypeColor(
                                                              typeNameList
                                                                      .indexOf(
                                                                          value) +
                                                                  1),
                                                    )),
                                                Text(value),
                                              ],
                                            ));
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(_borderRadius),
                                  ),
                                ),
                                child: Text(
                                  "取消",
                                  style: TextStyle(
                                      fontSize: _subtitleSize,
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
                                height: _inkwellH,
                                padding: EdgeInsets.only(
                                    top: _sizing.height(1.5),
                                    bottom: _sizing.height(1.5)),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(_borderRadius)),
                                ),
                                child: Text(
                                  "確認",
                                  style: TextStyle(
                                      fontSize: _subtitleSize,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onTap: () async {
                                if (await _submit() != true) {
                                  _getGroupRequest();
                                  Navigator.of(context).pop();
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
            });
          });
    }

    if (_getGroupModel != null) {
      Widget informationItem = Container(
        margin: EdgeInsets.only(top: _sizing.height(1)),
        child: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _listPaddingH, vertical: 0.0),
              title: Text('名稱', style: TextStyle(fontSize: _titleSize)),
              subtitle: Container(
                  margin: EdgeInsets.only(top: _subtitleT),
                  child: Text(_groupName,
                      style: TextStyle(fontSize: _subtitleSize))),
              onTap: () async {
                await groupUpdateNameDialog(context);
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _listPaddingH, vertical: 0.0),
              title: Text('類別', style: TextStyle(fontSize: _titleSize)),
              subtitle: Container(
                margin: EdgeInsets.only(top: _subtitleT),
                child: Text(_groupTypeName,
                    style: TextStyle(fontSize: _subtitleSize)),
              ),
              onTap: () async {
                await groupUpdateTypeDialog(context);
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _listPaddingH, vertical: 0.0),
              title: Text('群組ID', style: TextStyle(fontSize: _titleSize)),
              subtitle: Container(
                margin: EdgeInsets.only(top: _subtitleT),
                child: Text(groupNum.toString(),
                    style: TextStyle(fontSize: _subtitleSize)),
              ),
            ),
          ],
        ),
      );
      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: _color,
                title: Text('群組資訊', style: TextStyle(fontSize: _appBarSize)),
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
                  child: SafeArea(top: false, child: informationItem))),
        ),
      );
    } else {
      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title: Text('群組資訊', style: TextStyle(fontSize: _appBarSize)),
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
              child: SafeArea(
                  top: false,
                  child: Center(child: CircularProgressIndicator())),
            ),
          ),
        ),
      );
    }
  }
}
