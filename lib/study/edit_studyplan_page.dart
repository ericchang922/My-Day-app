import 'package:flutter/material.dart';

import 'package:My_Day_app/models/studyplan/studyplan_model.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/studyplan_request/get.dart';
import 'package:My_Day_app/study/studyplan_form.dart';

class EditStudyPlanPage extends StatefulWidget {
  int studyplanNum;
  int groupNum;
  EditStudyPlanPage(this.studyplanNum, this.groupNum);

  @override
  _EditStudyPlanPage createState() =>
      new _EditStudyPlanPage(studyplanNum, groupNum);
}

class _EditStudyPlanPage extends State<EditStudyPlanPage> {
  int studyplanNum;
  int groupNum;
  _EditStudyPlanPage(this.studyplanNum, this.groupNum);

  StudyplanModel _data;

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getStudyPlanRequest();
  }

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _getStudyPlanRequest() async {
    StudyplanModel _request =
        await Get(context: context, uid: uid, studyplanNum: studyplanNum)
            .getData();

    setState(() {
      _data = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_data != null) {
      String title = _data.title;
      DateTime date = _data.date;
      DateTime startDateTime = DateTime(date.year, date.month, date.day,
          _data.startTime.hour, _data.startTime.minute);
      DateTime endDateTime = DateTime(date.year, date.month, date.day,
          _data.endTime.hour, _data.endTime.minute);
      bool isAuthority = _data.isAuthority;
      List<List> subjectTimeList = [];
      List subjectNameList = [];
      List remarkList = [];
      List noteNumList = [];
      List restList = [];
      bool isCreate = _data.creatorId == uid ? true : false;

      for (int i = 0; i < _data.subject.length; i++) {
        DateTime startTime = DateTime(
            date.year,
            date.month,
            date.day,
            _data.subject[i].subjectStart.hour,
            _data.subject[i].subjectStart.minute);
        DateTime endTime = DateTime(
            date.year,
            date.month,
            date.day,
            _data.subject[i].subjectEnd.hour,
            _data.subject[i].subjectEnd.minute);
        String subjectName = _data.subject[i].subjectName;
        String remark = _data.subject[i].remark;
        int noteNum = _data.subject[i].noteNum;
        bool rest = _data.subject[i].rest;
        subjectTimeList.add([startTime, endTime]);
        subjectNameList.add(subjectName);
        remarkList.add(remark);
        noteNumList.add(noteNum);
        restList.add(rest);
      }
      if (_data.creatorId == uid) isCreate = true;

      return StudyPlanForm(
          studyplanNum: studyplanNum,
          groupNum: groupNum,
          submitType: 'edit_studyplan',
          title: title,
          date: date,
          startDateTime: startDateTime,
          endDateTime: endDateTime,
          isAuthority: isAuthority,
          subjectTimeList: subjectTimeList,
          subjectNameList: subjectNameList,
          remarkList: remarkList,
          noteNumList: noteNumList,
          restList: restList,
          isCreate: isCreate);
    } else {
      return Container(
          color: Colors.white,
          child: SafeArea(child: Center(child: CircularProgressIndicator())));
    }
  }
}
