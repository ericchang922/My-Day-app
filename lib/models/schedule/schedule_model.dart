class ScheduleGet {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final Map<dynamic, dynamic> remind;
  final int typeId;
  final bool isCountdown;
  final String place;
  final String remark;

  ScheduleGet(this.title, this.startTime, this.endTime, this.remind,
      this.typeId, this.isCountdown, this.place, this.remark);

  ScheduleGet.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']),
        remind = json['remind'],
        typeId = json['typeId'],
        isCountdown = json['isCountdown'],
        place = json['place'],
        remark = json['remark'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
        'remind': remind,
        'isCountdown': isCountdown,
        'place': place,
        'remark': remark
      };
}
