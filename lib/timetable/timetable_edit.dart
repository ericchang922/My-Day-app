import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimetableEdit();
  }
}

class TimetableEdit extends State {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('編輯課表', style: TextStyle(fontSize: 20)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          }
        )
      )
    );
  }
}