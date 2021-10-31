class SectionTime {
  final List<_Timetable> timetable;

  SectionTime(this.timetable);

  SectionTime.fromJson(Map<String, dynamic> json)
      : timetable = List<_Timetable>.from(
            json['timetable'].map((e) => _Timetable.fromJson(e)));

  Map<String, dynamic> toJson() =>
      {'timetable': List<_Timetable>.from(timetable.map((e) => e.toString()))};
}

class _Timetable {
  final String semester;
  final DateTime startDate;
  final DateTime endDate;
  final List<_Subject> subject;

  _Timetable(this.semester, this.startDate, this.endDate, this.subject);

  _Timetable.fromJson(Map<String, dynamic> json)
      : semester = json['semester'],
        startDate = DateTime.parse('${json['startDate']}'),
        endDate = DateTime.parse('${json['endDate']}'),
        subject = List<_Subject>.from(
            json['subject'].map((e) => _Subject.fromJson(e)));

  Map<String, dynamic> toJson() =>
      {'subject': List<_Subject>.from(subject.map((e) => e.toString()))};
}

class _Subject {
  final Duration startTime;
  final Duration endTime;

  _Subject(this.startTime, this.endTime);

  _Subject.fromJson(Map<String, dynamic> json)
      : startTime = Duration(
            hours: int.parse(json['startTime'].split(':')[0]),
            minutes: int.parse(json['startTime'].split(':')[1])),
        endTime = Duration(
            hours: int.parse(json['endTime'].split(':')[0]),
            minutes: int.parse(json['endTime'].split(':')[1]));
  Map<String, dynamic> toJson() => {'startTime': startTime, 'endTime': endTime};
}

// {
//     "timetable": [
//         {
//             "semester": "100-1",
//             "startDate": "2021-09-24",
//             "endDate": "2022-01-22",
//             "subject": [
//                 {
//                     "startTime": "08:10:00",
//                     "endTime": "09:00:00"
//                 },
//                 {
//                     "startTime": "09:10:00",
//                     "endTime": "10:00:00"
//                 },
//                 {
//                     "startTime": "10:10:00",
//                     "endTime": "11:00:00"
//                 },
//                 {
//                     "startTime": "11:10:00",
//                     "endTime": "12:00:00"
//                 }
//             ]
//         },
//         {
//             "semester": "100-2",
//             "startDate": "2021-09-24",
//             "endDate": "2022-01-22",
//             "subject": [
//                 {
//                     "startTime": "08:10:00",
//                     "endTime": "09:00:00"
//                 },
//                 {
//                     "startTime": "09:10:00",
//                     "endTime": "10:00:00"
//                 }
//             ]
//         }
//     ],
//     "response": true
// }