// To parse this JSON data, do
//
//     final voteListModel = voteListModelFromJson(jsonString);

import 'dart:convert';

VoteListModel voteListModelFromJson(String str) => VoteListModel.fromJson(json.decode(str));

String voteListModelToJson(VoteListModel data) => json.encode(data.toJson());

class VoteListModel {
    VoteListModel({
        this.vote,
        this.response,
    });

    List<Vote> vote;
    bool response;

    factory VoteListModel.fromJson(Map<String, dynamic> json) => VoteListModel(
        vote: List<Vote>.from(json["vote"].map((x) => Vote.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "vote": List<dynamic>.from(vote.map((x) => x.toJson())),
        "response": response,
    };
}

class Vote {
    Vote({
        this.voteNum,
        this.votersNum,
        this.title,
        this.isVoteType,
    });

    int voteNum;
    int votersNum;
    String title;
    bool isVoteType;

    factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        voteNum: json["voteNum"],
        votersNum: json["votersNum"],
        title: json["title"],
        isVoteType: json["isVoteType"],
    );

    Map<String, dynamic> toJson() => {
        "voteNum": voteNum,
        "votersNum": votersNum,
        "title": title,
        "isVoteType": isVoteType,
    };
}
