import 'dart:convert';

GetVoteModel getVoteModelFromJson(String str) => GetVoteModel.fromJson(json.decode(str));

String getVoteModelToJson(GetVoteModel data) => json.encode(data.toJson());

class GetVoteModel {
    GetVoteModel({
        this.title,
        this.founderId,
        this.founderName,
        this.optionTypeId,
        this.voteItems,
        this.addItemPermit,
        this.deadline,
        this.anonymous,
        this.chooseVoteQuantity,
        this.voteCount,
        this.response,
    });

    String title;
    String founderId;
    String founderName;
    int optionTypeId;
    List<VoteItem> voteItems;
    bool addItemPermit;
    String deadline;
    bool anonymous;
    int chooseVoteQuantity;
    int voteCount;
    bool response;

    factory GetVoteModel.fromJson(Map<String, dynamic> json) => GetVoteModel(
        title: json["title"],
        founderId: json["founderId"],
        founderName: json["founderName"],
        optionTypeId: json["optionTypeId"],
        voteItems: List<VoteItem>.from(json["voteItems"].map((x) => VoteItem.fromJson(x))),
        addItemPermit: json["addItemPermit"],
        deadline: json["deadline"],
        anonymous: json["anonymous"],
        chooseVoteQuantity: json["chooseVoteQuantity"],
        voteCount: json["voteCount"],
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "founderId": founderId,
        "founderName": founderName,
        "optionTypeId": optionTypeId,
        "voteItems": List<dynamic>.from(voteItems.map((x) => x.toJson())),
        "addItemPermit": addItemPermit,
        "deadline": deadline,
        "anonymous": anonymous,
        "chooseVoteQuantity": chooseVoteQuantity,
        "voteCount": voteCount,
        "response": response,
    };
}

class VoteItem {
    VoteItem({
        this.voteItemNum,
        this.voteItemName,
        this.voteItemCount,
        this.isVote,
    });

    int voteItemNum;
    String voteItemName;
    int voteItemCount;
    bool isVote;

    factory VoteItem.fromJson(Map<String, dynamic> json) => VoteItem(
        voteItemNum: json["voteItemNum"],
        voteItemName: json["voteItemName"],
        voteItemCount: json["voteItemCount"],
        isVote: json["isVote"],
    );

    Map<String, dynamic> toJson() => {
        "voteItemNum": voteItemNum,
        "voteItemName": voteItemName,
        "voteItemCount": voteItemCount,
        "isVote": isVote,
    };
}
