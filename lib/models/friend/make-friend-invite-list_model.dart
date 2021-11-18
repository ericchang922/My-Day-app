// To parse this JSON data, do
//
//     final friendListModel = friendListModelFromJson(jsonString);

import 'dart:convert';

MakeFriendInviteListModel makefriendinviteListModelFromJson(String str) => MakeFriendInviteListModel.fromJson(json.decode(str));

String makefriendinviteListToJson(MakeFriendInviteListModel data) => json.encode(data.toJson());

class MakeFriendInviteListModel {
    MakeFriendInviteListModel({
        this.friend,
    });

    List<Friend> friend;

    factory MakeFriendInviteListModel.fromJson(Map<String, dynamic> json) => MakeFriendInviteListModel(
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
