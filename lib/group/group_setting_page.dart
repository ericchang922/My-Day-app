import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/get_group_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'group_information_page.dart';
import 'group_invite_page.dart';
import 'group_manager_page.dart';
import 'group_member_page.dart';

class GroupSettingPage extends StatefulWidget {

  int groupNum;
  GroupSettingPage(this.groupNum);

  @override
  _GroupSettingWidget createState() => new _GroupSettingWidget(groupNum);
}

class _GroupSettingWidget extends State<GroupSettingPage> {
  String uid = 'lili123';
  bool _settingCheck = false;

  int groupNum;
  _GroupSettingWidget(this.groupNum);

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
            title: Text('設定', style: TextStyle(fontSize: 20))),
        body: _buildSettingItem(context));
  }

  Widget _buildSettingItem(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          title: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text('通知', style: TextStyle(fontSize: 20))),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
          title: Text('群組資訊', style: TextStyle(fontSize: 20)),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Color(0xffE3E3E3),
          ),
          onTap: (){
            Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GroupInformationPage(groupNum)));
          },
        ),
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
          title: Text('管理者', style: TextStyle(fontSize: 20)),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Color(0xffE3E3E3),
          ),
          onTap: (){
            Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GroupManagerPage(groupNum)));
          },
        ),
      ],
    );
  }
}
