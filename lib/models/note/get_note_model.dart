import 'dart:convert';

GetNoteModel getNoteModelFromJson(String str) => GetNoteModel.fromJson(json.decode(str));

String getNoteModelToJson(GetNoteModel data) => json.encode(data.toJson());

class GetNoteModel {
    GetNoteModel({
        this.title,
        this. typeName,
        this.content,
        this.response,
    });

    String title;
    String typeName;
    String content;
    bool response;

    factory GetNoteModel.fromJson(Map<String, dynamic> json) => GetNoteModel(
        title: json["title"],
        typeName: json["typeName"],
        content: json["content"],
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "typeName": typeName,
        "content": content,
        "response": response,
    };
}
