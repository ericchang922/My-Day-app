// To parse this JSON data, do
//
//     final commonScheduleListModel = commonScheduleListModelFromJson(jsonString);

import 'dart:convert';

CommonScheduleListModel commonScheduleListModelFromJson(String str) => CommonScheduleListModel.fromJson(json.decode(str));

String commonScheduleListModelToJson(CommonScheduleListModel data) => json.encode(data.toJson());

class CommonScheduleListModel {
    CommonScheduleListModel({
        this.pastSchedule,
        this.futureSchedule,
        this.response,
    });

    List<CommonScheduleList> pastSchedule;
    List<CommonScheduleList> futureSchedule;
    bool response;

    factory CommonScheduleListModel.fromJson(Map<String, dynamic> json) => CommonScheduleListModel(
        pastSchedule: List<CommonScheduleList>.from(json["pastSchedule"].map((x) => CommonScheduleList.fromJson(x))),
        futureSchedule: List<CommonScheduleList>.from(json["futureSchedule"].map((x) => CommonScheduleList.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "pastSchedule": List<dynamic>.from(pastSchedule.map((x) => x.toJson())),
        "futureSchedule": List<dynamic>.from(futureSchedule.map((x) => x.toJson())),
        "response": response,
    };
}

class CommonScheduleList {
    CommonScheduleList({
        this.scheduleNum,
        this.title,
        this.startTime,
        this.endTime,
        this.typeName,
    });

    int scheduleNum;
    String title;
    DateTime startTime;
    DateTime endTime;
    String typeName;

    factory CommonScheduleList.fromJson(Map<String, dynamic> json) => CommonScheduleList(
        scheduleNum: json["scheduleNum"],
        title: json["title"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        typeName: json["typeName"],
    );

    Map<String, dynamic> toJson() => {
        "scheduleNum": scheduleNum,
        "title": title,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "typeName": typeName,
    };
}
