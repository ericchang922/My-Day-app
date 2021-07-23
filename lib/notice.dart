import 'package:flutter/material.dart';
import 'play_together_invite.dart';
import 'settings.dart';
const PrimaryColor = const Color(0xFFF86D67);
class NoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Notice();
  }
}

class Notice extends State {
  get child => null;
  get left => null;
  bool _isCheckstroke;
  bool _isCheckreciprocal;
  bool _isCheckgroup;
  @override
  void initState() {
    super.initState();
    _isCheckstroke = false;
    _isCheckreciprocal = false;
    _isCheckgroup = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Color(0xffF86D67),
        title:Text('通知',style: TextStyle(fontSize: 20)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
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
                    '行程',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Switch(
                  value: _isCheckstroke,
                  onChanged: _changedstroke,
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
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '倒數',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Switch(
                  value: _isCheckreciprocal,
                  onChanged: _changedreciprocal,
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
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '群組',
                    style: TextStyle(fontSize: 20,
                    ),
                  ),
                  Switch(
                  value: _isCheckgroup,
                  onChanged: _changedgroup,
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
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 60,
              minWidth: double.infinity,
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => PlayTogetherInvitePage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '玩聚邀請',
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
            
        ],
      ),
    );
  }

  void _changedstroke(isCheck) {
    setState(() {
      _isCheckstroke = isCheck;
    });
  }
   void _changedreciprocal(isCheck) {
    setState(() {
      _isCheckreciprocal = isCheck;
    });
  }
   void _changedgroup(isCheck) {
    setState(() {
      _isCheckgroup = isCheck;
    });
  }
}
