import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class ThemePage extends StatelessWidget {
  // This widget is the root of your application.
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
  String id = 'lili123';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;
    double _appBarSize = _width * 0.052;

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
                    top: _height * 0.01,
                    right: _height * 0.028,
                    left: _height * 0.018),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton.icon(
                        icon: Icon(Icons.circle_sharp,
                            color: Color(0xffF86D67), size: _width * 0.1),
                        label: Text(
                          '  活力紅',
                          style: TextStyle(
                              fontSize: _appBarSize, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: _width * 0.1,
                        width: _width * 0.05,
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
              margin: EdgeInsets.only(top: _height * 0.001),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: _height * 0.01,
                    right: _height * 0.028,
                    left: _height * 0.018),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton.icon(
                        icon: Icon(Icons.circle_sharp,
                            color: Color(0xff29527A), size: _width * 0.1),
                        label: Text(
                          '  深夜藍',
                          style: TextStyle(
                              fontSize: _appBarSize, color: Colors.black),
                        ),
                        onPressed: null,
                      ),
                      SizedBox(
                          height: _width * 0.1,
                          width: _width * 0.05,
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
