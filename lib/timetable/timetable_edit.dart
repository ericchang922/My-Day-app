import 'package:My_Day_app/timetable/timetable_edit_popup.dart';
import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableEditPage extends StatefulWidget {
  @override
  TimetableEdit createState() => new TimetableEdit();
}

class TimetableEdit extends State<TimetableEditPage> {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('110年　第一學期', style: TextStyle(fontSize: 20)),
        actions: [editPopMenu(context)],
      ),
    );
  }
}
