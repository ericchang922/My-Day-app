import 'package:flutter/material.dart';

import 'package:My_Day_app/friend/friend_fail.dart';
import 'package:My_Day_app/public/friend_request/add.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

Future<bool> friendsAddDialog(BuildContext context) async {
  final fid = TextEditingController();
  String _alertTitle = '加入失敗';
  String _alertTxt = '請確認是否有填寫欄位';
  String id = await loadUid();

  _submit() async {
    String uid = id;
    String friendId = fid.text;

    var submitWidget;
    _submitWidgetfunc() async {
      return AddFriend(uid: uid, friendId: friendId);
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
        Sizing _sizing = Sizing(context);
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(_sizing.height(3)))),
          contentPadding: EdgeInsets.only(top: _sizing.height(2)),
          content: Container(
            width: _sizing.width(20),
            height: _sizing.height(24.59),
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
                            "加好友",
                            style:
                                TextStyle(fontSize: _sizing.width(4.1)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: _sizing.height(2),
                            right: _sizing.height(2),
                            bottom: _sizing.height(2),
                            top: _sizing.height(1.5)),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/search.png',
                              width: _sizing.width(5),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: _sizing.height(1)),
                              child: Text('好友ID：',
                                  style: TextStyle(
                                      fontSize: _sizing.width(4.1))),
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: _sizing.height(4.683),
                          margin: EdgeInsets.only(
                            left: _sizing.height(2),
                            right: _sizing.height(2),
                            bottom: _sizing.height(3.84),
                          ),
                          child: new TextField(
                            style:
                                TextStyle(fontSize: _sizing.width(4.1)),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: _sizing.height(1),
                                    vertical: _sizing.height(1)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          _sizing.height(1))),
                                  borderSide: BorderSide(
                                    color: Color(0xff070707),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          _sizing.height(1))),
                                  borderSide:
                                      BorderSide(color: Color(0xff7AAAD8)),
                                )),
                            controller: fid,
                          )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: _sizing.height(6),
                          padding: EdgeInsets.only(
                              top: _sizing.height(1.5),
                              bottom: _sizing.height(1.5)),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(_sizing.height(3)),
                            ),
                          ),
                          child: Text(
                            "取消",
                            style: TextStyle(
                                fontSize: _sizing.width(3.5),
                                color: Colors.white),
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
                          height: _sizing.height(6),
                          padding: EdgeInsets.only(
                              top: _sizing.height(1.5),
                              bottom: _sizing.height(1.5)),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(_sizing.height(3))),
                          ),
                          child: Text(
                            "確認",
                            style: TextStyle(
                                fontSize: _sizing.width(3.5),
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () async {
                          if (fid.text.isNotEmpty) {
                            if (await _submit() != true) {
                              Navigator.of(context).pop(true);
                            }
                          } else {
                            await friendfailDialog(
                                context, _alertTitle, _alertTxt);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
