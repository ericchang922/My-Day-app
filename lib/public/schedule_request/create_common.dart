import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CreateCommon {
  BuildContext context;
  String uid;
  int groupNum;
  String title;
  String startTime = DateTime.now().toString();
  String endTime = DateTime.now().add(Duration(hours: 1)).toString();
  int typeId;
  String place;
  Map<String, dynamic> data;

  CreateCommon({
    this.context,
    this.uid,
    this.title,
    this.groupNum,
    this.startTime,
    this.endTime,
    this.typeId,
    this.place,
  }) {
    data = {
      'uid': uid,
      'groupNum': groupNum,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'typeId': typeId,
      'place': place,
    };
    Request request = Request();
    request.createCommon(context, data);
  }
}
