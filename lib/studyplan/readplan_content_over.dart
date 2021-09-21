// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:My_Day_app/studyplan/note_choose.dart';
import 'package:My_Day_app/studyplan/readplan_add_note.dart';
import 'package:My_Day_app/studyplan/readplan_content_delete.dart';
import 'package:My_Day_app/studyplan/readplan_edit.dart';
import 'package:flutter/material.dart';


selectedItem(BuildContext context, item) async {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ReadPlanEdit()));
      break;
    case 1:
      bool action = await readplanDeleteDialog(context);
      break;
  }
}

class OverReadPlanContentPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return MaterialApp(
        theme: ThemeData(
          platform: TargetPlatform.iOS,
        ),
        debugShowCheckedModeBanner: false,
        home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffF86D67),
            title: Text('期末考 2020/11/28', style: TextStyle(fontSize: 20)),
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              PopupMenuButton<int>(
                offset: Offset(50, 50),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(screenSize.height * 0.01)),
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text("編輯",
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.05)))),
                  PopupMenuDivider(
                    height: 1,
                  ),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text("刪除",
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.05)))),
                ],
                onSelected: (item) => selectedItem(context, item),
              ),
            ],
            
            ),
         
          body: SingleChildScrollView(
            child: Column(children: [
              ReadPlanContent(),
              ExamplePage(),
              Personal(),
              ExamplePage(),
            ]),
          ),
        )));
  }
}

class ReadPlanContent extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
          // ignore: deprecated_member_use
          child: SizedBox(
              height: 40,
              
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color(0xffFFB5B5)
                ),
            onPressed: () {
              return null;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '8:00~12:00',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        )],
    );
  }
}

class ExamplePage extends StatefulWidget {
  ExamplePage({Key key}) : super(key: key);
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final items = ["國文 1~3 課", "國文 4~6 課", "國文 7~9 課", "國文 10~12 課"];
  final _items = ["國文課", "國文課", "國文課", "國文課"];
  Widget _buildItem(BuildContext context, int index) {
    final title = items[index];
    final mintitle = _items[index];
    bool _checkboxSelected = true;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10, left: 20, top: 10),
            child: SizedBox(
              height: 67,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
              onPressed: () async {
                bool action = await readplanAddDialog(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Transform.scale(
                  scale: 1.8,
                  child: Checkbox(
                    value: _checkboxSelected,
                    activeColor: Color(0xffEFB208),//选中时的颜色
                    onChanged: (value) {
                      setState(() {
                        _checkboxSelected = value;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  )),
                  Column(children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      mintitle,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ]),
                  IconButton(
                    icon: Image.asset('assets/images/note.png'),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                ],
              ),
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 4.0),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>(_items.length);
    for (var i = 0; i < _items.length; i++) {
      children[i] = _buildItem(context, i);
    }
    return ListView(shrinkWrap: true, children: children);
    // bottomNavigationBar:
  }
}

class Personal extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 10.0, top: 10.0),
          child: Text(
            '休息時間',
            style: TextStyle(
              fontSize: 20,
            ),
          ),    
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          color: Color(0xffE3E3E3),
          constraints: BoxConstraints.expand(height: 1.0),
        ),
      ],
    );
  }
}