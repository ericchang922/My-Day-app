// To parse this JSON data, do
//
//     final groupLogModel = groupLogModelFromJson(jsonString);

import 'dart:convert';

GroupLogModel groupLogModelFromJson(String str) => GroupLogModel.fromJson(json.decode(str));

String groupLogModelToJson(GroupLogModel data) => json.encode(data.toJson());

class GroupLogModel {
    GroupLogModel({
        this.groupContent,
        this.response,
    });

    List<GroupContent> groupContent;
    bool response;

    factory GroupLogModel.fromJson(Map<String, dynamic> json) => GroupLogModel(
        groupContent: List<GroupContent>.from(json["groupContent"].map((x) => GroupContent.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "groupContent": List<dynamic>.from(groupContent.map((x) => x.toJson())),
        "response": response,
    };
}

class GroupContent {
    GroupContent({
        this.doTime,
        this.name,
        this.logContent,
    });

    DateTime doTime;
    String name;
    String logContent;

    factory GroupContent.fromJson(Map<String, dynamic> json) => GroupContent(
        doTime: DateTime.parse(json["doTime"]),
        name: json["name"],
        logContent: json["logContent"],
    );

    Map<String, dynamic> toJson() => {
        "doTime": doTime.toIso8601String(),
        "name": name,
        "logContent": logContent,
    };
}
