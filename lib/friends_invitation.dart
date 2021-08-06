// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'home.dart';
import 'main.dart';
import 'friends.dart';
import 'learn.dart';
const PrimaryColor = const Color(0xFFF86D67);
class FriendInvitationPage extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: FriendInvitation(),
      
    );
  }
}

class FriendInvitation extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar( 
        backgroundColor: Color(0xffF86D67),
        title:Text('交友邀請',style: TextStyle(fontSize: 20)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ) 
      ),
      body: ExamplePage(),
    );
  }
}
class Spacer extends StatelessWidget {
  const Spacer({Key key, this.flex = 1})
      : assert(flex != null),
        assert(flex > 0),
        super(key: key);
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: const SizedBox.shrink(),
    );
  }
}
class ExamplePage extends StatefulWidget {
  ExamplePage({Key key}) : super(key: key);
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _items = ["國文 1~3 課"];
  get child => null;
  bool viewVisible = true;

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final name = _items[index];
    return Column(
      children: <Widget>[ 
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: viewVisible,
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5, left: 35,top:10),
              child: Row(
                children: [
                  Text.rich(TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: new Image.asset(
                          "assets/images/search.png",
                          width: 20,
                        ),
                      ),
                      TextSpan(text:_items[index], style: TextStyle(fontSize: 20)),
                    ],
                  )),
                  Spacer(flex:100),
                  FlatButton(
                    child: Text(
                      '刪除',
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Color(0xffCCCCCC),
                    onPressed: hideWidget,
                  ),
                  
                  FlatButton(
                    child: Text(
                      '確認',
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Color(0xffF86D67),
                    onPressed: hideWidget,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
        ]))]);
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
