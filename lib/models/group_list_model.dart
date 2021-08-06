// To parse this JSON data, do
//
//     final groupListModel = groupListModelFromJson(jsonString);

import 'dart:convert';

GroupListModel groupListModelFromJson(String str) => GroupListModel.fromJson(json.decode(str));

String groupListModelToJson(GroupListModel data) => json.encode(data.toJson());

class GroupListModel {
    GroupListModel({
        this.groupContent,
    });

    List<GroupContent> groupContent;

    factory GroupListModel.fromJson(Map<String, dynamic> json) => GroupListModel(
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
