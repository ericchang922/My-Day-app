class ScheduleGetList {
  final List<_Schedule> schedule;

  ScheduleGetList(this.schedule);

  ScheduleGetList.fromJson(Map<String, dynamic> json)
      : schedule =
            List<_Schedule>.from(json['schedule'].map((e) => e.fromJson));

  Map<String, dynamic> toJson() =>
      {'schedule': List<_Schedule>.from(schedule.map((e) => e.toString()))};
}

class _Schedule {
  final int scheduleNum;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final int typeId;

  _Schedule(
      this.scheduleNum, this.title, this.startTime, this.endTime, this.typeId);

  _Schedule.fromJson(Map<String, dynamic> json)
      : scheduleNum = json['scheduleNum'],
        title = json['title'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']),
        typeId = json['typeId'];

  Map<String, dynamic> toJson() => {
        'scheduleNum': scheduleNum,
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
        'typeId': typeId
      };
}
