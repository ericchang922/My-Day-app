// To parse this JSON data, do
//
//     final friendModel = friendModelFromJson(jsonString);

import 'dart:convert';

FriendModel friendModelFromJson(String str) => FriendModel.fromJson(json.decode(str));

String friendModelToJson(FriendModel data) => json.encode(data.toJson());

class FriendModel {
    FriendModel({
        this.friend,
    });

    List<Friend> friend;

    factory FriendModel.fromJson(Map<String, dynamic> json) => FriendModel(
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
        this.relationId,
    });

    String photo;
    String friendId;
    String friendName;
    int relationId;

    factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        photo: json["photo"],
        friendId: json["friendId"],
        friendName: json["friendName"],
        relationId: json["relationId"],
    );

    Map<String, dynamic> toJson() => {
        "photo": photo,
        "friendId": friendId,
        "friendName": friendName,
        "relationId": relationId,
    };
}
