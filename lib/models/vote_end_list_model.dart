// To parse this JSON data, do
//
//     final voteEndListModel = voteEndListModelFromJson(jsonString);

import 'dart:convert';

VoteEndListModel voteEndListModelFromJson(String str) => VoteEndListModel.fromJson(json.decode(str));

String voteEndListModelToJson(VoteEndListModel data) => json.encode(data.toJson());

class VoteEndListModel {
    VoteEndListModel({
        this.vote,
        this.response,
    });

    List<Vote> vote;
    bool response;

    factory VoteEndListModel.fromJson(Map<String, dynamic> json) => VoteEndListModel(
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
        this.title,
        this.result,
        this.resultCount,
    });

    String title;
    List<Result> result;
    int resultCount;

    factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        title: json["title"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        resultCount: json["resultCount"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "resultCount": resultCount,
    };
}

class Result {
    Result({
        this.voteResultNum,
        this.resultContent,
    });

    int voteResultNum;
    String resultContent;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        voteResultNum: json["voteResultNum"],
        resultContent: json["resultContent"],
    );

    Map<String, dynamic> toJson() => {
        "voteResultNum": voteResultNum,
        "resultContent": resultContent,
    };
}
