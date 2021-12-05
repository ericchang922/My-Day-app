import 'dart:convert';

GetCommonScheduleModel getCommonScheduleModelFromJson(String str) => GetCommonScheduleModel.fromJson(json.decode(str));

String getCommonScheduleModelToJson(GetCommonScheduleModel data) => json.encode(data.toJson());

class GetCommonScheduleModel {
    GetCommonScheduleModel({
        this.title,
        this.startTime,
        this.endTime,
        this.typeName,
        this.place,
        this.response,
    });

    String title;
    DateTime startTime;
    DateTime endTime;
    String typeName;
    String place;
    bool response;

    factory GetCommonScheduleModel.fromJson(Map<String, dynamic> json) => GetCommonScheduleModel(
        title: json["title"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        typeName: json["typeName"],
        place: json["place"],
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "typeName": typeName,
        "place": place,
        "response": response,
    };
}
