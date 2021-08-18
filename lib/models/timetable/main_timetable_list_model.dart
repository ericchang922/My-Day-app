class MainTimetableListGet {
  List<Timetable> timetable;

  MainTimetableListGet({this.timetable});

  MainTimetableListGet.fromJson(Map<String, dynamic> json)
      : timetable = List<Timetable>.from(
            json['timetable'].map((e) => Timetable.fromJson(e)));

  Map<String, dynamic> toJson() =>
      {'timetable': List<Timetable>.from(timetable.map((e) => e.toJson))};
}

class Timetable {
  String schoolYear;
  String semester;
  DateTime startDate;
  DateTime endDate;
  List subject;

  Timetable(
      {this.schoolYear,
      this.semester,
      this.startDate,
      this.endDate,
      this.subject});

  Timetable.fromJson(Map<String, dynamic> json)
      : schoolYear = json['schoolYear'],
        semester = json['semester'],
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        subject = List<Subject>.from(json['subject']);

  Map<String, dynamic> toJson() => {
        'schoolYear': schoolYear,
        'semester': semester,
        'startDate': startDate,
        'endDate': endDate,
        'subject': List<Subject>.from(subject.map((e) => e.toJson))
      };
}

class Subject {
  String subjectName;
  DateTime startTime;
  DateTime endTime;
  String week;
  int section;

  Subject(
      {this.subjectName,
      this.startTime,
      this.endTime,
      this.week,
      this.section});

  Subject.fromJson(Map<String, dynamic> json)
      : subjectName = json['subjectName'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        week = json['week'],
        section = json['section'];
  Map<String, dynamic> toJson() => {
        'subjectName': subjectName,
        'startTime': startTime,
        'endTime': endTime,
        'week': week,
        'section': section,
      };
}
