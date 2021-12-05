import 'dart:convert';

GroupInviteListModel groupInviteListModelFromJson(String str) => GroupInviteListModel.fromJson(json.decode(str));

String groupInviteListModelToJson(GroupInviteListModel data) => json.encode(data.toJson());

class GroupInviteListModel {
    GroupInviteListModel({
        this.groupContent,
    });

    List<GroupContent> groupContent;

    factory GroupInviteListModel.fromJson(Map<String, dynamic> json) => GroupInviteListModel(
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
