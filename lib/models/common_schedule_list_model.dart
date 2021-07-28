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

    List<Schedule> pastSchedule;
    List<Schedule> futureSchedule;
    bool response;

    factory CommonScheduleListModel.fromJson(Map<String, dynamic> json) => CommonScheduleListModel(
        pastSchedule: List<Schedule>.from(json["pastSchedule"].map((x) => Schedule.fromJson(x))),
        futureSchedule: List<Schedule>.from(json["futureSchedule"].map((x) => Schedule.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "pastSchedule": List<dynamic>.from(pastSchedule.map((x) => x.toJson())),
        "futureSchedule": List<dynamic>.from(futureSchedule.map((x) => x.toJson())),
        "response": response,
    };
}

class Schedule {
    Schedule({
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

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
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
