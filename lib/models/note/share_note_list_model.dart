// To parse this JSON data, do
//
//     final shareNoteListModel = shareNoteListModelFromJson(jsonString);

import 'dart:convert';

ShareNoteListModel shareNoteListModelFromJson(String str) => ShareNoteListModel.fromJson(json.decode(str));

String shareNoteListModelToJson(ShareNoteListModel data) => json.encode(data.toJson());

class ShareNoteListModel {
    ShareNoteListModel({
        this.note,
        this.response,
    });

    List<Note> note;
    bool response;

    factory ShareNoteListModel.fromJson(Map<String, dynamic> json) => ShareNoteListModel(
        note: List<Note>.from(json["note"].map((x) => Note.fromJson(x))),
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "note": List<dynamic>.from(note.map((x) => x.toJson())),
        "response": response,
    };
}

class Note {
    Note({
        this.noteNum,
        this.typeName,
        this.title,
        this.createId,
    });

    int noteNum;
    String typeName;
    String title;
    String createId;

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        noteNum: json["noteNum"],
        typeName: json["typeName"],
        title: json["title"],
        createId: json["createId"],
    );

    Map<String, dynamic> toJson() => {
        "noteNum": noteNum,
        "typeName": typeName,
        "title": title,
        "createId": createId,
    };
}
