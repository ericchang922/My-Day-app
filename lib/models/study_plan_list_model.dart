// To parse this JSON data, do
//
//     final groupStudyPlanListModel = groupStudyPlanListModelFromJson(jsonString);

import 'dart:convert';

StudyPlanListModel groupStudyPlanListModelFromJson(String str) => StudyPlanListModel.fromJson(json.decode(str));

String groupStudyPlanListModelToJson(StudyPlanListModel data) => json.encode(data.toJson());

class StudyPlanListModel {
    StudyPlanListModel({
        this.studyplan,
    });

    List<Studyplan> studyplan;

    factory StudyPlanListModel.fromJson(Map<String, dynamic> json) => StudyPlanListModel(
        studyplan: List<Studyplan>.from(json["studyplan"].map((x) => Studyplan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "studyplan": List<dynamic>.from(studyplan.map((x) => x.toJson())),
    };
}

class Studyplan {
    Studyplan({
        this.studyplanNum,
        this.title,
        this.date,
        this.startTime,
        this.endTime,
    });

    int studyplanNum;
    String title;
    DateTime date;
    DateTime startTime;
    DateTime endTime;

    factory Studyplan.fromJson(Map<String, dynamic> json) => Studyplan(
        studyplanNum: json["studyplanNum"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
    );

    Map<String, dynamic> toJson() => {
        "studyplanNum": studyplanNum,
        "title": title,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
    };
}
