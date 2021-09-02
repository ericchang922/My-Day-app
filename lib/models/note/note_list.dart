// To parse this JSON data, do
//
//     final noteListModel = noteListModelFromJson(jsonString);

import 'dart:convert';

NoteListModel noteListModelFromJson(String str) => NoteListModel.fromJson(json.decode(str));

String noteListModelToJson(NoteListModel data) => json.encode(data.toJson());

class NoteListModel {
    NoteListModel({
        this.note,
        this.response,
    });

    List<Note> note;
    bool response;

    factory NoteListModel.fromJson(Map<String, dynamic> json) => NoteListModel(
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
    });

    int noteNum;
    String typeName;
    String title;

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        noteNum: json["noteNum"],
        typeName: json["typeName"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "noteNum": noteNum,
        "typeName": typeName,
        "title": title,
    };
}
