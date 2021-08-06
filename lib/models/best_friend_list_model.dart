// To parse this JSON data, do
//
//     final bestFriendListModel = bestFriendListModelFromJson(jsonString);

import 'dart:convert';

BestFriendListModel bestFriendListModelFromJson(String str) => BestFriendListModel.fromJson(json.decode(str));

String bestFriendListModelToJson(BestFriendListModel data) => json.encode(data.toJson());

class BestFriendListModel {
    BestFriendListModel({
        this.friend,
    });

    List<Friend> friend;

    factory BestFriendListModel.fromJson(Map<String, dynamic> json) => BestFriendListModel(
        friend: List<Friend>.from(json["friend"].map((x) => Friend.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "friend": List<dynamic>.from(friend.map((x) => x.toJson())),
    };
}

class Friend {
    Friend({
        this.photo,
        this.friendId,
        this.friendName,
    });

    String photo;
    String friendId;
    String friendName;

    factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        photo: json["photo"],
        friendId: json["friendId"],
        friendName: json["friendName"],
    );

    Map<String, dynamic> toJson() => {
        "photo": photo,
        "friendId": friendId,
        "friendName": friendName,
    };
}
