import 'package:flutter/material.dart';

import 'package:My_Day_app/public/group_request/member_status.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

Future<bool> groupJoinDialog(BuildContext context) async {
  Sizing _sizing = Sizing(context);

  double _borderRadius = _sizing.height(3);
  double _textLBR = _sizing.height(2);
  double _iconWidth = _sizing.width(5);
  double _textFied = _sizing.height(4.5);
  double _inkwellH = _sizing.height(6);

  double _pSize = _sizing.height(2.3);
  double _subtitleSize = _sizing.height(2);

  Color _bule = Color(0xff7AAAD8);
  Color _textFiedBorder = Color(0xff707070);
  Color _color = Theme.of(context).primaryColor;
  Color _light = Theme.of(context).primaryColorLight;

  final _groupIDController = TextEditingController();
  String _groupNum = '';

  _submit() async {
    int statusId = 1;
    String uid = await loadUid();
    var submitWidget;

    print('group_join_page -- join group: ${int.parse(_groupNum)}');
    _submitWidgetfunc() async {
      return MemberStatus(
          context: context,
          uid: uid,
          groupNum: int.parse(_groupNum),
          statusId: statusId);
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
          contentPadding: EdgeInsets.only(top: _sizing.height(2)),
          content: Container(
            width: _sizing.width(20),
            height: _sizing.height(25),
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
                              top: _sizing.height(1.5)),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/search.png',
                                width: _iconWidth,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: _sizing.height(1)),
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
                              bottom: _sizing.height(1.5),
                            ),
                            child: new TextField(
                              style: TextStyle(fontSize: _pSize),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: _sizing.height(1),
                                      vertical: _sizing.height(1)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_sizing.height(1))),
                                    borderSide: BorderSide(
                                      color: _textFiedBorder,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_sizing.height(1))),
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
                                top: _sizing.height(1.5),
                                bottom: _sizing.height(1.5)),
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
                                top: _sizing.height(1.5),
                                bottom: _sizing.height(1.5)),
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
