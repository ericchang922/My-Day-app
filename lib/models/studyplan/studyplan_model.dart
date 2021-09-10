// To parse this JSON data, do
//
//     final studyplanModel = studyplanModelFromJson(jsonString);

import 'dart:convert';

StudyplanModel studyplanModelFromJson(String str) => StudyplanModel.fromJson(json.decode(str));

String studyplanModelToJson(StudyplanModel data) => json.encode(data.toJson());

class StudyplanModel {
    StudyplanModel({
        this.creatorId,
        this.creator,
        this.isAuthority,
        this.title,
        this.date,
        this.startTime,
        this.endTime,
        this.subject,
        this.response,
    });

    String creatorId;
    String creator;
    bool isAuthority;
    String title;
    DateTime date;
    DateTime startTime;
    DateTime endTime;
    List<Subject> subject;
    bool response;

    factory StudyplanModel.fromJson(Map<String, dynamic> json) => StudyplanModel(
        creatorId: json["creatorId"],
        creator: json["creator"],
        isAuthority: json["isAuthority"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        subject: List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "creatorId": creatorId,
        "creator": creator,
        "isAuthority": isAuthority,
        "title": title,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "subject": List<dynamic>.from(subject.map((x) => x.toJson())),
        "response": response,
    };
}

class Subject {
    Subject({
        this.subjectName,
        this.subjectStart,
        this.subjectEnd,
        this.remark,
        this.noteNum,
        this.rest,
    });

    String subjectName;
    DateTime subjectStart;
    DateTime subjectEnd;
    dynamic remark;
    int noteNum;
    bool rest;

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjectName: json["subjectName"],
        subjectStart: DateTime.parse(json["subjectStart"]),
        subjectEnd: DateTime.parse(json["subjectEnd"]),
        remark: json["remark"],
        noteNum: json["noteNum"] == null ? null : json["noteNum"],
        rest: json["rest"],
    );

    Map<String, dynamic> toJson() => {
        "subjectName": subjectName,
        "subjectStart": subjectStart.toIso8601String(),
        "subjectEnd": subjectEnd.toIso8601String(),
        "remark": remark,
        "noteNum": noteNum == null ? null : noteNum,
        "rest": rest,
    };
}
