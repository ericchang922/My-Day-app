class Timetable {
  final String school;
  final String schoolYear;
  final String semester;
  final DateTime startDate;
  final DateTime endDate;
  final List<_Subject> subject;

  Timetable(this.school, this.schoolYear, this.semester, this.startDate,
      this.endDate, this.subject);

  Timetable.fromJson(Map<String, dynamic> json)
      : school = json['school'],
        schoolYear = json['schoolYear'],
        semester = json['semester'],
        startDate = DateTime.parse('${json['startDate']}z'),
        endDate = DateTime.parse('${json['endDate']}z'),
        subject = List<_Subject>.from(
            json['subject'].map((e) => _Subject.fromJson(e)));

  Map<String, dynamic> toJson() => {
        'school': school,
        'schoolYear': schoolYear,
        'semester': semester,
        'startDate': startDate,
        'endDate': endDate,
        'subject': subject
      };
}

class _Subject {
  final String subjectName;
  final Duration startTime;
  final Duration endTime;
  final String week;
  final int section;

  _Subject(
      this.subjectName, this.startTime, this.endTime, this.week, this.section);

  _Subject.fromJson(Map<String, dynamic> json)
      : subjectName = json['subjectName'],
        startTime = Duration(
            hours: int.parse(json['startTime'].split(':')[0]),
            minutes: int.parse(json['startTime'].split(':')[1])),
        endTime = Duration(
            hours: int.parse(json['endTime'].split(':')[0]),
            minutes: int.parse(json['endTime'].split(':')[1])),
        week = json['week'],
        section = json['section'];

  Map<String, dynamic> toJson() => {
        'subjectName': subjectName,
        'startTime': startTime,
        'endTime': endTime,
        'week': week,
        'section': section
      };
}


// {
//     "timetable": {
//         "school": "北商",
//         "schoolYear": "109",
//         "semester": "1",
//         "startDate": "2021-09-24",
//         "endDate": "2022-01-22",
//         "subject": [
//             {
//                 "subjectName": "日文",
//                 "startTime": "08:10:00",
//                 "endTime": "09:00:00",
//                 "week": "星期三",
//                 "section": 1
//             },
//             {
//                 "subjectName": "數學",
//                 "startTime": "09:10:00",
//                 "endTime": "10:00:00",
//                 "week": "星期三",
//                 "section": 2
//             },
//             {
//                 "subjectName": "日文",
//                 "startTime": "08:10:00",
//                 "endTime": "09:00:00",
//                 "week": "星期四",
//                 "section": 1
//             },
//             {
//                 "subjectName": "數學",
//                 "startTime": "09:10:00",
//                 "endTime": "10:00:00",
//                 "week": "星期四",
//                 "section": 2
//             }
//         ]
//     },
//     "response": true
// }