import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/get_group_model.dart';
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

  final _groupNameController = TextEditingController();

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
    return Scaffold(
        appBar: AppBar(
            leading: Container(
              margin: EdgeInsets.only(left: 5),
              child: GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            title: Text('群組資訊', style: TextStyle(fontSize: 20))),
        body: _buildInformationItem(context));
  }

  Widget _buildInformationItem(BuildContext context) {
    if (_getGroupModel != null) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
              title: Text('名稱', style: TextStyle(fontSize: 20)),
              subtitle: Text(_groupName, style: TextStyle(fontSize: 16)),
              onTap: () async {
                await groupUpdateNameDialog(context);
              },
            ),
            Divider(),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
              title: Text('類別', style: TextStyle(fontSize: 20)),
              subtitle: Text(_groupTypeName, style: TextStyle(fontSize: 16)),
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
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            height: 210,
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
                      "更改群組名稱",
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 10, bottom: 20, top: 15),
                  child: Text('群組名稱：', style: TextStyle(fontSize: 18)),
                ),
                Container(
                    height: 40.0,
                    margin: EdgeInsets.only(left: 20, right: 10, bottom: 33),
                    child: new TextField(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Color(0xff070707),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color(0xff7AAAD8)),
                          )),
                      controller: _groupNameController..text = _groupName,
                    )),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            "取消",
                            style: TextStyle(color: Colors.white),
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
                          height: 50,
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30.0)),
                          ),
                          child: Text(
                            "確認",
                            style: TextStyle(color: Colors.white),
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
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                width: 300.0,
                height: 180,
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
                          "更改群組類別",
                          style: TextStyle(fontSize: 18.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 10, bottom: 34, top: 30),
                      child: Row(
                        children: [
                          Text('群組ID：', style: TextStyle(fontSize: 18)),
                          Container(
                            height: 40.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Color(0xff707070),
                                  style: BorderStyle.solid,
                                  width: 0.80),
                            ),
                            child: DropdownButton<String>(
                              icon: Icon(
                                Icons.expand_more,
                                color: Color(0xffcccccc),
                              ),
                              value: dropdownValue,
                              iconSize: 24,
                              elevation: 16,
                              underline: Container(height: 0),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: typeNameList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: CircleAvatar(
                                              radius: 10.0,
                                              backgroundColor: Color(typeColor[
                                                  typeNameList.indexOf(value)]),
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
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                "取消",
                                style: TextStyle(color: Colors.white),
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
                              height: 50,
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30.0)),
                              ),
                              child: Text(
                                "確認",
                                style: TextStyle(color: Colors.white),
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
