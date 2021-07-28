// To parse this JSON data, do
//
//     final groupMemberListModel = groupMemberListModelFromJson(jsonString);

import 'dart:convert';

GroupMemberListModel groupMemberListModelFromJson(String str) => GroupMemberListModel.fromJson(json.decode(str));

String groupMemberListModelToJson(GroupMemberListModel data) => json.encode(data.toJson());

class GroupMemberListModel {
    GroupMemberListModel({
        this.founderPhoto,
        this.founderName,
        this.member,
    });

    String founderPhoto;
    String founderName;
    List<Member> member;

    factory GroupMemberListModel.fromJson(Map<String, dynamic> json) => GroupMemberListModel(
        founderPhoto: json["founderPhoto"],
        founderName: json["founderName"],
        member: List<Member>.from(json["member"].map((x) => Member.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "founderPhoto": founderPhoto,
        "founderName": founderName,
        "member": List<dynamic>.from(member.map((x) => x.toJson())),
    };
}

class Member {
    Member({
        this.memberPhoto,
        this.memberName,
        this.statusId,
    });

    String memberPhoto;
    String memberName;
    int statusId;

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        memberPhoto: json["memberPhoto"],
        memberName: json["memberName"],
        statusId: json["statusId"],
    );

    Map<String, dynamic> toJson() => {
        "memberPhoto": memberPhoto,
        "memberName": memberName,
        "statusId": statusId,
    };
}
