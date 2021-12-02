import 'package:My_Day_app/models/setting/get_notice.dart';
import 'package:My_Day_app/public/setting_request/get_notice.dart';
import 'package:My_Day_app/public/setting_request/notice.dart';
import 'package:My_Day_app/setting/play_together_invite.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class NoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Notice();
  }
}

class _Notice extends State {
  get child => null;
  get left => null;
  bool _isCheckschedule;
  bool _isCheckCountdown;
  bool _isCheckgroup;
  String id = "lili123";
  GetNoticeModel _notice;
  @override
  void initState() {
    super.initState();
    _getNoticeRequest();
    if (_notice == null) {
      _isCheckschedule = false;
      _isCheckCountdown = false;
      _isCheckgroup = false;
    } else if (_notice == 1) {
      _isCheckschedule = true;
      _isCheckCountdown = true;
      _isCheckgroup = true;
    } else {
      _isCheckschedule = false;
      _isCheckCountdown = false;
      _isCheckgroup = false;
    }
  }

  _getNoticeRequest() async {
    // var response = await rootBundle.loadString('assets/json/group_list.json');
    // var responseBody = json.decode(response);

    GetNoticeModel _request = await GetNotice(uid: id).getData();

    setState(() {
      _notice = _request;
      print(_notice);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _appBarSize = _width * 0.052;
    double _bottomHeight = _height * 0.07;
    _submit() async {
      String uid = id;
      bool isSchedule = _isCheckschedule;
      bool isCountdown = _isCheckCountdown;
      bool isGroup = _isCheckgroup;

      var submitWidget;
      _submitWidgetfunc() async {
        return Notice(
            uid: uid,
            isSchedule: isSchedule,
            isCountdown: isCountdown,
            isGroup: isGroup);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('通知', style: TextStyle(fontSize: _appBarSize)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
              child: SizedBox(
                  height: _bottomHeight,
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
                          '行程',
                          style: TextStyle(
                            fontSize: _appBarSize,
                          ),
                        ),
                        Switch(
                          value: _isCheckschedule,
                          onChanged: (value) async {
                            if (await _submit() != true) {
                              setState(() {
                                _isCheckschedule = value;
                              });
                            }
                          },
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
              margin: EdgeInsets.only(top: _height * 0.001),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
              child: SizedBox(
                  height: _bottomHeight,
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
                          '倒數',
                          style: TextStyle(
                            fontSize: _appBarSize,
                          ),
                        ),
                        Switch(
                          value: _isCheckCountdown,
                          onChanged: (value) async {
                            if (await _submit() != true) {
                              setState(() {
                                _isCheckCountdown = value;
                              });
                            }
                          },
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
              margin: EdgeInsets.only(top: _height * 0.001),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
              child: SizedBox(
                  height: _bottomHeight,
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
                          '群組',
                          style: TextStyle(
                            fontSize: _appBarSize,
                          ),
                        ),
                        Switch(
                          value: _isCheckgroup,
                          onChanged: (value) async {
                            if (await _submit() != true) {
                              setState(() {
                                _isCheckgroup = value;
                              });
                            }
                          },
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
              margin: EdgeInsets.only(top: _height * 0.001),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: _height * 0.01, left: _height * 0.018),
              child: SizedBox(
                  height: _bottomHeight,
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayTogetherInvitePage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '玩聚邀請',
                          style: TextStyle(
                            fontSize: _appBarSize,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xffE3E3E3),
                        )
                      ],
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: _height * 0.001),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}
