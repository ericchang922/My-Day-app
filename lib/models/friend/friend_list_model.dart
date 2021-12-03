import 'dart:convert';

FriendListModel friendListModelFromJson(String str) => FriendListModel.fromJson(json.decode(str));

String friendListModelToJson(FriendListModel data) => json.encode(data.toJson());

class FriendListModel {
    FriendListModel({
        this.friend,
    });

    List<Friend> friend;

    factory FriendListModel.fromJson(Map<String, dynamic> json) => FriendListModel(
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
