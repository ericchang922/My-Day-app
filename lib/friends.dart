// import 'package:My_Day_app/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'learn.dart';
import 'main.dart';
import 'friends_add.dart';
import 'bestfriend.dart';
import 'friends_invitation.dart';
import 'settings.dart';
class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomePageWidget(),
        
        '/learn' : (BuildContext context) => new LearnPage(),
      },
      home: Scaffold(
        body: FriendsPageWidget(),
      ),
    );
  }
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class FriendsPageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title:Text('好友',style: TextStyle(fontSize: 20)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        ), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
             bool action = await friendsAddDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => BestFriendPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '摯友',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xffE3E3E3),
                  )
                ],
              ),
            ),
          ),
          Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  margin: EdgeInsets.only(top: 4.0),
                  color: Color(0xffE3E3E3),
                  constraints: BoxConstraints.expand(height: 1.0),
                )),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) =>FriendInvitationPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '交友邀請',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xffE3E3E3),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            )),
          Container(
            margin: EdgeInsets.only(left: 35,top:20),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/search.png",
                  width: 20,
                ),      
              Container(
                margin: EdgeInsets.only(left: 35),
                child: Text('xxxxxx',style: TextStyle(fontSize: 20)),
              ),
        ])),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            )),
          Container(
            margin: EdgeInsets.only(left: 35,top:20),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/search.png",
                  width: 20,
                ),      
              Container(
                margin: EdgeInsets.only(left: 35),
                child: Text('xxxxxx',style: TextStyle(fontSize: 20)),
              ),
        ])),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            )),
          Container(
            margin: EdgeInsets.only(left: 35,top:20),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/search.png",
                  width: 20,
                ),      
              Container(
                margin: EdgeInsets.only(left: 35),
                child: Text('xxxxxx',style: TextStyle(fontSize: 20)),
              ),
        ])),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            )),
    ]));
  }
}




