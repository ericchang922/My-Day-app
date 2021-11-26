import 'dart:convert';

GetFriendPrivacyModel getFriendPrivacyModelFromJson(String str) => GetFriendPrivacyModel.fromJson(json.decode(str));

String getFriendPrivacyModelToJson(GetFriendPrivacyModel data) => json.encode(data.toJson());

class GetFriendPrivacyModel {
    GetFriendPrivacyModel({
        this.isPublicTimetable,
        this.isTemporaryGroup,
    });
    
    bool isPublicTimetable;
    bool isTemporaryGroup;

    factory GetFriendPrivacyModel.fromJson(Map<String, dynamic> json) => GetFriendPrivacyModel(
      isPublicTimetable : json["isPublicTimetable"],
      isTemporaryGroup : json["isTemporaryGroup"],
    );

    Map<String, dynamic> toJson() => {
        "isPublicTimetable": isPublicTimetable,
        "isTemporaryGroup": isTemporaryGroup,
    };
}

