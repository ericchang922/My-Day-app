import 'package:flutter/material.dart';

import 'package:My_Day_app/group/group_information_page.dart';
import 'package:My_Day_app/group/group_manager_page.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class GroupSettingPage extends StatefulWidget {
  int groupNum;
  GroupSettingPage(this.groupNum);

  @override
  _GroupSettingWidget createState() => new _GroupSettingWidget(groupNum);
}

class _GroupSettingWidget extends State<GroupSettingPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);
  }

  int groupNum;
  _GroupSettingWidget(this.groupNum);

  bool _settingCheck = false;

  @override
  void initState() {
    super.initState();
    _uid();
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _leadingL = _sizing.height(2);
    double _listPaddingH = _sizing.width(8);

    double _appBarSize = _sizing.width(5.2);
    double _titleSize = _sizing.height(2.5);

    Color _lightGray = Color(0xffE3E3E3);
    Color _color = Theme.of(context).primaryColor;

    Widget settingItem = Container(
      margin: EdgeInsets.only(top: _sizing.height(1)),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: _sizing.width(4), vertical: 0.0),
            title: Container(
                margin: EdgeInsets.only(left: _sizing.width(3.5)),
                child: Text('通知', style: TextStyle(fontSize: _titleSize))),
            trailing: Switch(
              value: _settingCheck,
              activeColor: _color,
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
