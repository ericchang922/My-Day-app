import 'package:My_Day_app/account/login.dart';
import 'package:My_Day_app/friend/friends.dart';
import 'package:flutter/material.dart';
import 'personal_information.dart';

import 'notice.dart';
import 'privacy.dart';
import 'theme.dart';

const PrimaryColor = const Color(0xFFF86D67);
class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Settings();
    
  }
}

class Settings extends State {
  get child => null;
  get left => null;
  bool _isCheck;
  @override
  void initState() {
    super.initState();
    _isCheck = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar( 
        backgroundColor: Color(0xffF86D67),
        title:Text('設定',style: TextStyle(fontSize: 20)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ), 
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
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '定位',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Switch(
                  value: _isCheck,
                  onChanged: _changed,
                  activeColor: Colors.white,
                  activeTrackColor: Color(0xffF86D67),
                  // inactiveThumbColor: Color(0xffF86D67),
                  // inactiveTrackColor: Color(0xffF86D67),
                ),
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
                MaterialPageRoute(builder: (context) => PersonalInformationPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '個人資料',
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
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => FriendsPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '好友',
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
                MaterialPageRoute(builder: (context) => NoticePage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '通知',
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
            ),
          ),
              Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ThemePage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '主題',
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
                
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '小幫手',
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
            ),
          ),
              Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => PrivacyPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '隱私',
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
                MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '登出',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
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
            ),
          ),
        ],
      ),
    );
  }

  void _changed(isCheck) {
    setState(() {
      _isCheck = isCheck;
    });
  }
}
