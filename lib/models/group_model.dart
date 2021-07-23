// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
    GroupModel({
        this.groupContent,
    });

    List<GroupContent> groupContent;

    factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        groupContent: List<GroupContent>.from(json["groupContent"].map((x) => GroupContent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "groupContent": List<dynamic>.from(groupContent.map((x) => x.toJson())),
    };
}

class GroupContent {
    GroupContent({
        this.groupId,
        this.title,
        this.typeId,
        this.peopleCount,
    });

    int groupId;
    String title;
    int typeId;
    int peopleCount;

    factory GroupContent.fromJson(Map<String, dynamic> json) => GroupContent(
        groupId: json["groupID"],
        title: json["title"],
        typeId: json["typeId"],
        peopleCount: json["peopleCount"],
    );

    Map<String, dynamic> toJson() => {
        "groupID": groupId,
        "title": title,
        "typeId": typeId,
        "peopleCount": peopleCount,
    };
}
