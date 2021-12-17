// flutter
import 'package:flutter/material.dart';
// my day
import 'package:My_Day_app/public/schedule_request/get.dart';
import 'package:My_Day_app/schedule/schedule_form.dart';
import 'package:My_Day_app/models/schedule/schedule_model.dart';

class EditSchedule extends StatefulWidget {
  String uid;
  int scheduleNum;

  EditSchedule({this.uid, this.scheduleNum});
  @override
  State<EditSchedule> createState() =>
      _EditSchedule(this.uid, this.scheduleNum);
}

class _EditSchedule extends State<EditSchedule> {
  Future<ScheduleGet> _data;
  String _uid;
  int _scheduleNum;
  _EditSchedule(this._uid, this._scheduleNum);

  Future<ScheduleGet> getThisData() async {
    Get request =
        new Get(context: context, uid: _uid, scheduleNum: _scheduleNum);
    return request.getData();
  }

  _remindFormat(List remindData, startTime) {
    List<Duration> remindTimeList = [];
    for (String remindTime in remindData) {
      remindTimeList.add(startTime.difference(DateTime.parse(remindTime)));
    }
    return remindTimeList;
  }

  @override
  void initState() {
    super.initState();
    _data = getThisData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ScheduleGet>(
      future: _data,
      builder: (BuildContext context, AsyncSnapshot<ScheduleGet> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          String _title = data != null ? data.title : null;
          DateTime _startTime = data != null ? data.startTime : DateTime.now();
          DateTime _endTime = data != null
              ? data.endTime
              : DateTime.now().add(Duration(hours: 1));
          int _typeId = data != null ? data.typeId : null;
          String _place = data != null ? data.place : null;
          List _remindTimeList = data != null
              ? _remindFormat(data.remind['remindTime'], _startTime)
              : null;
          bool _isCountdown = data != null ? data.isCountdown : false;
          String _remark = data != null ? data.remark : null;
          return ScheduleForm(
            submitType: 'edit',
            scheduleNum: _scheduleNum,
            title: _title,
            startDateTime: _startTime,
            endDateTime: _endTime,
            type: _typeId,
            location: _place,
            remindTimeList: _remindTimeList,
            isCountdown: _isCountdown,
            remark: _remark,
          );
        } else {
          return Container(
              color: Colors.white,
              child:
                  SafeArea(child: Center(child: CircularProgressIndicator())));
        }
      },
    );
  }
}
