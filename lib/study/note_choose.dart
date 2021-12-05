import 'package:flutter/material.dart';

import 'package:My_Day_app/public/sizing.dart';

const PrimaryColor = const Color(0xFFF86D67);

class ReadPlanChoose extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SwitchDemo(),
    ));
  }
}

class SwitchDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Theme();
}

class Theme extends State {
  get child => null;
  get left => null;
  bool _hasBeenPressed = false;
  bool hasBeenPressed = false;
  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _iconWidth = _sizing.width(5);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('選擇筆記', style: TextStyle(fontSize: 20)),
                leading: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            body: ListView(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 30, right: 20, top: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '國文 1~3 課',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          SizedBox(
                            height: 40,
                            width: 20,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: _hasBeenPressed
                                      ? Color(0xffF86D67)
                                      : Colors.white,
                                  shape: _hasBeenPressed
                                      ? CircleBorder()
                                      : CircleBorder(
                                          side: BorderSide(color: Colors.black),
                                        ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _hasBeenPressed = !_hasBeenPressed;
                                  });
                                }),
                          )
                        ])),
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  color: Color(0xffE3E3E3),
                  constraints: BoxConstraints.expand(height: 1.0),
                ),
                Container(
                    margin: EdgeInsets.only(left: 30, right: 20, top: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '數學 1~3 課',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          SizedBox(
                            height: 40,
                            width: 20,
                            child: TextButton(
                                child: Container(),
                                style: TextButton.styleFrom(
                                  backgroundColor: hasBeenPressed
                                      ? Color(0xffF86D67)
                                      : Colors.white,
                                  shape: hasBeenPressed
                                      ? CircleBorder()
                                      : CircleBorder(
                                          side: BorderSide(color: Colors.black),
                                        ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    hasBeenPressed = !hasBeenPressed;
                                  });
                                }),
                          )
                        ])),
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  color: Color(0xffE3E3E3),
                  constraints: BoxConstraints.expand(height: 1.0),
                ),
              ],
            ),
            bottomNavigationBar: Container(
                child: Row(children: <Widget>[
              Expanded(
                child: SizedBox(
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Theme.of(context).primaryColorLight,
                      ),
                      child: Image.asset(
                        'assets/images/cancel.png',
                        width: _iconWidth,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Image.asset(
                      'assets/images/confirm.png',
                      width: _iconWidth,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              )
            ]))));
  }

  static of(BuildContext context) {}
}
