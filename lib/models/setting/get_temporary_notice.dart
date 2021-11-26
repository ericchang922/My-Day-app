import 'dart:convert';

GetTimetableNoticeModel getTimetableNoticeModelFromJson(String str) => GetTimetableNoticeModel.fromJson(json.decode(str));

String getTimetableNoticeModelToJson(GetTimetableNoticeModel data) => json.encode(data.toJson());

class GetTimetableNoticeModel {
    GetTimetableNoticeModel({
        this.temporarynotice				,
    });
    
    bool temporarynotice		;

    factory GetTimetableNoticeModel.fromJson(Map<String, dynamic> json) => GetTimetableNoticeModel(
      temporarynotice	: json["temporarynotice	"],
    );

    Map<String, dynamic> toJson() => {
        "temporarynotice	": temporarynotice	,
    };
}

