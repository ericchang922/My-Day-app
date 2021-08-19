import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/public/group_request/get.dart';
import 'package:My_Day_app/public/group_request/edit_group.dart';
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

  String uid = 'lili123';
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
  List typeColor = <int>[
    0xffF78787,
    0xffFFD51B,
    0xffFFA800,
    0xffB6EB3A,
    0xff53DAF0,
    0xff4968BA,
    0xffCE85E4
  ];

  TextEditingController get _groupNameController =>
      TextEditingController(text: _groupName);

  @override
  void initState() {
    super.initState();
    _getGroupRequest();
  }

  _getGroupRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/get_group.json');
    // var responseBody = json.decode(response);

    GetGroupModel _request = await Get(uid: uid, groupNum: groupNum).getData();

    setState(() {
      _getGroupModel = _request;
      _groupName = _getGroupModel.title;
      _groupType = _getGroupModel.typeId;
      _groupTypeName = typeNameList[_groupType];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _leadingL = _height * 0.02;
    double _listPaddingH = _width * 0.08;
    double _subtitleT = _height * 0.005;

    double _appBarSize = _width * 0.052;
    double _pSize = _height * 0.023;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _iconWidth = _width * 0.05;
    double _borderRadius = _height * 0.03;
    double _textLBR = _height * 0.02;
    double _textFied = _height * 0.045;
    double _inkwellH = _height * 0.06;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    _submit() async {
      String title = _groupName;
      int typeId = _groupType + 1;

      var submitWidget;
      _submitWidgetfunc() async {
        return EditGroup(
            uid: uid, groupNum: groupNum, title: title, typeId: typeId);
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
            contentPadding: EdgeInsets.only(top: _height * 0.02),
            content: Container(
              width: _width * 0.2,
              height: _height * 0.25,
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
                              top: _height * 0.015),
                          child:
                              Text('群組名稱：', style: TextStyle(fontSize: _pSize)),
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
                                      horizontal: _height * 0.01,
                                      vertical: _height * 0.01),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_height * 0.01)),
                                    borderSide: BorderSide(
                                      color: _textFiedBorder,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_height * 0.01)),
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
                                top: _height * 0.015, bottom: _height * 0.015),
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
                                top: _height * 0.015, bottom: _height * 0.015),
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
                            if (_groupNameController.text.isEmpty) {
                              setState(() {
                                _groupName = _groupName;
                              });
                            } else {
                              setState(() {
                                _groupName = _groupNameController.text;
                              });
                              if (await _submit() != true) {
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
          );
        },
      );
    }

    Future groupUpdateTypeDialog(BuildContext context) {
      String dropdownValue = typeNameList[_groupType];
      int _choseType;
      String _choseTypeName = '';

      typeState() {
        setState(() {
          _groupType = _choseType;
          _groupTypeName = _choseTypeName;
        });
      }

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
                contentPadding: EdgeInsets.only(top: _height * 0.02),
                content: Container(
                  width: _width * 0.2,
                  height: _height * 0.2,
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
                                  top: _height * 0.03),
                              child: Row(
                                children: [
                                  Text('群組ID：',
                                      style: TextStyle(fontSize: _pSize)),
                                  Container(
                                    height: _textFied,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: _height * 0.01,
                                        vertical: 0),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(_height * 0.01),
                                      border: Border.all(
                                          color: _textFiedBorder,
                                          style: BorderStyle.solid,
                                          width: _width * 0.0015),
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
                                      items: typeNameList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: _height * 0.01),
                                                    child: CircleAvatar(
                                                      radius: _height * 0.01,
                                                      backgroundColor: Color(
                                                          typeColor[typeNameList
                                                              .indexOf(value)]),
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
                                    top: _height * 0.015,
                                    bottom: _height * 0.015),
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
                                    top: _height * 0.015,
                                    bottom: _height * 0.015),
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
                                setState(() {
                                  _choseType =
                                      typeNameList.indexOf(dropdownValue);
                                  _choseTypeName = typeNameList[_choseType];
                                });
                                typeState();
                                if (await _submit() != true) {
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
        margin: EdgeInsets.only(top: _height * 0.01),
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
              onTap: () {
                groupUpdateTypeDialog(context);
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
      return Scaffold(
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
          body: Container(color: Colors.white, child: informationItem));
    } else {
      return Scaffold(
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
            bottom: false,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
  }
}
