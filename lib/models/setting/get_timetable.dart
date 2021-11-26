import 'dart:convert';

GetTimetableModel getTimetableModelFromJson(String str) => GetTimetableModel.fromJson(json.decode(str));

String getTimetableModelToJson(GetTimetableModel data) => json.encode(data.toJson());

class GetTimetableModel {
    GetTimetableModel({
        this.timetable				,
    });
    
    bool timetable		;

    factory GetTimetableModel.fromJson(Map<String, dynamic> json) => GetTimetableModel(
      timetable	: json["timetable	"],
    );

    Map<String, dynamic> toJson() => {
        "timetable	": timetable	,
    };
}

