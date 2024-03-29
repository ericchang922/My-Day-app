import 'dart:convert';

GetTemporaryGroupInviteModel getTemporaryGroupInvitetModelFromJson(String str) => GetTemporaryGroupInviteModel.fromJson(json.decode(str));

String getTemporaryGroupInvitetModelToJson(GetTemporaryGroupInviteModel data) => json.encode(data.toJson());

class GetTemporaryGroupInviteModel {
    GetTemporaryGroupInviteModel({
        this.title,
        this.startTime,
        this.endTime,
        this.founderPhoto,
        this.founderName,
        this.member,
    });

    String title;
    DateTime startTime;
    DateTime endTime;
    String founderPhoto;
    String founderName;
    List<Member> member;

    factory GetTemporaryGroupInviteModel.fromJson(Map<String, dynamic> json) => GetTemporaryGroupInviteModel(
        title: json["title"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        founderPhoto: json["founderPhoto"],
        founderName: json["founderName"],
        member: List<Member>.from(json["member"].map((x) => Member.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
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
