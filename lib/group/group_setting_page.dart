import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/group/group_information_page.dart';
import 'package:My_Day_app/group/group_manager_page.dart';

class GroupSettingPage extends StatefulWidget {
  int groupNum;
  GroupSettingPage(this.groupNum);

  @override
  _GroupSettingWidget createState() => new _GroupSettingWidget(groupNum);
}

class _GroupSettingWidget extends State<GroupSettingPage> {
  int groupNum;
  _GroupSettingWidget(this.groupNum);

  String uid = 'lili123';

  bool _settingCheck = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _leadingL = _height * 0.02;
    double _listPaddingH = _width * 0.08;

    double _appBarSize = _width * 0.052;
    double _titleSize = _height * 0.025;

    Color _lightGray = Color(0xffE3E3E3);
    Color _color = Theme.of(context).primaryColor;

    Widget settingItem = Container(
      margin: EdgeInsets.only(top: _height * 0.01),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _width * 0.04, vertical: 0.0),
            title: Container(
                margin: EdgeInsets.only(left: _width * 0.035),
                child: Text('通知', style: TextStyle(fontSize: _titleSize))),
            trailing: Switch(
              value: _settingCheck,
              onChanged: (value) {
                setState(() {
                  _settingCheck = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            title: Text('群組資訊', style: TextStyle(fontSize: _titleSize)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: _lightGray,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GroupInformationPage(groupNum)));
            },
          ),
          Divider(),
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            title: Text('管理者', style: TextStyle(fontSize: _titleSize)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: _lightGray,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GroupManagerPage(groupNum)));
            },
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
                title: Text('設定', style: TextStyle(fontSize: _appBarSize)),
                leading: Container(
                  margin: EdgeInsets.only(left: _leadingL),
                  child: GestureDetector(
                    child: Icon(Icons.chevron_left),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
            body: Container(
                color: Colors.white,
                child: SafeArea(top: false, child: settingItem))),
      ),
    );
  }
}
