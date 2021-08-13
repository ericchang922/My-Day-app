import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/group/get_group_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupInformationPage extends StatefulWidget {
  int groupNum;
  GroupInformationPage(this.groupNum);

  @override
  _GroupInformationWidget createState() =>
      new _GroupInformationWidget(groupNum);
}

class _GroupInformationWidget extends State<GroupInformationPage> {
  String uid = 'lili123';
  String _groupName = '';
  String _groupTypeName = '';
  int _groupType;

  var typeNameList = <String>['讀書', '工作', '會議', '休閒', '社團', '吃飯', '班級'];

  List typeColor = <int>[
    0xffF78787,
    0xffFFD51B,
    0xffFFA800,
    0xffB6EB3A,
    0xff53DAF0,
    0xff4968BA,
    0xffCE85E4
  ];

  GetGroupModel _getGroupModel = null;

  TextEditingController get _groupNameController =>
      TextEditingController(text: _groupName);

  int groupNum;
  _GroupInformationWidget(this.groupNum);

  @override
  void initState() {
    _getGroupRequest();
    super.initState();
  }

  void _getGroupRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/get_group.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
        '/group/get/', {'uid': uid, 'groupNum': groupNum.toString()}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(jsonString);

    var jsonBody = json.decode(jsonString);

    var getGroupModel = GetGroupModel.fromJson(jsonBody);

    setState(() {
      _getGroupModel = getGroupModel;
      _groupName = getGroupModel.title;
      _groupType = getGroupModel.typeId;
      _groupTypeName = typeNameList[_groupType];
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: Container(
              margin: EdgeInsets.only(left: screenSize.height * 0.02),
              child: GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            title: Text('群組資訊', style: TextStyle(fontSize: screenSize.width * 0.052))),
        body: Container(color: Colors.white, child: _buildInformationItem(context)));
  }

  Widget _buildInformationItem(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_getGroupModel != null) {
      return Container(
        margin: EdgeInsets.only(top: screenSize.height * 0.01),
        child: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.04,
                      vertical: 0.0),
              title: Text('名稱', style: TextStyle(fontSize: screenSize.width * 0.045)),
              subtitle: Text(_groupName, style: TextStyle(fontSize: screenSize.width * 0.032)),
              onTap: () async {
                await groupUpdateNameDialog(context);
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.04,
                      vertical: 0.0),
              title: Text('類別', style: TextStyle(fontSize: screenSize.width * 0.045)),
              subtitle: Text(_groupTypeName, style: TextStyle(fontSize: screenSize.width * 0.032)),
              onTap: () {
                groupUpdateTypeDialog(context);
              },
            ),
          ],
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future groupUpdateNameDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(screenSize.height * 0.03))),
          contentPadding: EdgeInsets.only(top: screenSize.height * 0.02),
          content: Container(
            width: screenSize.width * 0.2,
            height: screenSize.height * 0.2459,
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
                            style:
                                TextStyle(fontSize: screenSize.width * 0.041),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenSize.height * 0.02,
                            right: screenSize.height * 0.02,
                            bottom: screenSize.height * 0.02,
                            top: screenSize.height * 0.015),
                        child: Text('群組名稱：',
                            style:
                                TextStyle(fontSize: screenSize.width * 0.041)),
                      ),
                      Container(
                          height: screenSize.height * 0.04683,
                          margin: EdgeInsets.only(
                            left: screenSize.height * 0.02,
                            right: screenSize.height * 0.02,
                            bottom: screenSize.height * 0.0384,
                          ),
                          child: new TextField(
                            style:
                                TextStyle(fontSize: screenSize.width * 0.041),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenSize.height * 0.01,
                                    vertical: screenSize.height * 0.01),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          screenSize.height * 0.01)),
                                  borderSide: BorderSide(
                                    color: Color(0xff070707),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          screenSize.height * 0.01)),
                                  borderSide:
                                      BorderSide(color: Color(0xff7AAAD8)),
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
                                bottomRight:
                                    Radius.circular(screenSize.height * 0.03)),
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
                          if (_groupNameController.text.isEmpty) {
                            setState(() {
                              _groupName = _groupName;
                            });
                          } else {
                            setState(() {
                              _groupName = _groupNameController.text;
                            });
                            Navigator.of(context).pop(true);
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

    void typeState() {
      setState(() {
        _groupType = _choseType;
        _groupTypeName = _choseTypeName;
      });
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          var screenSize = MediaQuery.of(context).size;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(screenSize.height * 0.03))),
              contentPadding: EdgeInsets.only(top: screenSize.height * 0.02),
              content: Container(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.2098,
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
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.041),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: screenSize.height * 0.02,
                                right: screenSize.height * 0.02,
                                bottom: screenSize.height * 0.04,
                                top: screenSize.height * 0.03),
                            child: Row(
                              children: [
                                Text('群組ID：',
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.041)),
                                Container(
                                  height: screenSize.height * 0.04683,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.height * 0.01,
                                      vertical: 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        screenSize.height * 0.01),
                                    border: Border.all(
                                        color: Color(0xff707070),
                                        style: BorderStyle.solid,
                                        width: screenSize.width * 0.0015),
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
                                    items: typeNameList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: screenSize.height *
                                                          0.01),
                                                  child: CircleAvatar(
                                                    radius: screenSize.height *
                                                        0.01,
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
                                _choseType =
                                    typeNameList.indexOf(dropdownValue);
                                _choseTypeName = typeNameList[_choseType];
                              });
                              print(_choseType + 1);
                              typeState();
                              Navigator.of(context).pop();
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
}
