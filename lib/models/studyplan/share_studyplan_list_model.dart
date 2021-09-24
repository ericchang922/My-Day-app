// To parse this JSON data, do
//
//     final shareStudyplanListModel = shareStudyplanListModelFromJson(jsonString);

import 'dart:convert';

ShareStudyplanListModel shareStudyplanListModelFromJson(String str) => ShareStudyplanListModel.fromJson(json.decode(str));

String shareStudyplanListModelToJson(ShareStudyplanListModel data) => json.encode(data.toJson());

class ShareStudyplanListModel {
    ShareStudyplanListModel({
        this.studyplan,
        this.response,
    });

    List<Studyplan> studyplan;
    bool response;

    factory ShareStudyplanListModel.fromJson(Map<String, dynamic> json) => ShareStudyplanListModel(
        studyplan: List<Studyplan>.from(json["studyplan"].map((x) => Studyplan.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "studyplan": List<dynamic>.from(studyplan.map((x) => x.toJson())),
        "response": response,
    };
}

class Studyplan {
    Studyplan({
        this.studyplanNum,
        this.creatorId,
        this.creator,
        this.title,
        this.date,
        this.startTime,
        this.endTime,
    });

    int studyplanNum;
    String creatorId;
    String creator;
    String title;
    DateTime date;
    DateTime startTime;
    DateTime endTime;

    factory Studyplan.fromJson(Map<String, dynamic> json) => Studyplan(
        studyplanNum: json["studyplanNum"],
        creatorId: json["creatorId"],
        creator: json["creator"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
    );

    Map<String, dynamic> toJson() => {
        "studyplanNum": studyplanNum,
        "creatorId": creatorId,
        "creator": creator,
        "title": title,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
    };
}
