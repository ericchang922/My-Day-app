import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableImprotPastPage extends StatefulWidget {
  @override
  TimetableImportPast createState() => new TimetableImportPast();
}

class TimetableImportPast extends State<TimetableImprotPastPage> {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('110年　第一學期', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
