import 'package:flutter/material.dart';

import 'package:My_Day_app/public/group_request/member_status.dart';
import 'package:My_Day_app/public/loadUid.dart';

Future<bool> groupJoinDialog(BuildContext context) async {
  Size size = MediaQuery.of(context).size;
  double _width = size.width;
  double _height = size.height;

  double _borderRadius = _height * 0.03;
  double _textLBR = _height * 0.02;
  double _iconWidth = _width * 0.05;
  double _textFied = _height * 0.045;
  double _inkwellH = _height * 0.06;

  double _pSize = _height * 0.023;
  double _subtitleSize = _height * 0.02;

  Color _bule = Color(0xff7AAAD8);
  Color _textFiedBorder = Color(0xff707070);
  Color _color = Theme.of(context).primaryColor;
  Color _light = Theme.of(context).primaryColorLight;

  final _groupIDController = TextEditingController();
  String _groupNum = '';

  _submit() async {
    int statusId = 1;
    String uid = 'lili123';
    var submitWidget;
    print(int.parse(_groupNum));
    _submitWidgetfunc() async {
      return MemberStatus(
          uid: uid, groupNum: int.parse(_groupNum), statusId: statusId);
    }

    submitWidget = await _submitWidgetfunc();
    if (await submitWidget.getIsError())
      return true;
    else
      return false;
  }

  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
          contentPadding: EdgeInsets.only(top: _height * 0.02),
          content: Container(
            width: _width * 0.2,
            height: _height * 0.25,
            child: GestureDetector(
              // 點擊空白處釋放焦點
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "加入群組",
                              style: TextStyle(fontSize: _pSize),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: _textLBR,
                              right: _textLBR,
                              bottom: _textLBR,
                              top: _height * 0.015),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/search.png',
                                width: _iconWidth,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: _height * 0.01),
                                child: Text('群組ID：',
                                    style: TextStyle(fontSize: _pSize)),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: _textFied,
                            margin: EdgeInsets.only(
                              left: _textLBR,
                              right: _textLBR,
                              bottom: _height * 0.015,
                            ),
                            child: new TextField(
                              style: TextStyle(fontSize: _pSize),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: _height * 0.01,
                                      vertical: _height * 0.01),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_height * 0.01)),
                                    borderSide: BorderSide(
                                      color: _textFiedBorder,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_height * 0.01)),
                                    borderSide: BorderSide(color: _bule),
                                  )),
                              controller: _groupIDController,
                              onChanged: (text) {
                                _groupNum = _groupIDController.text;
                              },
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: _inkwellH,
                            padding: EdgeInsets.only(
                                top: _height * 0.015, bottom: _height * 0.015),
                            decoration: BoxDecoration(
                              color: _light,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(_borderRadius),
                              ),
                            ),
                            child: Text(
                              "取消",
                              style: TextStyle(
                                  fontSize: _subtitleSize, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: _inkwellH,
                            padding: EdgeInsets.only(
                                top: _height * 0.015, bottom: _height * 0.015),
                            decoration: BoxDecoration(
                              color: _color,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(_borderRadius)),
                            ),
                            child: Text(
                              "確認",
                              style: TextStyle(
                                  fontSize: _subtitleSize, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () async {
                            if (await _submit() != true) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
