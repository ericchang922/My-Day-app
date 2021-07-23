// To parse this JSON data, do
//
//     final getGroupModel = getGroupModelFromJson(jsonString);

import 'dart:convert';

GetGroupModel getGroupModelFromJson(String str) => GetGroupModel.fromJson(json.decode(str));

String getGroupModelToJson(GetGroupModel data) => json.encode(data.toJson());

class GetGroupModel {
    GetGroupModel({
        this.title,
        this.typeId,
        this.vote,
    });

    String title;
    int typeId;
    List<Vote> vote;

    factory GetGroupModel.fromJson(Map<String, dynamic> json) => GetGroupModel(
        title: json["title"],
        typeId: json["typeId"],
        vote: List<Vote>.from(json["vote"].map((x) => Vote.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "typeId": typeId,
        "vote": List<dynamic>.from(vote.map((x) => x.toJson())),
    };
}

class Vote {
    Vote({
        this.title,
        this.voteNum,
        this.isVoteType,
    });

    String title;
    int voteNum;
    bool isVoteType;

    factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        title: json["title"],
        voteNum: json["voteNum"],
        isVoteType: json["isVoteType"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "voteNum": voteNum,
        "isVoteType": isVoteType,
    };
}
