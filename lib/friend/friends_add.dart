import 'package:flutter/material.dart';

import 'package:My_Day_app/friend/friend_fail.dart';
import 'package:My_Day_app/public/friend_request/add.dart';
import 'package:My_Day_app/public/loadUid.dart';

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
        var screenSize = MediaQuery.of(context).size;
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(screenSize.height * 0.03))),
          contentPadding: EdgeInsets.only(top: screenSize.height * 0.02),
          content: Container(
            width: screenSize.width * 0.2,
            height: screenSize.height * 0.2459,
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
                                TextStyle(fontSize: screenSize.width * 0.041),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenSize.height * 0.02,
                            right: screenSize.height * 0.02,
                            bottom: screenSize.height * 0.02,
                            top: screenSize.height * 0.015),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/search.png',
                              width: screenSize.width * 0.05,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: screenSize.height * 0.01),
                              child: Text('好友ID：',
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.041)),
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: screenSize.height * 0.04683,
                          margin: EdgeInsets.only(
                            left: screenSize.height * 0.02,
                            right: screenSize.height * 0.02,
                            bottom: screenSize.height * 0.0384,
                          ),
                          child: new TextField(
                            style:
                                TextStyle(fontSize: screenSize.width * 0.041),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenSize.height * 0.01,
                                    vertical: screenSize.height * 0.01),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          screenSize.height * 0.01)),
                                  borderSide: BorderSide(
                                    color: Color(0xff070707),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          screenSize.height * 0.01)),
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
                          height: screenSize.height * 0.06,
                          padding: EdgeInsets.only(
                              top: screenSize.height * 0.015,
                              bottom: screenSize.height * 0.015),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(screenSize.height * 0.03),
                            ),
                          ),
                          child: Text(
                            "取消",
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
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
                          height: screenSize.height * 0.06,
                          padding: EdgeInsets.only(
                              top: screenSize.height * 0.015,
                              bottom: screenSize.height * 0.015),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(screenSize.height * 0.03)),
                          ),
                          child: Text(
                            "確認",
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
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
