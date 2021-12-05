import 'package:flutter/material.dart';

import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

const PrimaryColor = const Color(0xFFF86D67);

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ThemeWidget(),
    );
  }
}

class ThemeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThemeWidget();
}

class _ThemeWidget extends State<ThemeWidget> {
  get child => null;
  get left => null;
  bool _hasBeenPressed = false;
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);
  }

  @override
  void initState() {
    super.initState();
    _uid();
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _appBarSize = _sizing.width(5.2);

    return Scaffold(
      appBar: AppBar(
          backgroundColor:
              _hasBeenPressed ? Color(0xff29527A) : Color(0xffF86D67),
          title: Text('主題', style: TextStyle(fontSize: _appBarSize)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          )),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(
                    top: _sizing.height(1),
                    right: _sizing.height(2.8),
                    left: _sizing.height(1.8)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton.icon(
                        icon: Icon(Icons.circle_sharp,
                            color: Color(0xffF86D67), size: _sizing.width(10)),
                        label: Text(
                          '  活力紅',
                          style: TextStyle(
                              fontSize: _appBarSize, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: _sizing.width(10),
                        width: _sizing.width(5),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: _hasBeenPressed
                                  ? Colors.white
                                  : Color(0xffF86D67),
                              shape: _hasBeenPressed
                                  ? CircleBorder(
                                      side: BorderSide(color: Colors.black),
                                    )
                                  : CircleBorder(),
                            ),
                            onPressed: () async {
                              setState(() {
                                if (_hasBeenPressed = false) {
                                  _hasBeenPressed = true;
                                } else {
                                  _hasBeenPressed = false;
                                }
                              });
                            }),
                      )
                    ])),
            Container(
              margin: EdgeInsets.only(top: _sizing.height(0.1)),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: _sizing.height(1),
                    right: _sizing.height(2.8),
                    left: _sizing.height(1.8)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton.icon(
                        icon: Icon(Icons.circle_sharp,
                            color: Color(0xff29527A), size: _sizing.width(10)),
                        label: Text(
                          '  深夜藍',
                          style: TextStyle(
                              fontSize: _appBarSize, color: Colors.black),
                        ),
                        onPressed: null,
                      ),
                      SizedBox(
                          height: _sizing.width(10),
                          width: _sizing.width(5),
                          child: TextButton(
                              child: Container(),
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
                              onPressed: () async {
                                setState(() {
                                  if (_hasBeenPressed = true) {
                                    _hasBeenPressed = true;
                                  } else {
                                    _hasBeenPressed = false;
                                  }
                                });
                              }))
                    ])),
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
