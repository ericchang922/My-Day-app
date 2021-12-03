import 'dart:convert';

GroupStudyplanListModel groupStudyplanListModelFromJson(String str) => GroupStudyplanListModel.fromJson(json.decode(str));

String groupStudyplanListModelToJson(GroupStudyplanListModel data) => json.encode(data.toJson());

class GroupStudyplanListModel {
    GroupStudyplanListModel({
        this.pastStudyplan,
        this.futureStudyplan,
        this.response,
    });

    List<Studyplan> pastStudyplan;
    List<Studyplan> futureStudyplan;
    bool response;

    factory GroupStudyplanListModel.fromJson(Map<String, dynamic> json) => GroupStudyplanListModel(
        pastStudyplan: List<Studyplan>.from(json["pastStudyplan"].map((x) => Studyplan.fromJson(x))),
        futureStudyplan: List<Studyplan>.from(json["futureStudyplan"].map((x) => Studyplan.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "pastStudyplan": List<dynamic>.from(pastStudyplan.map((x) => x.toJson())),
        "futureStudyplan": List<dynamic>.from(futureStudyplan.map((x) => x.toJson())),
        "response": response,
    };
}

class Studyplan {
    Studyplan({
        this.groupNum,
        this.groupName,
        this.studyplanCount,
        this.studyplanContent,
    });

    int groupNum;
    String groupName;
    int studyplanCount;
    List<StudyplanContent> studyplanContent;

    factory Studyplan.fromJson(Map<String, dynamic> json) => Studyplan(
        groupNum: json["groupNum"],
        groupName: json["groupName"],
        studyplanCount: json["studyplanCount"],
        studyplanContent: List<StudyplanContent>.from(json["studyplanContent"].map((x) => StudyplanContent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "groupNum": groupNum,
        "groupName": groupName,
        "studyplanCount": studyplanCount,
        "studyplanContent": List<dynamic>.from(studyplanContent.map((x) => x.toJson())),
    };
}

class StudyplanContent {
    StudyplanContent({
        this.studyplanNum,
        this.title,
        this.date,
        this.startTime,
        this.endTime,
    });

    int studyplanNum;
    String title;
    DateTime date;
    DateTime startTime;
    DateTime endTime;

    factory StudyplanContent.fromJson(Map<String, dynamic> json) => StudyplanContent(
        studyplanNum: json["studyplanNum"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
    );

    Map<String, dynamic> toJson() => {
        "studyplanNum": studyplanNum,
        "title": title,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
    };
}
