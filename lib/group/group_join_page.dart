import 'package:flutter/material.dart';

Future<bool> groupJoinDialog(BuildContext context) async {
  final _groupIDController = TextEditingController();
  String _inputGroupID = '';

  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            height: 210,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "加入群組",
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 10, bottom: 20, top: 15),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/search.png',
                        width: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text('群組ID：', style: TextStyle(fontSize: 18)),
                      )
                    ],
                  ),
                ),
                Container(
                    height: 40.0,
                    margin: EdgeInsets.only(left: 20, right: 10, bottom: 33),
                    child: new TextField(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Color(0xff070707),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color(0xff7AAAD8)),
                          )),
                      controller: _groupIDController,
                      onChanged: (text) {
                        _inputGroupID = _groupIDController.text;
                      },
                    )),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            "取消",
                            style: TextStyle(color: Colors.white),
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
                          height: 50,
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30.0)),
                          ),
                          child: Text(
                            "確認",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          print(_inputGroupID);
                          Navigator.of(context).pop(true);
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