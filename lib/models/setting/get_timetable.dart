import 'dart:convert';

GetTimetableModel getTimetableModelFromJson(String str) => GetTimetableModel.fromJson(json.decode(str));

String getTimetableModelToJson(GetTimetableModel data) => json.encode(data.toJson());

class GetTimetableModel {
    GetTimetableModel({
        this.timetable				,
        this.response,
    });
    
    bool timetable		;
    bool response		;

    factory GetTimetableModel.fromJson(Map<String, dynamic> json) => GetTimetableModel(
      timetable	: json["timetable	"],
      response	: json["response	"],
    );

    Map<String, dynamic> toJson() => {
        "timetable	": timetable	,
         "response	": response	,
    };
}

