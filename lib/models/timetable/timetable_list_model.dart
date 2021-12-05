import 'dart:convert';

TimetableListModel timetableListModelFromJson(String str) => TimetableListModel.fromJson(json.decode(str));

String timetableListModelToJson(TimetableListModel data) => json.encode(data.toJson());

class TimetableListModel {
    TimetableListModel({
        this.timetable,
        this.response,
    });

    List<Timetable> timetable;
    bool response;

    factory TimetableListModel.fromJson(Map<String, dynamic> json) => TimetableListModel(
        timetable: List<Timetable>.from(json["timetable"].map((x) => Timetable.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "timetable": List<dynamic>.from(timetable.map((x) => x.toJson())),
        "response": response,
    };
}

class Timetable {
    Timetable({
        this.schoolYear,
        this.semester,
        this.timetableNo,
    });

    String schoolYear;
    String semester;
    int timetableNo;

    factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        schoolYear: json["schoolYear"],
        semester: json["semester"],
        timetableNo: json["timetableNo"],
    );

    Map<String, dynamic> toJson() => {
        "schoolYear": schoolYear,
        "semester": semester,
        "timetableNo": timetableNo,
    };
}
