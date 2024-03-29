import 'package:flutter/material.dart';

import 'package:My_Day_app/public/sizing.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableReceivePreviewPage extends StatefulWidget {
  @override
  TimetableReceivePreview createState() => new TimetableReceivePreview();
}

class TimetableReceivePreview extends State<TimetableReceivePreviewPage> {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('110年　第一學期', style: TextStyle(fontSize: 20)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(42, 106, 0, 0),
            child: Column(
              children: [
                Row(
                  children: [],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).bottomAppBarColor,
        child: SafeArea(
          top: false,
          child: BottomAppBar(
            elevation: 0,
            child: Row(children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: _sizing.height(7),
                  child: RawMaterialButton(
                      elevation: 0,
                      child: Image.asset(
                        'assets/images/cancel.png',
                        width: _sizing.width(5),
                      ),
                      fillColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ), // 取消按鈕
              Expanded(
                child: SizedBox(
                  height: _sizing.height(7),
                  child: RawMaterialButton(
                      elevation: 0,
                      child: Image.asset(
                        'assets/images/confirm.png',
                        width: _sizing.width(5),
                      ),
                      fillColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
