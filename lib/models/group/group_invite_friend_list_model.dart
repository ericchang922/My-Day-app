import 'dart:convert';

GroupInviteFriendListModel groupInviteFriendListModelFromJson(String str) => GroupInviteFriendListModel.fromJson(json.decode(str));

String groupInviteFriendListModelToJson(GroupInviteFriendListModel data) => json.encode(data.toJson());

class GroupInviteFriendListModel {
    GroupInviteFriendListModel({
        this.friend,
        this.response,
    });

    List<Friend> friend;
    bool response;

    factory GroupInviteFriendListModel.fromJson(Map<String, dynamic> json) => GroupInviteFriendListModel(
        friend: List<Friend>.from(json["friend"].map((x) => Friend.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "friend": List<dynamic>.from(friend.map((x) => x.toJson())),
        "response": response,
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
