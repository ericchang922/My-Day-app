// To parse this JSON data, do
//
//     final getNoteModel = getNoteModelFromJson(jsonString);

import 'dart:convert';

GetNoteModel getNoteModelFromJson(String str) => GetNoteModel.fromJson(json.decode(str));

String getNoteModelToJson(GetNoteModel data) => json.encode(data.toJson());

class GetNoteModel {
    GetNoteModel({
        this.title,
        this.content,
        this.response,
    });

    String title;
    String content;
    bool response;

    factory GetNoteModel.fromJson(Map<String, dynamic> json) => GetNoteModel(
        title: json["title"],
        content: json["content"],
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "response": response,
    };
}
