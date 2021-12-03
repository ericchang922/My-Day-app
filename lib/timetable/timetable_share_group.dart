import 'package:flutter/material.dart';

import 'package:My_Day_app/models/group/group_list_model.dart';
import 'package:My_Day_app/public/group_request/group_list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/group/customer_check_box.dart';

class TimetableShareGroupPage extends StatefulWidget {
  int timetableNo;
  TimetableShareGroupPage(this.timetableNo);

  @override
  _TimetableShareGroupWidget createState() =>
      new _TimetableShareGroupWidget(timetableNo);
}

class _TimetableShareGroupWidget extends State<TimetableShareGroupPage> {
  int timetableNo;
  _TimetableShareGroupWidget(this.timetableNo);

  GroupListModel _groupListModel;

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _groupListRequest();
  }

  List typeColor = <int>[
    0xffF78787,
    0xffFFD51B,
    0xffFFA800,
    0xffB6EB3A,
    0xff53DAF0,
    0xff4968BA,
    0xffCE85E4
  ];

  Map<int, dynamic> _groupCheck = {};

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _groupListRequest() async {
    GroupListModel _request =
        await GroupList(context: context, uid: uid).getData();

    setState(() {
      _groupListModel = _request;

      for (int i = 0; i < _groupListModel.groupContent.length; i++) {
        _groupCheck[_groupListModel.groupContent[i].groupId] = false;
      }
    });
  }

  groupCheckCount() {
    int count = 0;
    for (int i = 0; i < _groupListModel.groupContent.length; i++) {
      var _group = _groupListModel.groupContent[i];
      if (_groupCheck[_group.groupId] == true) count++;
    }

    return count;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _listPaddingH = _width * 0.06;
    double _iconWidth = _width * 0.05;
    double _appBarSize = _width * 0.052;
    double _titleSize = _height * 0.025;
    double _typeSize = _width * 0.045;
    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;

    Color _light = Theme.of(context).primaryColorLight;
    Color _color = Theme.of(context).primaryColor;

    if (_groupListModel != null) {
      Widget groupList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _groupListModel.groupContent.length,
        itemBuilder: (BuildContext context, int index) {
          var groupContent = _groupListModel.groupContent[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            leading: Container(
              child: CircleAvatar(
                radius: _typeSize,
                backgroundColor: Color(typeColor[groupContent.typeId - 1]),
              ),
            ),
            title: Text(
              '${groupContent.title} (${groupContent.peopleCount})',
              style: TextStyle(fontSize: _titleSize),
            ),
            trailing: CustomerCheckBox(
                value: _groupCheck[groupContent.groupId],
                onTap: (value) {
                  setState(() {
                    _groupCheck[groupContent.groupId] = value;
                  });
                }),
            onTap: () {
              if (_groupCheck[groupContent.groupId] == false) {
                setState(() {
                  _groupCheck[groupContent.groupId] = true;
                });
              } else {
                setState(() {
                  _groupCheck[groupContent.groupId] = false;
                });
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title: Text('選擇群組', style: TextStyle(fontSize: _appBarSize)),
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
                child: Container(
                    margin: EdgeInsets.only(top: _height * 0.02),
                    child: groupList)),
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
                              // if (await _submit() != true) {
                              //   Navigator.pop(context);
                              // }
                            }),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
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
              title: Text('選擇好友', style: TextStyle(fontSize: _appBarSize)),
              leading: Container(
                margin: EdgeInsets.only(left: _leadingL),
                child: GestureDetector(
                  child: Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.pop(context);
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
