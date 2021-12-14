class CountdownList {
  final List<_Schedule> schedule;

  CountdownList(this.schedule);

  CountdownList.fromJson(Map<String, dynamic> json)
      : schedule = List<_Schedule>.from(
            json['schedule'].map((e) => _Schedule.fromJson(e)));

  Map<String, dynamic> toJson() =>
      {'schedule': List<_Schedule>.from(schedule.map((e) => e.toString()))};
}

class _Schedule {
  final String title;
  final int countdownDate;

  _Schedule(this.title, this.countdownDate);

  _Schedule.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        countdownDate = json['countdownDate'];
  Map<String, dynamic> toJson() =>
      {'title': title, 'countdownDate': countdownDate};
}
