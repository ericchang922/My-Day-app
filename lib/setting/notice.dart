import 'package:My_Day_app/public/sizing.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/models/setting/get_notice.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/setting_request/get_notice.dart';
import 'package:My_Day_app/public/setting_request/notice.dart';
import 'package:My_Day_app/setting/play_together_invite.dart';

const PrimaryColor = const Color(0xFFF86D67);

class NoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Notice();
  }
}

class _Notice extends State {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getNoticeRequest();
    if (_notice == null) {
      setState(() {
        _isCheckSchedule = false;
        _isCheckCountdown = false;
        _isCheckGroup = false;
      });
    } else {
      setState(() {
        _isCheckSchedule = _notice.scheduleNotice;
        _isCheckCountdown = _notice.countdownNotice;
        _isCheckGroup = _notice.groupNotice;
      });
    }
  }
  // 載入 uid 之後才可執行 取得資料

  bool _isCheckSchedule;
  bool _isCheckCountdown;
  bool _isCheckGroup;

  get child => null;
  get left => null;

  GetNoticeModel _notice;

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _getNoticeRequest() async {
    GetNoticeModel _request =
        await GetNotice(context: context, uid: uid).getData();

    setState(() {
      _notice = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _appBarSize = _sizing.width(5.2);
    double _bottomHeight = _sizing.height(7);

    _submit() async {
      Notice notice = Notice(
          uid: uid,
          isSchedule: _isCheckSchedule,
          isCountdown: _isCheckCountdown,
          isGroup: _isCheckGroup);

      return await notice.getIsError();
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
                  EdgeInsets.only(top: _sizing.height(1), left: _sizing.height(1.8)),
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
                          value: _isCheckSchedule,
                          onChanged: (value) async {
                            setState(() {
                              _isCheckSchedule = value;
                            });
                            if (await _submit()) {
                              _isCheckSchedule = false;
                            }
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Color(0xffF86D67),
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: _sizing.height(0.1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: _sizing.height(1), left: _sizing.height(1.8)),
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
                            setState(() {
                              _isCheckCountdown = value;
                            });
                            if (await _submit()) {
                              _isCheckCountdown = false;
                            }
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Color(0xffF86D67),
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: _sizing.height(0.1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: _sizing.height(1), left: _sizing.height(1.8)),
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
                          value: _isCheckGroup,
                          onChanged: (value) async {
                            setState(() {
                              _isCheckGroup = value;
                            });
                            if (await _submit()) {
                              _isCheckGroup = false;
                            }
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Color(0xffF86D67),
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: _sizing.height(0.1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: _sizing.height(1), left: _sizing.height(1.8)),
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
              margin: EdgeInsets.only(top: _sizing.height(0.1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ],
        ),
      ),
    );
  }
}
