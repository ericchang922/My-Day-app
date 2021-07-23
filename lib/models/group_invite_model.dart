// To parse this JSON data, do
//
//     final groupInviteModel = groupInviteModelFromJson(jsonString);

import 'dart:convert';

GroupInviteModel groupInviteModelFromJson(String str) => GroupInviteModel.fromJson(json.decode(str));

String groupInviteModelToJson(GroupInviteModel data) => json.encode(data.toJson());

class GroupInviteModel {
    GroupInviteModel({
        this.groupContent,
    });

    List<GroupContent> groupContent;

    factory GroupInviteModel.fromJson(Map<String, dynamic> json) => GroupInviteModel(
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
        this.inviterPhoto,
        this.inviterName,
    });

    int groupId;
    String title;
    int typeId;
    String inviterPhoto;
    String inviterName;

    factory GroupContent.fromJson(Map<String, dynamic> json) => GroupContent(
        groupId: json["groupId"],
        title: json["title"],
        typeId: json["typeId"],
        inviterPhoto: json["inviterPhoto"],
        inviterName: json["inviterName"],
    );

    Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "title": title,
        "typeId": typeId,
        "inviterPhoto": inviterPhoto,
        "inviterName": inviterName,
    };
}
