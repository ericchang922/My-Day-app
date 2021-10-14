import 'package:flutter/material.dart';


const PrimaryColor = const Color(0xFFF86D67);

class PlayTogetherInvitePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlayTogetherInvite();
  }
}

class PlayTogetherInvite extends State {
  get child => null;
  get left => null;
  bool _isCheck;
  bool _hasBeenPressed = false;
  bool _hasBeenPress = false;
  bool _isCheckstroke;
  bool _isCheckreciprocal;
  bool _isCheckgroup;
  @override
  void initState() {
    super.initState();
    _isCheck = false;
    _isCheckstroke = false;
    _isCheckreciprocal = false;
    _isCheckgroup = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('玩聚邀請', style: TextStyle(fontSize: 20)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5, left: 28),
            // ignore: deprecated_member_use
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '玩聚邀請',
                      style: TextStyle(
                        fontSize: 20,
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
              )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: new Image.asset(
                        "assets/images/search.png",
                        width: 20,
                      ),
                    ),
                    TextSpan(text: 'xxxxxx',style: TextStyle(fontSize: 20,)),
                  ],
                )),
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
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: new Image.asset(
                        "assets/images/search.png",
                        width: 20,
                      ),
                    ),
                    TextSpan(text: 'xxxxxx',style: TextStyle(fontSize: 20,)),
                  ],
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
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: new Image.asset(
                        "assets/images/search.png",
                        width: 20,
                      ),
                    ),
                    TextSpan(text: 'xxxxxx',style: TextStyle(fontSize: 20,)),
                  ],
                )),
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
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
        ],
      ),
    ));
  }

  void _changed(isCheck) {
    setState(() {
      if(_isCheck=isCheck){
        _isCheckstroke = true;
        _isCheckreciprocal = true;
        _isCheckgroup = true;
      }else{
        _isCheckstroke = false;
        _isCheckreciprocal = false;
        _isCheckgroup = false;
      }
    });
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
