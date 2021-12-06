import 'dart:convert';

TemporaryGroupListModel temporaryGroupListModelFromJson(String str) => TemporaryGroupListModel.fromJson(json.decode(str));

String temporaryGroupListModelToJson(TemporaryGroupListModel data) => json.encode(data.toJson());

class TemporaryGroupListModel {
    TemporaryGroupListModel({
        this.temporaryContent,
    });

    List<TemporaryContent> temporaryContent;

    factory TemporaryGroupListModel.fromJson(Map<String, dynamic> json) => TemporaryGroupListModel(
        temporaryContent: List<TemporaryContent>.from(json["temporaryContent"].map((x) => TemporaryContent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "temporaryContent": List<dynamic>.from(temporaryContent.map((x) => x.toJson())),
    };
}

class TemporaryContent {
    TemporaryContent({
        this.groupId,
        this.typeId,
        this.title,
        this.startTime,
        this.endTime,
        this.peopleCount,
    });

    int groupId;
    int typeId;
    String title;
    DateTime startTime;
    DateTime endTime;
    int peopleCount;

    factory TemporaryContent.fromJson(Map<String, dynamic> json) => TemporaryContent(
        groupId: json["groupId"],
        typeId: json["typeId"],
        title: json["title"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        peopleCount: json["peopleCount"],
    );

    Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "typeId": typeId,
        "title": title,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "peopleCount": peopleCount,
    };
}
