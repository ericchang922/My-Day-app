import 'package:My_Day_app/timetable/timetable_receive.dart';
import 'package:flutter/material.dart';

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
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: RawMaterialButton(
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/cancel.png',
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    fillColor: Theme.of(context).primaryColorLight,
                     onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TimetableReceivePage()));
                      }
                  ),
                ),
              ), // 取消按鈕
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: RawMaterialButton(
                      elevation: 0,
                      child: Image.asset(
                        'assets/images/confirm.png',
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      fillColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TimetableReceivePage()));
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
