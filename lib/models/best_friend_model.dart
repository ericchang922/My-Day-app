// To parse this JSON data, do
//
//     final bestFriendModel = bestFriendModelFromJson(jsonString);

import 'dart:convert';

BestFriendModel bestFriendModelFromJson(String str) => BestFriendModel.fromJson(json.decode(str));

String bestFriendModelToJson(BestFriendModel data) => json.encode(data.toJson());

class BestFriendModel {
    BestFriendModel({
        this.friend,
    });

    List<Friend> friend;

    factory BestFriendModel.fromJson(Map<String, dynamic> json) => BestFriendModel(
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
