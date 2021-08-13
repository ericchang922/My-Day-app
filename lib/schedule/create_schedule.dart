import 'package:My_Day_app/schedule/schedule_form.dart';
import 'package:flutter/material.dart';

class CreateSchedule extends StatefulWidget {
  @override
  State<CreateSchedule> createState() => _CreateSchedule();
}

class _CreateSchedule extends State<CreateSchedule> {
  @override
  Widget build(BuildContext context) {
    return ScheduleForm();
  }
}
